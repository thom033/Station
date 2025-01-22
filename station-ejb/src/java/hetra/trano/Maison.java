package hetra.trano;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;


import oracle.sql.STRUCT;
import oracle.sql.ARRAY;

import bean.ClassMAPTable;
import bean.ClassMere;
import utilitaire.UtilDB;


public class Maison extends ClassMere {
    
    String id, nom;
    double longueur, largeur;
    int etage;
    MaisonDetails details;
    double latitude, longitude;

    public void setDetails(MaisonDetails details) {
        this.details = details;
    }
    public MaisonDetails getDetails() {
        return details;
    }
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
     // Méthode pour vérifier si la longitude est définie (non NaN)
     public boolean isLongitudeDefined() {
        return !Double.isNaN(longitude);
    }

    // Méthode pour vérifier si la latitude est définie (non NaN)
    public boolean isLatitudeDefined() {
        return !Double.isNaN(latitude);
    }
    public double getLatitude() {
        return latitude;
    }
    public double getLongitude() {
        return longitude;
    }

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

    public double getLongueur() {
        return longueur;
    }

    public void setLongueur(double longueur) {
        this.longueur = longueur;
    }
    
    public double getLargeur() {
        return largeur;
    }

    public void setLargeur(double largeur) {
        this.largeur = largeur;
    }

    public int getEtage() {
        return etage;
    }

    public void setEtage(int etage) {
        this.etage = etage;
    }
    public Maison () {
        this.setNomTable("Maison");
    }

    public Maison(String nom2, double longueur2, double largeur2, int nbrEtage, double latitude2, double longitude2) {
        setNom(nom2);setLongueur(longueur2);setLargeur(largeur2);setEtage(nbrEtage);setLatitude(latitude2);setLongitude(longitude2);
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TR", "get_seq_maison");
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


    @Override
    public int insertToTable() throws Exception {
        String sql = "INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) " +
        "VALUES (?, ?, ?, ?, ?, SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(?, ?, NULL), NULL, NULL))";
        try (Connection c = new UtilDB().GetConn();
            PreparedStatement statement = c.prepareStatement(sql)) {
                this.construirePK(c);

            // Paramètres de la requête
            statement.setString(1, this.getId());
            statement.setString(2, this.getNom());
            statement.setDouble(3, this.getLongueur());
            statement.setDouble(4, this.getLargeur());
            statement.setInt(5, this.getEtage());
            statement.setDouble(6, this.getLongitude()); // Longitude
            statement.setDouble(7, this.getLatitude()); // Latitude
            // Exécution de la requête
            int rowsInserted = statement.executeUpdate();

            this.getDetails().setId_maison(this.getId());
            this.getDetails().insertToTable(c);

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
        String sql = "SELECT id, nom, longeur, largeur, nbr_etage, latitude, longitude FROM maison";
    
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
    
            while (resultSet.next()) {
                Maison maison = new Maison();
                maison.setId(resultSet.getString("id"));
                maison.setNom(resultSet.getString("nom"));
                maison.setLongueur(resultSet.getDouble("longeur"));
                maison.setLargeur(resultSet.getDouble("largeur"));
                maison.setEtage(resultSet.getInt("nbr_etage"));
                maison.setLatitude(resultSet.getDouble("latitude"));  // Récupère la latitude
                maison.setLongitude(resultSet.getDouble("longitude")); // Récupère la longitude
    
                maisons.add(maison);
            }
    
        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des maisons : " + e.getMessage(), e);
        }
        return maisons;
    }
    

    
}