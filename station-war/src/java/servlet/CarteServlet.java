package servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.CGenUtil;

import hetra.trano.TypeRindrina;
import hetra.trano.TypeTafo;

@WebServlet( urlPatterns = {"/carte"})
public class CarteServlet  extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            TypeRindrina typeRindrina = new TypeRindrina();
            TypeTafo typeTafo = new TypeTafo();

            TypeRindrina[] typeRindrinaList = (TypeRindrina[]) CGenUtil.rechercher(typeRindrina, null, null, null, "");
            TypeTafo[] typeTafoList = (TypeTafo[]) CGenUtil.rechercher(typeTafo, null, null, null, "");
            req.setAttribute("typeRindrinaList", typeRindrinaList);
            req.setAttribute("typeTafoList", typeTafoList);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/pages/hetra/carte.jsp").forward(req, resp);
    }
    
}
