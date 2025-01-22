package hetra.trano;

import java.sql.Connection;

import bean.ClassMAPTable;

public class MaisonDetails extends ClassMAPTable {
    String id_maison_detaills, id_maison;
    String id_type_tafo, id_type_rindrina;
    public String getId_type_tafo() {
        return id_type_tafo;
    }

    public void setId_type_tafo(String id_type_tafo) {
        this.id_type_tafo = id_type_tafo;
    }

    public String getId_type_rindrina() {
        return id_type_rindrina;
    }

    public void setId_type_rindrina(String id_type_rindrina) {
        this.id_type_rindrina = id_type_rindrina;
    }

    public String getId_maison_detaills() {
        return id_maison_detaills;
    }

    public void setId_maison_detaills(String id_maison_detaills) {
        this.id_maison_detaills = id_maison_detaills;
    }

    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String id_maison) {
        this.id_maison = id_maison;
    }

    public MaisonDetails() {
        this.setNomTable("MAISON_DETAILLS");
    }
    public MaisonDetails(String type_tafo, String type_rindrina) {
        this();
        this.id_type_tafo = type_tafo;
        this.id_type_rindrina = type_rindrina;
    }


    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MD", "get_seq_maison_detaills");
        this.setId_maison_detaills(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id_maison_detaills";
    }

    @Override
    public String getTuppleID() {
        return this.id_maison_detaills;
    }
    
}
