package controllers;

import entities.Product;
import entities.Review;
import entities.User;
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
import java.sql.Timestamp;
import java.time.LocalDateTime;
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
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
        User sessionUser = (User) request.getSession().getAttribute("user");

        Review check = pdrService.addReview(
                pdrService.getProductOfTheDay().getIdProduct(),
                sessionUser.getIdUser(),
                request.getParameter("userRev"),
                Timestamp.valueOf(LocalDateTime.now())
        );

        if(check == null) {
            ctx.setVariable("errorMsg", "Error");
            templateEngine.process(path, ctx, response.getWriter());
        }

        return;
    }

}
