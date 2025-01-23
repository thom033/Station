package hetra.trano;

import java.sql.Connection;

import bean.ClassMAPTable;

public class MaisonDetails extends ClassMAPTable {
    String id_maison_details, id_maison, id_type_tafo, id_type_rindrina;
    int nb_etages;
    double longueur,largeur;

    //getters and setters
    public String getId_maison_details() {
        return id_maison_details;
    }

    public void setId_maison_details(String id_maison_details) {
        this.id_maison_details = id_maison_details;
    }

    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String id_maison) {
        this.id_maison = id_maison;
    }

    public String getId_type_tafo() {
        return id_type_tafo;
    }

    public void setId_type_tafo(String id_type_tafo) {
        this.id_type_tafo = id_type_tafo;
    }

    public String getId_type_rindrina() {
        return id_type_rindrina;
    }

    public void setId_type_rindrina(String id_type_rindrina) {
        this.id_type_rindrina = id_type_rindrina;
    }

    public int getNb_etages() {
        return nb_etages;
    }

    public void setNb_etages(int nb_etages) {
        this.nb_etages = nb_etages;
    }

    public double getLongueur() {
        return longueur;
    }

    public void setLongueur(double longueur) {
        this.longueur = longueur;
    }

    public double getLargeur() {
        return largeur;
    }

    public void setLargeur(double largeur) {
        this.largeur = largeur;
    }
    
    public MaisonDetails() {
        this.setNomTable("MAISON_DETAILLS");
    }
    public MaisonDetails(String type_tafo, String type_rindrina) {
        this();
        this.id_type_tafo = type_tafo;
        this.id_type_rindrina = type_rindrina;
    }


    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MD", "get_seq_maison_detaills");
        this.setId_maison_details(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id_maison_detaills";
    }

    @Override
    public String getTuppleID() {
        return this.id_maison_details;
    }
    
}
