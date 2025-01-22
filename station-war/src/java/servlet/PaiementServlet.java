package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.CGenUtil;

import hetra.paiement.Paiement;

@WebServlet("/paiement")
public class PaiementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Paiement[] listePaiements = (Paiement[]) CGenUtil.rechercher(new Paiement(), null, null, "");
            System.out.println(listePaiements.length);

        } catch (Exception e) {
            e.printStackTrace();
        }
        // request.getRequestDispatcher("/WEB-INF/paiement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Logique pour gérer les requêtes POST
        // Traitement du paiement ici
        
        response.sendRedirect(request.getContextPath() + "/confirmation");
    }
}
