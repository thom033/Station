package servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hetra.trano.Maison;
import utilitaire.UtilDB;

@WebServlet("/maisons")
public class MaisonServlet extends HttpServlet{
        @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Initialiser Gson pour convertir les données au format JSON
        Gson gson = new Gson();

        // Définir les en-têtes CORS
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

        try (Connection connection = new UtilDB().GetConn();
            PrintWriter out = resp.getWriter();) {
            // Récupérer toutes les maisons depuis la base de données
            List<Maison> maisons = Maison.getAllMaison(connection);

            // Vérifier si des maisons ont été récupérées
            if (maisons == null || maisons.isEmpty()) {
                maisons = new ArrayList<>(); // Éviter les valeurs null
            }

            // Convertir la liste des maisons en JSON
            String jsonResponse = gson.toJson(maisons);

            // Écrire la réponse JSON dans la réponse HTTP
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            out.write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace(); // Afficher les détails de l'erreur dans la console
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Une erreur est survenue lors du traitement de la requête.");
        }
    }
}
