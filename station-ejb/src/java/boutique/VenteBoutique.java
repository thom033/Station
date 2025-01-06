package boutique;

import java.sql.Connection;

import avoir.AvoirFC;
import avoir.AvoirFCFille;
import stock.MvtStock;
import stock.MvtStockFille;
import user.UserEJB;
import user.UserEJBClient;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import vente.InsertionVente;
import vente.Vente;
import vente.VenteDetails;


public class VenteBoutique {
    public static InsertionVente generateVente(String idCLient)throws Exception{
        InsertionVente vente = new InsertionVente();

        vente.setDaty(Utilitaire.dateDuJourSql());
        vente.setDesignation("Vente du magasin de station le "+ Utilitaire.dateDuJourSql());
        vente.setIdMagasin("CV000063");
        if (idCLient != null) {
            vente.setIdClient(idCLient);
        }else{
            vente.setIdClient("CLI000054");
        }
        return vente;
    }

    public static Vente persistVente (String u , Connection c , VenteDetails[] venteDetails , String idClient)throws Exception{
        boolean estOuvert = false;
        UserEJB userEJBBean = UserEJBClient.lookupUserEJBBeanLocal();

        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn("gallois" , "gallois");
                c.setAutoCommit(false);
            }

            InsertionVente vente = generateVente(idClient);
            for (VenteDetails venteDetails2 : venteDetails) {
                // venteDetails2.setIdVente(vente.getId());
                venteDetails2.setTauxDeChange(1);
                venteDetails2.setCompte("712000");   
            }

          
            userEJBBean.createObjectMultipleGallois(vente, "idVente", venteDetails , c);
            vente.validerObject("1060", c);
            if (idClient == null) {
                vente.payer("1060", c);
            }
            if (estOuvert) {
                c.commit();
            }
            return vente;
        } catch (Exception e) {
            if(c!= null) c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if (c != null && estOuvert == true) c.close();
        }
    }

    public static void annulerVente(String u,Connection c,AvoirFC avoirFC)throws Exception{
        boolean estOuvert = false;
        UserEJB userEJBBean = UserEJBClient.lookupUserEJBBeanLocal();

        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn("gallois" , "gallois");
                c.setAutoCommit(false);
            }

            avoirFC.setDesignation("annulation de vente du:"+ Utilitaire.dateDuJour());
            avoirFC.setDaty(Utilitaire.dateDuJourSql());
            userEJBBean.createObjectMultipleGallois(avoirFC, "idAvoirFC", avoirFC.getAvoirDetails() , c);
            avoirFC.validerObject("1060", c);

            for (AvoirFCFille fille : avoirFC.getAvoirDetails()) {
                MvtStock mvtStock = new MvtStock();
                mvtStock.setDaty(Utilitaire.dateDuJourSql());
                mvtStock.setIdVente(avoirFC.getIdVente());
                mvtStock.setIdMagasin(avoirFC.getIdMagasin());
                mvtStock.setIdTypeMvStock("TPMVST000022");
                mvtStock.setDesignation("Annulation de vente");
                mvtStock.setIdTransfert("1");
                // mvtStock.createObject(u, c);

                MvtStockFille mvtStockFille=new MvtStockFille();
                mvtStockFille.setIdProduit(fille.getIdProduit());
                mvtStockFille.setEntree(fille.getQte());
                mvtStockFille.setSortie(0);

                MvtStockFille[] mvtStockFilles = new MvtStockFille[1];
                mvtStockFilles[0]=mvtStockFille;

                userEJBBean.createObjectMultipleGallois(mvtStock, "idMvtStock" ,mvtStockFilles,c);
                mvtStock.validerObject("1060", c);
            }
            if (estOuvert) {
                c.commit();
            }
            return;
        } catch (Exception e) {
            if(c!= null) c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if (c != null && estOuvert == true) c.close();
        }
    }
}
