package hetra.trano;

import java.sql.Connection;

import bean.ClassMere;

public class Mainson extends ClassMere {
    String id, nom;
    double longueur, largeur;
    int etage;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
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

    public int getEtage() {
        return etage;
    }

    public void setEtage(int etage) {
        this.etage = etage;
    }
    public Mainson () {
        this.setNomTable("Mainson");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TR", "get_seq_maison");
        this.setId(makePK(c));
    }
    

    @Override
    public String getAttributIDName() {
        return this.getId();
    }

    @Override
    public String getTuppleID() {
        return "id";
    }
    
}
