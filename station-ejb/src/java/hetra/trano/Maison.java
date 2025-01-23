package hetra.trano;

import java.sql.Connection;
import java.sql.PreparedStatement;

import bean.ClassMAPTable;
import bean.ClassMere;
import utilitaire.UtilDB;

public class Maison extends ClassMere {
    
    String id_maison,id_proprietaire, nom;
    MaisonDetails details;
    double latitude, longitude;

    // Getters and Setters
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

    public MaisonDetails getDetails() {
        return details;
    }

    public void setDetails(MaisonDetails details) {
        this.details = details;
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

    public Maison () {
        this.setNomTable("Maison");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TR", "get_seq_maison");
        this.setId_maison(makePK(c));
    }
    

    @Override
    public String getAttributIDName() {
        return this.getId_maison();
    }

    @Override
    public String getTuppleID() {
        return "id";
    }


    @Override
    public int insertToTable() throws Exception {
        String sql = "INSERT INTO maison (id_maison, id_proprietaire, nom, position) " +
        "VALUES (?, ?, ?, SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(?, ?, NULL), NULL, NULL))";
        try (Connection c = new UtilDB().GetConn();
            PreparedStatement statement = c.prepareStatement(sql)) {
                this.construirePK(c);

            // Paramètres de la requête
            statement.setString(1, this.getId_maison());
            statement.setString(2, this.getId_proprietaire());
            statement.setString(3, this.getNom());
            statement.setDouble(4, this.getLongitude());
            statement.setDouble(5, this.getLatitude());

            // Exécution de la requête
            int rowsInserted = statement.executeUpdate();

            this.getDetails().setId_maison(this.getId_maison());
            this.getDetails().insertToTable(c);

            if (rowsInserted > 0) {
                System.out.println("Insertion réussie dans la table `maison`.");
            }

            return rowsInserted;
        }
    }
}
