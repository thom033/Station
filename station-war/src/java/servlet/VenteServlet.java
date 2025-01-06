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
import vente.VenteDetails;

@WebServlet("/vente-boutique")
public class VenteServlet extends HttpServlet{
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
        // System.out.println("Received Json data :" + jsonData);

        Gson gson = new Gson();
        Type listType = new TypeToken<VenteDetails[]>(){}.getType();
        VenteDetails[] venteDetails = gson.fromJson(jsonData, listType);

        Vente v= new Vente();
        // System.out.println("Halavany : "+venteDetails.length);
        try {
            v=VenteBoutique.persistVente("1060", null, venteDetails , null);
        } catch (Exception e) {
            // TODO: handle exception
        }
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        String jsonResponse = gson.toJson(v);
        System.out.println(jsonResponse);
        out.print(jsonResponse);
        out.flush();
    }
}
