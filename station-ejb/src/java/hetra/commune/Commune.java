package hetra.commune;

import bean.ClassMAPTable;

public class Commune extends ClassMAPTable {
    String id_commune, nom;
    Mainson[] maisons;
    public Mainson[] getMaisons() {
        return maisons;
    }
    public void setMaisons(Mainson[] maisons) {
        this.maisons = maisons;
    }
    public String getId_commune() {
        return id_commune;
    }

    public void setId_commune(String id_commune) {
        this.id_commune = id_commune;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
    public Commune (){
        this.setNomTable("commune");
    }

    @Override
    public String getAttributIDName() {
        // TODO Auto-generated method stub
        return "id_commune";
    }

    @Override
    public String getTuppleID() {
        // TODO Auto-generated method stub
        return this.id_commune;
    }
    
}
