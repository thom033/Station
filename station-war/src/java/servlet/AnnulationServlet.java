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

import avoir.AvoirFC;
import boutique.VenteBoutique;

@WebServlet("/annulation-boutique")
public class AnnulationServlet extends HttpServlet{
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
        Type listType = new TypeToken<AvoirFC>(){}.getType();
        // Vente vente = gson.fromJson(jsonData, listType);
        AvoirFC avoirFC= gson.fromJson(jsonData, listType);

        // System.out.println("Halavany : "+venteDetails.length);
        try {
            VenteBoutique.annulerVente("1060", null, avoirFC);
        } catch (Exception e) {
            // TODO: handle exception
        }
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.setStatus(200);
        PrintWriter out = resp.getWriter();

        // send status code 200
        String response = "{\"status\": \"success\"}";
        
        out.print(response);
        out.flush();
    }
}
