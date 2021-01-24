package controllers;
import entities.Product;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.ProductService;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "AdminHomePage", value = "/AdminHomePage")
public class AdminHomePage extends HttpServlet {
    @EJB(beanName = "ProductService")
    ProductService products;


    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "AdminHomePage";

    @Override
    public void init() throws ServletException {
        ServletContext cont = getServletContext();
        ServletContextTemplateResolver resolver = new ServletContextTemplateResolver(cont);

        resolver.setTemplateMode(TemplateMode.HTML);
        resolver.setPrefix("/WEB-INF/templates/");
        resolver.setSuffix(".html");
        templateEngine.setTemplateResolver(resolver);
    }


    /**
     * main method of the servlet, override of the original HttpServlet.doGet method.
     * renders the landing page of the administration, in the form of a "create new product" / "add
     * questionnaire to current product" page
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final WebContext context = new WebContext(req, resp, getServletContext(), req.getLocale());

        Product dayProduct = products.getProductOfTheDay();
        context.setVariable("product", dayProduct);
        templateEngine.process(path, context, resp.getWriter());
    }

    /**
     * this method intercepts the action of adding a product to the application
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /**
         * marshal the parameters from the form and invoke the
         * productService to add the product to the database
         */
        Product p = products.addProduct(
                req.getParameter("productName"),
                req.getParameter("productImage").getBytes(),
                Date.valueOf(req.getParameter("productDate"))
        );

        /**
         * reload page
         * it's done by redirecting to this page instead of reprocessing the template to
         * trigger a get call and a subsequent refresh of the elements
         */
        resp.sendRedirect(path);
    }
}
