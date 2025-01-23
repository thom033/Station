package hetra.paiement;

import java.sql.Connection;
import java.sql.Date;
import bean.ClassMAPTable;

public class CalculHetraPaiement extends ClassMAPTable {
    private String id_maison;
    private String nom_maison;
    private double hetra;
    private int mois;
    private int annee;
    private Date date_paiement;

    public CalculHetraPaiement() {
        this.setNomTable("calcul_hetra_paiement");
    }

    // Getters and Setters
    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String id_maison) {
        this.id_maison = id_maison;
    }

    public String getNom_maison() {
        return nom_maison;
    }   

    public void setNom_maison(String nomMaison) {
        this.nom_maison = nomMaison;
    }

    public double getHetra() {
        return hetra;
    }

    public void setHetra(double hetra) {
        this.hetra = hetra;
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

    public Date getDate_paiement() {
        return date_paiement;
    }

    public void setDate_paiement(Date datePaiement) {
        this.date_paiement = datePaiement;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CHP", "seq_calculHetraPaiement");
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