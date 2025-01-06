package venteLubrifiant;

import java.sql.Connection;
import java.sql.Date;

import bean.CGenUtil;
import bean.ClassMAPTable;
import user.UserEJB;
import user.UserEJBClient;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import vente.InsertionVente;
import vente.Vente;
import vente.VenteDetails;

public class PrelevementLub extends ClassMAPTable{
    String id , idPompiste , idMagasin , idProduit , idPrelevementAnterieur , heure;
    Date daty;
    double qte ; 
    double pu;

    public double getPu() {
        return this.pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }
    
    public PrelevementLub() {
        super.setNomTable("PrelevementLub");
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId(){
        return id;
    }

    public void setIdPompiste(String idPompiste) {
        this.idPompiste = idPompiste;
    }

    public String getIdPompiste(){
        return idPompiste;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdMagasin(){
        return idMagasin;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public String getIdProduit(){
        return idProduit;
    }

    public void setIdPrelevementAnterieur(String idPrelevementAnterieur) {
        this.idPrelevementAnterieur = idPrelevementAnterieur;
    }

    
    public String getHeure() {
        return this.heure;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }

    public String getIdPrelevementAnterieur(){
        return idPrelevementAnterieur;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Date getDaty(){
        return daty;
    }

    public void setQte(double qte) {
        this.qte = qte;
    }

    public double getQte(){
        return qte;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PRLVLUB", "GETSEQPRELEVEMENTLUB");
        this.setId(makePK(c));
    }

    public PrelevementLub getPrelevementAnterieur() throws Exception{
        Connection c = new UtilDB().GetConn("gallois" , "gallois");
        try {     
            PrelevementLub[] p = ((PrelevementLub[])(CGenUtil.rechercher(new PrelevementLub(), null, null, "and idMagasin ='"+getIdMagasin()+"' and idProduit='"+getIdProduit()+"' ORDER BY TO_DATE(TO_CHAR(DATY, 'YYYY-MM-DD') || ' ' || HEURE , 'YYYY-MM-DD HH24:MI') DESC")));
            if(p.length > 0){
                return p[0];
            }
    
            return null;
        } catch (Exception e) {
            throw e;
        }finally{
            c.close();
        }
    }

    // on appelle cette fonction quand le prelevement est deja insere
    public boolean isVente(Connection c) throws Exception{
        try {
            PrelevementLub[] p = ((PrelevementLub[])(CGenUtil.rechercher(new PrelevementLub(), null, null,c, "and idMagasin ='"+getIdMagasin()+"' and idProduit='"+getIdProduit()+"'")));
            return p.length % 2 == 0 && p.length != 0;
        } catch (Exception e) {
            throw e;
        }
    }

    public InsertionVente genererVente (Connection c)throws Exception{
        InsertionVente vente = new InsertionVente();

        vente.setDaty(Utilitaire.dateDuJourSql());
        vente.setDesignation("Vente de lubrifiant de station le "+ getDaty());
        vente.setIdMagasin(getIdMagasin());
        vente.setIdClient("CLI000054");
        return vente;
    }
    
    public VenteDetails generateVenteDetails()throws Exception{
        VenteDetails venteDetails = new VenteDetails();
        venteDetails.setIdProduit(getIdProduit());
        venteDetails.setQte(getQte());
        venteDetails.setPu(getPu());
        venteDetails.setTva(0);
        venteDetails.setIdDevise("AR");
        venteDetails.setTauxDeChange(1);
        venteDetails.setCompte("712000");
        
        return venteDetails;
    }

    public Vente persistVente(PrelevementLub anterieur , Connection c)throws Exception{
        try {     
            c = new UtilDB().GetConn("gallois" , "gallois");
            c.setAutoCommit(false);

            if (isVente(c) && anterieur != null){

                InsertionVente vente = genererVente(c);
    
                VenteDetails[] venteDetails = new VenteDetails[1];
                VenteDetails venteDetail = generateVenteDetails();

                double quantity = anterieur.getQte() - getQte();

                if (quantity == 0){
                    return null;
                }

                if (quantity < 0){
                    c.rollback();
                    throw new Exception("Le stock a augmente?");  
                }

                venteDetail.setQte(quantity);

                venteDetails[0] = venteDetail;
    
                UserEJB userEJBBean = UserEJBClient.lookupUserEJBBeanLocal();
    
                userEJBBean.createObjectMultipleGallois(vente, "idVente", venteDetails , c);
                vente.validerObject("1060", c);
                vente.payer("1060", c);
                
                c.commit();
                return vente;
            }
        } catch (Exception e) {
            throw e;
        }finally{
            if (c != null) c.close();
        }

        return null;
    }
}
