package hetra.trano;

import java.sql.Connection;

import bean.ClassMAPTable;

public class TypeTafo extends ClassMAPTable{
    String id,nom;
    int coefficient;

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

    public int getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(int coefficient) {
        this.coefficient = coefficient;
    }

    public TypeTafo () {
        this.setNomTable("type_tafo");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TF", "seq_type_tafo");
        this.setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return this.getId();
    }

    @Override
    public String getTuppleID() {
        return "id_type_tafo";
    }
}
