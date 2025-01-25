package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.CGenUtil;
import hetra.commune.Arrondissement;

@WebServlet("/arrondissement")
public class ArrondissementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("list", CGenUtil.rechercher(new Arrondissement(), "select * from arrondissement"));
            request.getRequestDispatcher("/hetra/arrondissement-list").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}