package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.CGenUtil;
import hetra.paiement.Paiement;
import hetra.paiement.CalculHetraPaiement;
import hetra.trano.CalculHetraMaison;

@WebServlet("/paiement")
public class PaiementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupération de l'année depuis le paramètre
            String anneeParam = request.getParameter("year");
            int annee = (anneeParam != null && !anneeParam.isEmpty()) 
                ? Integer.parseInt(anneeParam) 
                : 2024; // Année par défaut
            
            // 1. Récupérer d'abord toutes les maisons
            CalculHetraMaison[] maisons = (CalculHetraMaison[]) CGenUtil.rechercher(new CalculHetraMaison(), null, null, "");
            
            // 2. Récupérer les paiements existants pour l'année sélectionnée
            String condition = "AND annee=" + annee;
            CalculHetraPaiement[] paiementsExistants = 
                (CalculHetraPaiement[]) CGenUtil.rechercher(new CalculHetraPaiement(), null, null, condition);
            
            List<CalculHetraPaiement> listeComplete = new ArrayList<>();
            
            // Pour chaque maison
            for(CalculHetraMaison maison : maisons) {
                String idMaison = maison.getId_maison();
                double hetra = maison.getHetra();
                
                // Créer une entrée pour chaque mois (1-12)
                for(int mois = 1; mois <= 12; mois++) {
                    // Chercher si un paiement existe pour ce mois et cette maison
                    CalculHetraPaiement paiementExistant = null;
                    for(CalculHetraPaiement p : paiementsExistants) {
                        if(p.getId_maison().equals(idMaison) && p.getMois() == mois) {
                            paiementExistant = p;
                            break;
                        }
                    }
                    
                    if(paiementExistant != null) {
                        // Si le paiement existe, l'ajouter tel quel
                        listeComplete.add(paiementExistant);
                    } else {
                        // Sinon, créer une nouvelle entrée sans date de paiement
                        CalculHetraPaiement nouveauPaiement = new CalculHetraPaiement();
                        nouveauPaiement.setId_maison(idMaison);
                        nouveauPaiement.setMois(mois);
                        nouveauPaiement.setAnnee(annee);
                        nouveauPaiement.setHetra(hetra);
                        listeComplete.add(nouveauPaiement);
                    }
                }
            }
            
            // Convertir la liste en tableau
            CalculHetraPaiement[] resultatFinal = listeComplete.toArray(new CalculHetraPaiement[0]);
            
            // Stockage des données dans la requête
            request.setAttribute("paiements", resultatFinal);
            request.setAttribute("anneeSelectionnee", annee);
            
            // Redirection vers la JSP
            request.getRequestDispatcher("pages/module.jsp?but=hetra/maison-details.jsp")
                  .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erreur", e.getMessage());
            request.getRequestDispatcher("/pages/erreur.jsp")
                  .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Logique pour gérer les requêtes POST
        // Traitement du paiement ici
        
        response.sendRedirect(request.getContextPath() + "/confirmation");
    }
}
