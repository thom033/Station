package hetra.trano;

import java.sql.Connection;

import bean.ClassMAPTable;

public class CalculHetraMaison extends ClassMAPTable{
    private String id_maison, nom_maison;
    private double surface,coefficient_rindrina,coefficient_tafo,prix_par_m2,hetra;

    public CalculHetraMaison() {
        this.setNomTable("calcul_hetra_maison");
    }

    // Getters and Setters
    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String idMaison) {
        this.id_maison = idMaison;
    }

    public String getNom_maison() {
        return nom_maison;
    }

    public void setNom_maison(String nomMaison) {
        this.nom_maison = nomMaison;
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }

    public double getCoefficient_rindrina() {
        return coefficient_rindrina;
    }

    public void setCoefficient_rindrina(double coefficient_rindrina) {
        this.coefficient_rindrina = coefficient_rindrina;
    }

    public double getCoefficient_tafo() {
        return coefficient_tafo;
    }

    public void setCoefficient_tafo(double coefficient_tafo) {
        this.coefficient_tafo = coefficient_tafo;
    }

    public double getPrix_par_m2() {
        return prix_par_m2;
    }

    public void setPrix_par_m2(double prix_par_m2) {
        this.prix_par_m2 = prix_par_m2;
    }

    public double getHetra() {
        return hetra;
    }

    public void setHetra(double hetra) {
        this.hetra = hetra;
    }

    @Override
    public String getAttributIDName() {
        return this.getId_maison();
    }

    @Override
    public String getTuppleID() {
        return "id_maison";
    }

}