package hetra.paiement;

import java.sql.Connection;
import java.sql.Date;
import bean.ClassMAPTable;

public class Paiement extends ClassMAPTable {
    String id;
    String id_maison;
    int mois;
    int annee;
    Date date_paiement;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String id_maison) {
        this.id_maison = id_maison;
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

    public void setDate_paiement(Date dates) {
        this.date_paiement = dates;
    }

    public Paiement() {
        this.setNomTable("paiement");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("P", "seq_paiement");
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