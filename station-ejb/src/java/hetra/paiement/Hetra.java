package hetra.paiement;

import java.sql.Connection;
import java.sql.Date;

import bean.CGenUtil;
import bean.ClassMAPTable;

public class Hetra extends ClassMAPTable {
    String id_prix,id_commune;
    double valeur;
    int mois, annee;

    public String getId_prix() {
        return id_prix;
    }

    public void setId_prix(String id_prix) {
        this.id_prix = id_prix;
    }

    public String getId_commune() {
        return id_commune;
    }

    public void setId_commune(String id_commune) {
        this.id_commune = id_commune;
    }

    public double getValeur() {
        return valeur;
    }

    public void setValeur(double valeur) {
        this.valeur = valeur;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    @Override
    public String getAttributIDName() {
        return "id_prix";
    }

    @Override
    public String getTuppleID() {
        return this.getId_prix();
    }

    public Hetra(){
        setNomTable("prix_impot");
    }
    public Hetra getByDates(Date date, Connection c) throws Exception{
        int mois =  date.toLocalDate().getMonthValue();
        int annee = date.toLocalDate().getYear();
        String query = "SELECT * FROM prix_impot WHERE mois <= "+ mois  +" AND annee <= " +annee+ " ORDER BY annee DESC, mois DESC";
        
        return (Hetra) CGenUtil.rechercher(this, query, c) [0];
    }

    
}
