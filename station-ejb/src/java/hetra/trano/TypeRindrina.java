package hetra.trano;

import java.sql.Connection;
import java.sql.Date;

import bean.CGenUtil;
import bean.ClassMAPTable;

public class TypeRindrina extends ClassMAPTable{
    String id_type_rindrina,nom;
    int coefficient;
    
    public String getId_type_rindrina() {
        return id_type_rindrina;
    }

    public void setId_type_rindrina(String id) {
        this.id_type_rindrina = id;
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

    public TypeRindrina () {
        this.setNomTable("type_rindrina");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("RN", "seq_type_rindrina");
        this.setId_type_rindrina(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return this.getId_type_rindrina();
    }

    @Override
    public String getTuppleID() {
        return "id_type_rindrina";
    }

    public TypeRindrina getCoef(Date date, Connection c) throws Exception {
        String query = "select * from type_rindrina_coefficient where dates <= ? order by dates desc";
        return (TypeRindrina) CGenUtil.rechercher(this,query, c)[0];
    }
}
