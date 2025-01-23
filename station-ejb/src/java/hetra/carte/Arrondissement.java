package hetra.carte;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.Reader;
import java.io.BufferedReader;

public class Arrondissement {
    private String idArrondissement;
    private String nom;
    private double totalPaye;
    private double totalReste;
    private List<String> positionPolygone; // List to store multiple positions

    // Getters and setters
    public String getIdArrondissement() {
        return idArrondissement;
    }

    public void setIdArrondissement(String idArrondissement) {
        this.idArrondissement = idArrondissement;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getTotalPaye() {
        return totalPaye;
    }

    public void setTotalPaye(double totalPaye) {
        this.totalPaye = totalPaye;
    }

    public double getTotalReste() {
        return totalReste;
    }

    public void setTotalReste(double totalReste) {
        this.totalReste = totalReste;
    }

    public List<String> getPositionPolygone() {
        return positionPolygone;
    }

    public void setPositionPolygone(List<String> positionPolygone) {
        this.positionPolygone = positionPolygone;
    }

    public void setPositionPolygoneFromDB(Connection connection) throws Exception {
        List<String> positions = new ArrayList<>();
        String sql = "SELECT SDO_UTIL.TO_WKTGEOMETRY(position) AS wkt FROM arrondissement_position WHERE id_arrondissement = ?";
    
         try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, idArrondissement);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Récupération du type CLOB pour la colonne position
                    java.sql.Clob clob = rs.getClob("wkt");
                    if (clob != null) {
                        String clobData = clob.getSubString(1, (int) clob.length());
                        
                        // Analyse des données pour extraire SDO_ORDINATE_ARRAY
                        String ordinates = extractOrdinateArray(clobData);
                        if (ordinates != null) {
                            // Transformation en liste de chaînes
                            String[] coordinates = ordinates.split(",");
                            for (String coord : coordinates) {
                                positions.add(coord.trim());
                            }
                        }
                    }
                }
            }
        }
        catch(Exception e){
            throw new Exception("tsy mety" + e.getMessage());
        }
    }
    private static String extractOrdinateArray(String sdoGeometry) {
        // Trouver la partie `SDO_ORDINATE_ARRAY(...)` et extraire son contenu
        String startKey = "SDO_ORDINATE_ARRAY(";
        String endKey = ")";
        int startIndex = sdoGeometry.indexOf(startKey);
        if (startIndex != -1) {
            startIndex += startKey.length();
            int endIndex = sdoGeometry.indexOf(endKey, startIndex);
            if (endIndex != -1) {
                return sdoGeometry.substring(startIndex, endIndex);
            }
        }
        return null;
    }

    
    // Méthode pour récupérer tous les arrondissements avec leurs positions en WKT
    public static List<Arrondissement> getAllArrondissement(Connection connection) throws Exception {
        List<Arrondissement> arrondissements = new ArrayList<>();
        String sql = "SELECT id_arrondissement FROM arrondissement_position";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Arrondissement arrondissement = new Arrondissement();
                arrondissement.setIdArrondissement(resultSet.getString("id_arrondissement"));
                arrondissement.setPositionPolygoneFromDB(connection);
                arrondissements.add(arrondissement);
            }

        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des arrondissements : " + e.getMessage(), e);
        }

        return arrondissements;
    }

    // Convertir un CLOB en String
    private static String clobToString(Clob clob) throws Exception {
        StringBuilder stringBuilder = new StringBuilder();
        try (Reader reader = clob.getCharacterStream();
             BufferedReader bufferedReader = new BufferedReader(reader)) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                stringBuilder.append(line);
            }
        }
        return stringBuilder.toString();
    }

    // Méthode pour transformer le WKT en une liste de chaînes de caractères (coordonnées du polygone)
    private static List<String> parseWktToList(String wkt) {
        List<String> positionsList = new ArrayList<>();

        if (wkt != null && !wkt.isEmpty()) {
            // Supposons que le WKT est sous forme de "POLYGON((x1 y1, x2 y2, ...))"
            String coordinatesString = wkt.substring(wkt.indexOf("(") + 1, wkt.lastIndexOf(")"));
            String[] coordinates = coordinatesString.split(","); // Séparer les coordonnées par virgules

            for (String coordinate : coordinates) {
                positionsList.add(coordinate.trim());
            }
        }

        return positionsList;
    }
}
