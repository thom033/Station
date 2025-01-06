package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import boutique.VenteBoutique;
import vente.Vente;

@WebServlet("/dette-boutique")
public class DetteServlet extends HttpServlet{
    @Override
    protected void doPost (HttpServletRequest req , HttpServletResponse resp) throws ServletException , IOException{
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

        Gson gson = new Gson();
        Type listType = new TypeToken<Vente>(){}.getType();
        Vente vente = gson.fromJson(jsonData, listType);

        // System.out.println("Halavany : "+venteDetails.length);
        Vente v= new Vente();
        try {
            v=VenteBoutique.persistVente("1060", null, vente.getVenteDetails() , vente.getIdClient());
        } catch (Exception e) {
            // TODO: handle exception
        }
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        out.print(gson.toJson(v));
        out.flush();
    }
}
