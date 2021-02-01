package controllers;

import services.ProductService;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RemoveQuestionnaire", value = "/RemoveQuestionnaire")
public class RemoveQuestionnaire extends HttpServlet {
    @EJB(beanName = "ProductService")
    ProductService products;

    @Override
    public void init() throws ServletException {
        super.init();
    }

    /**
     * super simple servlet that removes a product element from the database
     * the product service and the db itself takes care of all the db-related cascading updates
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        products.removeProduct(Integer.parseInt(
                req.getParameter("idProduct")
        ));
        resp.sendRedirect("ReviewQuestionnaires");
    }
}
