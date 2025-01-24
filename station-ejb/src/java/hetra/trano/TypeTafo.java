package hetra.trano;

import java.sql.Connection;
import java.sql.Date;

import bean.CGenUtil;
import bean.ClassMAPTable;

public class TypeTafo extends ClassMAPTable{
    String id_type_tafo,nom;
    double coefficient;

    public String getId_type_tafo() {
        return id_type_tafo;
    }

    public void setId_type_tafo(String id) {
        this.id_type_tafo = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(double coefficient) {
        this.coefficient = coefficient;
    }

    public TypeTafo () {
        this.setNomTable("type_tafo");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TF", "seq_type_tafo");
        this.setId_type_tafo(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return this.getId_type_tafo();
    }

    @Override
    public String getTuppleID() {
        return "id_type_tafo";
    }
    public TypeRindrina getCoef(Date date, Connection c) throws Exception {
        String query = "select * from type_tafo_coefficient where dates <= ? order by dates desc";
        return (TypeRindrina) CGenUtil.rechercher(this,query, c)[0];
    }
}
