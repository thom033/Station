package hetra.trano;

import java.sql.Connection;

import bean.ClassMAPTable;

public class SumHetraMaison extends ClassMAPTable {
    private String id_maison;
    private String non_maison;
    private double total_paye;
    private double total_non_paye;

    public SumHetraMaison() {
        this.setNomTable("sum_hetra_maison");
    }

    // Getters and Setters
    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String idMaison) {
        this.id_maison = idMaison;
    }

    public String getNom_maison() {
        return non_maison;
    }

    public void setNom_maison(String nomMaison) {
        this.non_maison = nomMaison;
    }

    public double getTotal_paye() {
        return total_paye;
    }

    public void setTotal_paye(double totalPaye) {
        this.total_paye = totalPaye;
    }

    public double getTotal_non_paye() {
        return total_non_paye;
    }

    public void setTotal_non_paye(double totalNonPaye) {
        this.total_non_paye = totalNonPaye;
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