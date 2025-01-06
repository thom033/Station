<%-- 
    Document   : prevision-liste-recette
    Created on : 28 août 2024, 16:58:43
    Author     : Mendrika
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.*"%>
<%@page import="prevision.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    try{
        PrevisionComplet prev = new PrevisionComplet();
        prev.setNomTable("PREVISION_COMPLET_CPL_REC");
        String[] intervalles = {"daty"};
        String[] criteres = {"id", "designation", "daty"};
        String[] libEntete = {"id", "daty", "designation", "credit", "effectifCredit", "recetteEcart"};
        String[] libEnteteAffiche = {"id","Date", "D&eacute;signation", "Prevision", "Effectif", "Ecart"};
        PageRecherche pr = new PageRecherche( prev, request, criteres, intervalles, 3, libEntete, libEntete.length );
    
        pr.setTitre("Liste des Previsions de recette");
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
    
        pr.setApres("prevision/prevision-liste.jsp");
        String[] colSomme = {"credit", "effectifCredit"};
        pr.creerObjetPage(libEntete, colSomme);
        
        pr.getFormu().getChamp("id").setLibelle("ID");
        pr.getFormu().getChamp("daty1").setLibelle("Date Debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date Fin");
        pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    
        //Definition des lienTableau et des colonnes de lien
        String lienTableau[] = {pr.getLien() + "?but=prevision/prevision-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>  


<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="vente" id="vente">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>


<% }catch(Exception e){
    e.printStackTrace();
}
%>


