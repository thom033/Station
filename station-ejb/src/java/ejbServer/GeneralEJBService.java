package ejbServer;

import bean.CGenUtil;
import bean.ClassMAPTable;
import caisse.MvtCaisse;
import faturefournisseur.FactureFournisseur;
import faturefournisseur.FactureFournisseurDetails;
import finance.EtatDeFinance;
import jauge.Jauge;
import jauge.JaugeService;
import jauge.JaugeSignature;
import pompe.Pompe;
import prelevement.PrelevementCpl;
import utilitaire.UtilDB;
import vente.Vente;
import vente.VenteDetails;

import javax.ejb.Stateless;
import java.sql.Connection;
import java.sql.Date;

@Stateless
public class GeneralEJBService implements GeneralEJBLocalServer{
    @Override
    public Pompe savePompe(Pompe pompe, Connection connection) throws Exception {
        return (Pompe) CGenUtil.save(pompe,connection);
    }
    @Override
    public void generateAndPersistFF(FactureFournisseur factureFournisseur, FactureFournisseurDetails[] factureFournisseurDetails, Connection connection) throws Exception {
        System.out.println("Insertion facture");
        factureFournisseur.generateAndPersistFF(factureFournisseur,factureFournisseurDetails,connection);
    }

    @Override
    public void genererEcriturevente(Vente vente, Connection connection) throws Exception {
        vente.genererEcriture("1060",connection);
    }

    @Override
    public Vente getVenteByIdPrelevement(String idPrelevement, Connection connection) throws Exception {
        Vente vente = new Vente();
        return vente.getByIdOrigine(idPrelevement, connection);
    }

    @Override
    public EtatDeFinance getEtatDeFinance(Date dateMin, Date dateMax, Connection connection) throws Exception {
        try {
            if (connection == null) connection = new UtilDB().GetConn("gallois","gallois");
            return new EtatDeFinance(dateMax,dateMin,connection);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            connection.close();
        }
        return null;
    }

    @Override
    public MvtCaisse mvtCaisse(Vente vente,Date date,Connection connection) throws Exception {
        boolean estOuvert = false;
        if (connection == null) {connection = new UtilDB().GetConn("gallois","gallois");estOuvert=true;}
        try{
            MvtCaisse mvtCaisse = new MvtCaisse();
            VenteDetails[] venteDetails = vente.getDetails(connection);
            mvtCaisse.setIdCaisse("CAI000238");
            mvtCaisse.setDesignation("Paiement de la vente N°:"+vente.getId());
            mvtCaisse.setDebit(0);
            mvtCaisse.setCredit(venteDetails[0].getQte()*venteDetails[0].getPu());
//            if (vente.getDaty().compareTo(date) > 0){
//                throw new Exception("Mouvement de caisse non valide à cause de la date");
//            }
            mvtCaisse.setDaty(date);
            mvtCaisse.setEtat(1);
            mvtCaisse.setIdOrigine(vente.getIdOrigine());
            mvtCaisse.setIdDevise("AR");
            mvtCaisse.setTaux(1);
            mvtCaisse.setIdTiers("CLI000063");
            mvtCaisse.createObject("1060",connection);
            mvtCaisse.validerObject("1060",connection);
            if (estOuvert) connection.commit();
            return mvtCaisse;
        } catch (Exception e){
            if (estOuvert) connection.rollback();
        } finally {
            if (estOuvert) connection.close();
        }

        return null;
    }

    @Override
    public PrelevementCpl[] getAllPrelevementCpl(Connection connection) throws Exception {
        if (connection == null) connection = new UtilDB().GetConn("gallois","gallois");
        PrelevementCpl[] prelevementCpls = (PrelevementCpl[]) CGenUtil.rechercher(new PrelevementCpl(),null,null,connection," ");
        return prelevementCpls;
    }

    @Override
    public Jauge jaugerCuve(Jauge jauge , Connection connection) throws Exception {
        JaugeSignature jaugeSignature = new JaugeService();
        return jaugeSignature.jauger(jauge,connection);
    }

    @Override
    public Object[] getData(ClassMAPTable e, Connection c, String apresWhere) throws Exception {
        c=null;
        try {
            c=new UtilDB().GetConn("gallois" , "gallois");
            return CGenUtil.rechercher(e, null, null, c, apresWhere);
        } catch (Exception ex) {
            throw ex;
        }finally{
            c.close();
        }
    }

    @Override
    public Object createObject(ClassMAPTable e, Connection c) throws Exception {
        try {
            c = new UtilDB().GetConn("gallois" , "gallois");
            c.setAutoCommit(false);
            Object ob = e.insertToTable(c);
            c.commit();
            return ob;
        } catch (Exception ex) {
            ex.printStackTrace();
            c.rollback();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

}
