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
    public int insertToTable() throws Exception {
        String sql = "INSERT INTO maison (id_maison, nom,  position) " +
        "VALUES (?, ?, ?, ?, ?, SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(?, ?, NULL), NULL, NULL))";
        try (Connection c = new UtilDB().GetConn();
            PreparedStatement statement = c.prepareStatement(sql)) {
                this.construirePK(c);

            // Paramètres de la requête
            statement.setString(1, this.getId_maison());
            statement.setString(2, this.getNom());
            statement.setDouble(3, this.getLatitude()); // Latitude
            statement.setDouble(4, this.getLongitude()); // Longitude
            // Exécution de la requête
            int rowsInserted = statement.executeUpdate();

            // this.getDetails().setId_maison(this.getId());
            // this.getDetails().insertToTable(c);

            if (rowsInserted > 0) {
                System.out.println("Insertion réussie dans la table `maison`.");
            }
            return rowsInserted;
        } catch (Exception e) {
            throw e;
        }
    }

    public static List<Maison> getAllMaison(Connection connection) throws Exception {
        List<Maison> maisons = new ArrayList<>();
        String sql = "SELECT id, nom, latitude, longitude FROM maison";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
    
            while (resultSet.next()) {
                Maison maison = new Maison();
                maison.setId_maison(resultSet.getString("id"));
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
        return this.getDetails().getTypeRindrina().getCoefficient() * this.getDetails().getTypeTafo().getCoefficient();
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

        details.setTypeRindrina(rindrina);
        details.setTypeTafo(tafo);

        return details;
    }
    

    
}