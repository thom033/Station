package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import utilitaire.UtilDB;
import venteLubrifiant.PrelevementLubLib;
import venteLubrifiant.PrelevementLub;

@WebServlet("/prel-lubrifiant")
public class PrelevementLubServlet extends HttpServlet{
    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Allow cross-origin requests from any domain
        resp.setHeader("Access-Control-Allow-Origin", "*");
        
        // Specify allowed request methods
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        
        // Specify allowed request headers
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

        // Set the status to OK
        resp.setStatus(HttpServletResponse.SC_OK);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection c = null;
        try {
            resp.setHeader("Access-Control-Allow-Origin", "*");
            resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
            // Reading the request body (JSON)
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            try (BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    jsonBuilder.append(line);
                }
            }

            // Parsing JSON using org.json.JSONObject
            String jsonData = jsonBuilder.toString();
            System.out.println("Received Json data :" + jsonData);

            // Gson gson = new Gson();
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
            Type listType = new TypeToken<PrelevementLubLib>(){}.getType();
            PrelevementLubLib prelevementLubLib = gson.fromJson(jsonData, listType);

            PrelevementLub[] prelevements = prelevementLubLib.convertToPrelevementLubs();
            c = new UtilDB().GetConn("gallois","gallois");
            for (PrelevementLub prelevementLub : prelevements) {
                PrelevementLub anterieur = prelevementLub.getPrelevementAnterieur();
                if (anterieur != null) {
                    prelevementLub.setIdPrelevementAnterieur(anterieur.getId());
                }
                prelevementLub.createObject("1060", c);

                prelevementLub.persistVente(anterieur , c);
            }
            
            
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.setStatus(200);
            PrintWriter out = resp.getWriter();

            // send status code 200
            String response = "{\"status\": \"success\"}";
            
            out.print(response);
            out.flush();

        } catch (Exception e) {
            // Handle exception and send error response
            e.printStackTrace();
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Set status code 500
            PrintWriter out = resp.getWriter();

            // Send error response with exception message
            String errorResponse = "{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}";
            out.print(errorResponse);
            out.flush();
        }finally {
            // Close the connection
            if (c != null) {
                try {
                    c.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                
            }
        }
    }
}
