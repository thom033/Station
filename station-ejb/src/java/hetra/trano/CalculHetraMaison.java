package hetra.trano;

import java.io.Serializable;

public class CalculHetraMaison extends classMAPTable{
    private String idMaison, nomMaison;
    private double surface,coefficientRindrina,coefficientTafo,prixParM2,hetra;

    public CalculHetraMaison() {
        // Default constructor
    }

    // Getters and Setters
    public String getIdMaison() {
        return idMaison;
    }

    public void setIdMaison(String idMaison) {
        this.idMaison = idMaison;
    }

    public String getNomMaison() {
        return nomMaison;
    }

    public void setNomMaison(String nomMaison) {
        this.nomMaison = nomMaison;
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }

    public double getCoefficientRindrina() {
        return coefficientRindrina;
    }

    public void setCoefficientRindrina(double coefficientRindrina) {
        this.coefficientRindrina = coefficientRindrina;
    }

    public double getCoefficientTafo() {
        return coefficientTafo;
    }

    public void setCoefficientTafo(double coefficientTafo) {
        this.coefficientTafo = coefficientTafo;
    }

    public double getPrixParM2() {
        return prixParM2;
    }

    public void setPrixParM2(double prixParM2) {
        this.prixParM2 = prixParM2;
    }

    public double getHetra() {
        return hetra;
    }

    public void setHetra(double hetra) {
        this.hetra = hetra;
    }
}