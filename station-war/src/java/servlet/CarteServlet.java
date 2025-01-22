package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hetra.trano.*;
import utilitaire.UtilDB;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@WebServlet( urlPatterns = {"/carte"})
public class CarteServlet  extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Initialiser Gson pour convertir les données au format JSON
        Gson gson = new Gson();

        // Définir les en-têtes CORS
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

        try (Connection connection = new UtilDB().GetConn()) {
            // Récupérer toutes les maisons depuis la base de données
            List<Maison> maisons = Maison.getAllMaison(connection);

            // Vérifier si des maisons ont été récupérées
            if (maisons == null || maisons.isEmpty()) {
                maisons = new ArrayList<>(); // Éviter les valeurs null
            }

            // Convertir la liste des maisons en JSON
            String jsonResponse = gson.toJson(maisons);

            // Définir le JSON comme attribut de la requête
            req.setAttribute("maisons", jsonResponse);

            // Transférer la requête vers la page JSP
            req.getRequestDispatcher("/pages/hetra/carte.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace(); // Afficher les détails de l'erreur dans la console
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Une erreur est survenue lors du traitement de la requête.");
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setHeader("Access-Control-Allow-Methods", "PST");
            response.setHeader("Access-Control-Allow-Headers", "Content-Type, application/json");

            // Lire les données JSON depuis la requête
            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }
            System.out.println(json.toString());

            // Convertir le JSON en objet Java
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> data = objectMapper.readValue(json.toString(), Map.class);

            // Récupérer les valeurs
            String nom = (String) data.get("nom");
            double longueur = Double.parseDouble(data.get("longueur").toString());
            double largeur = Double.parseDouble(data.get("largeur").toString());
            int nbrEtage = Integer.parseInt( data.get("nbrEtage").toString());
            double latitude = Double.parseDouble( data.get("latitude").toString());
            double longitude = Double.parseDouble( data.get("longitude").toString());

            Maison m = new Maison(nom, longueur, largeur, nbrEtage, latitude, longitude);
            MaisonDetails details = new MaisonDetails(data.get("typeTafo").toString(),data.get("typeRindrina").toString());
            m.setDetails(details);
            m.insertToTable();

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
}
