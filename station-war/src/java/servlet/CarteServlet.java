package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hetra.trano.*;
import com.fasterxml.jackson.databind.ObjectMapper;

import hetra.trano.Maison;

@WebServlet( urlPatterns = {"/carte"})
public class CarteServlet  extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {            
            req.getRequestDispatcher("/pages/hetra/carte.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
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
