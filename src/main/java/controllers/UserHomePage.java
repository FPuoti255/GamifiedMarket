package controllers;

import entities.Product;
import entities.Review;
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
import java.util.List;

@WebServlet(name = "UserHomePage", value = "/UserHomePage")
public class UserHomePage extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "UserHomePage";

    @EJB(beanName = "ProductService")
    ProductService pdrService;

    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        templateResolver.setPrefix("/WEB-INF/templates/");
        templateResolver.setSuffix(".html");
        templateEngine.setTemplateResolver(templateResolver);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());

        Product dayProduct;
        List<Review> reviews;
        try{
            dayProduct = pdrService.getProductOfTheDay();
            reviews = pdrService.getReviews(dayProduct.getIdProduct());
        }catch(Throwable e){
            ctx.setVariable("errorMsg", "Ops, something went wrong");
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }
        ctx.setVariable("product", dayProduct);
        ctx.setVariable("reviews", reviews);
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }

}
