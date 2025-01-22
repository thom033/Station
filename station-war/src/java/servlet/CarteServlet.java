package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hetra.trano.*;
import com.fasterxml.jackson.databind.ObjectMapper;

import hetra.trano.Maison;

@WebServlet( urlPatterns = {"/carte"})
public class CarteServlet  extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Gson gson = new Gson();

            TypeData data = new TypeData();

            resp.setHeader("Access-Control-Allow-Origin", "*");
            resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

            String jsonResponse = gson.toJson(data);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);
            
            req.getRequestDispatcher("/pages/hetra/carte.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
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
