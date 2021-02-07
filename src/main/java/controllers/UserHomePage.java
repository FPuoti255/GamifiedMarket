package controllers;

import Utils.UserAction;
import entities.Product;
import entities.Review;
import entities.User;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.Logger;
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

    @EJB(beanName = "Logger")
    Logger logger;

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
        renderPage(request, response, null);
    }

    protected void renderPage(HttpServletRequest request, HttpServletResponse response, String errorMsg) throws IOException {

        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());

        if (errorMsg != null) {
            ctx.setVariable("errorMsg", errorMsg);
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }

        Product dayProduct;
        List<Review> reviews;
        try {
            dayProduct = pdrService.getProductOfTheDay();
            reviews = pdrService.getReviews(dayProduct.getIdProduct());
        } catch (Throwable e) {
            ctx.setVariable("errorMsg", "Ops, something went wrong");
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }
        ctx.setVariable("product", dayProduct);
        ctx.setVariable("reviews", reviews);
        ctx.setVariable("user", (User) request.getSession().getAttribute("user"));
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User sessionUser = (User) request.getSession().getAttribute("user");
        Product pdr = pdrService.getProductOfTheDay();

        Review check = pdrService.addReview(
                pdr.getIdProduct(),
                sessionUser.getIdUser(),
                request.getParameter("userRev"),
                Timestamp.valueOf(LocalDateTime.now())
        );

        if (check == null) {
            renderPage(request, response, "Ops, something went wrong");
        } else {
            logger.logAction(
                    sessionUser.getIdUser(),
                    UserAction.LEAVE_REVIEW,
                    pdr.getIdProduct()
            );
            renderPage(request, response, null);
        }
    }

}
