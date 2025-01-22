package hetra.carte;

import java.util.List;

import bean.ClassMAPTable;

public class Arrondissement extends ClassMAPTable {
    String id_arrondissement, nom;
    double total_paye;
    double total_reste;
    List<String> position_polygone;
    
    public String getId_arrondissement() {
        return id_arrondissement;
    }

    public void setId_arrondissement(String id_arrondissement) {
        this.id_arrondissement = id_arrondissement;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getTotal_paye() {
        return total_paye;
    }

    public void setTotal_paye(double total_paye) {
        this.total_paye = total_paye;
    }

    public double getTotal_reste() {
        return total_reste;
    }

    public void setTotal_reste(double total_reste) {
        this.total_reste = total_reste;
    }
    public Arrondissement() {
        this.setNomTable("arrondissement");
    }

    @Override
    public String getAttributIDName() {
        return "id_arrondissement";
    }

    @Override
    public String getTuppleID() {
        return this.getId_arrondissement();
    }
    
}