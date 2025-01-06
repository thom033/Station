package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.CGenUtil;
import client.Client;
import stock.EtatStock;

@WebServlet("clients")
public class ClientServlet extends HttpServlet{
     @Override
    protected void doGet(HttpServletRequest req , HttpServletResponse resp) throws ServletException , IOException{
        try {
            Gson gson = new Gson();
            Client client = new Client();
            // p.setIdCategorie("GRP000375");
            // EtatStock[] resultats = (EtatStock[]) CGenUtil.rechercher(es, null, null, null , "");
            Client[] clients = (Client[]) CGenUtil.rechercher(client, null, null, null , "");

            resp.setHeader("Access-Control-Allow-Origin", "*");
            resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

            String jsonResponse = gson.toJson(clients);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);
        } catch (Exception e) {
            // TODO: handle exception
        }
    }
}
