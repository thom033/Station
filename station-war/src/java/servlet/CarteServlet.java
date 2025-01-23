package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilitaire.UtilDB;
import hetra.carte.Arrondissement;
import hetra.trano.*;
import com.google.gson.Gson;

import hetra.trano.*;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet( urlPatterns = {"/carte"})
public class CarteServlet  extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Initialize Gson to convert data into JSON format
            Gson gson = new Gson();
    
            // Set CORS headers
            resp.setHeader("Access-Control-Allow-Origin", "*");
            resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
    
            // Connect to the database
            UtilDB dbUtil = new UtilDB();
            Connection connection = dbUtil.GetConn();
    
            // // Retrieve all houses from the database
            // List<Maison> maisons = Maison.getAllMaison(connection);
    
            // // Convert the list of houses to JSON
            // String jsonResponse = gson.toJson(maisons);
            List<Arrondissement> arrondissements = Arrondissement.getAllArrondissement(connection);
            req.setAttribute("arrondissements", arrondissements);
            String jsonResponse = gson.toJson(arrondissements);


            resp.getWriter().write(jsonResponse);
            // Set the JSON as an attribute in the request
            //req.setAttribute("maisons", jsonResponse);

            
            // Write the JSON response to the output stream
            //resp.getWriter().write(jsonResponse);
            // Close the connection
            connection.close();
    
           
            // // Forward the request to the JSP page
            //req.getRequestDispatcher("/pages/hetra/carte.jsp").forward(req, resp);
    
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lire les données JSON depuis la requête
            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            // Convertir le JSON en objet Java
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> data = objectMapper.readValue(json.toString(), Map.class);

            // Récupérer les valeurs
            String nom = (String) data.get("nom");
            double longueur = (double) data.get("longueur");
            double largeur = (double) data.get("largeur");
            int nbrEtage = (int) data.get("nbrEtage");
            double latitude = (double) data.get("latitude");
            double longitude = (double) data.get("longitude");

            Maison m = new Maison(nom, longueur, largeur, nbrEtage, latitude, longitude);
            m.insertToTable();

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
}
