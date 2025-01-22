package servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.CGenUtil;

import hetra.trano.*;

@WebServlet( urlPatterns = {"/carte"})
public class CarteServlet  extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Gson gson - new Gson();
            TypeRindrina typeRindrina = new TypeRindrina();
            TypeTafo typeTafo = new TypeTafo()

            TypeRindrina[] typeRindrinaList = (TypeRindrina[]) CGenUtil.rechercher(typeRindrina, null, null, null, "");
            TypeTafo[] typeTafoList = (TypeTafo[]) CGenUtil.rechercher(typeTafo, null, null, null, "");
            
            TypeData data = new TypeData(typeRindrinaList,typeTafoList);

            resp.setHeader("Access-Control-Allow-Origin", "*");
            resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

            String jsonResponse = gson.toJson(data);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/pages/hetra/carte.jsp").forward(req, resp);
    }
    
}
