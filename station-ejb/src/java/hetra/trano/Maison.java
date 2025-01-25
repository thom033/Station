package hetra.trano;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.CGenUtil;
import bean.ClassMere;
import utilitaire.UtilDB;


public class Maison extends ClassMere {
    
    String id_maison,id_proprietaire, nom;
    double latitude, longitude;

    MaisonDetails details;

    //constructeur
    public Maison() {
        this.setNomTable("maison");
    }

    // Maison m = new Maison(nom, longueur, largeur, nbrEtage, latitude, longitude);
    public Maison(String nom, int longueur, int largeur, int nbr_etages, double latitude, double longitude) {
        this.nom = nom;
        this.latitude = latitude;
        this.longitude = longitude;
        this.details = new MaisonDetails(longueur, largeur, nbr_etages);
    }


    public Maison(String id_maison, String id_proprietaire, String nom, double latitude, double longitude) {
        this.id_maison = id_maison;
        this.id_proprietaire = id_proprietaire;
        this.nom = nom;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public void setDetails(MaisonDetails details) {
        this.details = details;
    }
    public MaisonDetails getDetails() {
        return details;
    }

    public String getId_maison() {
        return id_maison;
    }

    public void setId_maison(String id_maison) {
        this.id_maison = id_maison;
    }

    public String getId_proprietaire() {
        return id_proprietaire;
    }

    public void setId_proprietaire(String id_proprietaire) {
        this.id_proprietaire = id_proprietaire;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    @Override
    public String getAttributIDName() {
        return this.getId_maison();
    }

    @Override
    public String getTuppleID() {
        return "id_maison";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MN", "seq_maison");
        this.setId_maison(makePK(c));
    }


    @Override
    public int insertToTable() throws Exception {
        try (Connection c = new UtilDB().GetConn()) {
                this.construirePK(c);

            this.insertToTable(c);

            // this.getDetails().setId_maison(this.getId());
            // this.getDetails().insertToTable(c);
            return 1;
        } catch (Exception e) {
            throw e;
        }
    }

    public static List<Maison> getAllMaison(Connection connection) throws Exception {
        List<Maison> maisons = new ArrayList<>();
        String sql = "SELECT id_maison, nom, latitude, longitude FROM maison";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
    
            while (resultSet.next()) {
                Maison maison = new Maison();
                maison.setId_maison(resultSet.getString("id_maison"));
                maison.setNom(resultSet.getString("nom"));
                maison.setLatitude(resultSet.getDouble("latitude"));  // Récupère la latitude
                maison.setLongitude(resultSet.getDouble("longitude")); // Récupère la longitude                
                maisons.add(maison);
            }
    
        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des maisons : " + e.getMessage(), e);
        }
        return maisons;
    }
    public double totalCoef() {
        return this.getDetails().getTypeRindrina().getCoefficient()*this.getDetails().getTypeTafo().getCoefficient();
    }
    public double totalSurface() {
        return this.getDetails().getLargeur() * this.getDetails().getLongueur() * this.getDetails().getNbr_etages();
    }
    public MaisonDetails getDetailsByDates(Date date, Connection connection) throws Exception {

        MaisonDetails details = new MaisonDetails();
        details = (MaisonDetails) CGenUtil.rechercher(details, null, null , connection, " and id_maison = "+this.getId_maison()+" and dates <= "+ date +" order by dates desc")[0];

        TypeRindrina rindrina = new TypeRindrina();
        rindrina.getById(details.getId_type_rindrina(), "1", connection);

        TypeTafo tafo = new TypeTafo();
        tafo.getById(details.getId_type_tafo(), "1", connection);

        // details.setTypeRindrina(rindrina);
        // details.setTypeTafo(tafo);

        return details;
    }
    

    
}