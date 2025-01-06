package servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import bean.CGenUtil;
import stock.EtatStock;

@WebServlet("/stocks")
public class EtatStockServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req , HttpServletResponse resp) throws ServletException , IOException{
        try {
            Gson gson = new Gson();
            EtatStock es = new EtatStock();
            es.setIdTypeProduit("TP00002");
            // p.setIdCategorie("GRP000375");
            EtatStock[] resultats = (EtatStock[]) CGenUtil.rechercher(es, null, null, null , "");

            String jsonResponse = gson.toJson(resultats);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);
        } catch (Exception e) {
            // TODO: handle exception
        }
    }
}
