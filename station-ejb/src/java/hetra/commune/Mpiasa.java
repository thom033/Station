package hetra.commune;

import java.sql.Date;

import bean.CGenUtil;
import hetra.paiement.Hetra;
import historique.MapUtilisateur;
import utilitaire.UtilDB;
import java.sql.Connection;;

public class Mpiasa extends MapUtilisateur {
    int id;
    String id_commune;
    Commune commune;
    Date datelog;
    Hetra hetra;

    public void setHetra(Hetra hetra) {
        this.hetra = hetra;
    }
    public Hetra getHetra() {
        return hetra;
    }   

    public Mpiasa(MapUtilisateur utilisateur) throws Exception {
        this(utilisateur.getRefuser());
    }
    
    public  Mpiasa (int id) throws Exception{
        super();
        super.setNomTable("mpiasa");
        this.setDatelog(new java.sql.Date(System.currentTimeMillis()));
        System.out.println("Dateeeeeee   "+new java.sql.Date(System.currentTimeMillis()));
        
        try(Connection c = new UtilDB().GetConn()) {
            String sql = "SELECT c.* FROM mpiasa m\n" + //
                                "JOIN  commune c ON c.id_commune = m.id_commune where m.id = "+id;
            this.setCommune((Commune) CGenUtil.rechercher(new Commune(), sql, c)[0]);
            this.setHetra( new Hetra().getByDates(this.getDatelog(), c));
        } catch (Exception e) {
            throw e;
        }
    }
    public String getId_commune() {
        return id_commune;
    }

    public void setId_commune(String id_commune) {
        this.id_commune = id_commune;
    }

    public Commune getCommune() {
        return commune;
    }

    public void setCommune(Commune commune) {
        this.commune = commune;
    }

    public Date getDatelog() {
        return datelog;
    }

    public void setDatelog(Date datelog) {
        this.datelog = datelog;
    }
    

}
