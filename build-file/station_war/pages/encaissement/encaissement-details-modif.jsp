<%-- 
    Document   : encaissement-prelevement-modif
    Created on : 12 avr. 2024, 08:38:57
    Author     : Angela
--%>

<%@page import="encaissement.EncaissementDetails"%>
<%@page import="caisse.CategorieCaisse"%>
<%@page import="encaissement.EncaissementTemp"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%> 
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    try{
    //Variable de navigation
    String classeMere = "encaissement.EncaissementTemp";     
    String classeFille = "encaissement.EncaissementDetails";
    String tab="prelevement-liste";
    String butApresPost = "encaissement/encaissement-fiche.jsp&tab="+tab;
    String colonneMere = "idEncaissement";
    //Definition de l'affichage
    String id = request.getParameter("id");
    EncaissementTemp mere = new EncaissementTemp();
    mere.setNomTable("Encaissement");
    EncaissementDetails fille = new EncaissementDetails();
    fille.setIdEncaissement(id);
    EncaissementDetails[] details = (EncaissementDetails[])CGenUtil.rechercher(fille, null, null, "and idEncaissement = '"+ id + "'"); 
    int nombreLigne = details.length + 2;
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), 2);
    //Information globale
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idCaisse").setVisible(false);
    pi.getFormu().getChamp("designation").setVisible(false);
    pi.getFormu().getChamp("daty").setVisible(false);
  
    affichage.Liste[] liste = new Liste[1];
    CategorieCaisse categ = new CategorieCaisse();
    categ.setNomTable("CategorieCaisse");
    liste[0] = new Liste("idCategorieCaisse",categ,"val","id");
    pi.getFormufle().changerEnChamp(liste);
    pi.getFormufle().getChamp("idCategorieCaisse_0").setLibelle("Categorie Caisse");
    pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    pi.getFormufle().getChampMulitple("idEncaissement").setVisible(false);
//Preparer affichage
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1>Modification vente</h1>
                    </div>
                    <div class="box-body">
                        <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">
                                <%
                                    out.println(pi.getFormufle().getHtmlTableauInsert());
                                %>
                            </div>
                        </div>           
                        <input name="acte" type="hidden" id="acte" value="updateInsert">
                        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">  
                        <input name="liaisonMere" type="hidden" id="liaisonMere" value="<%= colonneMere %>">        
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>


