package hetra.trano;

import java.sql.Connection;

import bean.ClassMAPTable;

public class CalculHetraMaison extends ClassMAPTable{
    private String idMaison, nomMaison;
    private double surface,coefficientRindrina,coefficientTafo,prixParM2,hetra;

    public CalculHetraMaison() {
        this.setNomTable("calcul_hetra_maison");
    }

    // Getters and Setters
    public String getId_maison() {
        return idMaison;
    }

    public void setId_maison(String idMaison) {
        this.idMaison = idMaison;
    }

    public String getNom_maison() {
        return nomMaison;
    }

    public void setNom_maison(String nomMaison) {
        this.nomMaison = nomMaison;
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }

    public double getCoefficient_rindrina() {
        return coefficientRindrina;
    }

    public void setCoefficient_rindrina(double coefficientRindrina) {
        this.coefficientRindrina = coefficientRindrina;
    }

    public double getCoefficient_tafo() {
        return coefficientTafo;
    }

    public void setCoefficient_tafo(double coefficientTafo) {
        this.coefficientTafo = coefficientTafo;
    }

    public double getPrix_par_m2() {
        return prixParM2;
    }

    public void setPrix_par_m2(double prixParM2) {
        this.prixParM2 = prixParM2;
    }

    public double getHetra() {
        return hetra;
    }

    public void setHetra(double hetra) {
        this.hetra = hetra;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CHM", "seq_calculHetraMaison");
        this.setId_maison(makePK(c));
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