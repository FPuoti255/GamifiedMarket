package controllers;

import entities.Answer;
import entities.Product;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "QuestionnaireSummary", value = "/QuestionnaireSummary")
public class QuestionnaireSummary extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "QuestionnaireSummaryPage.html";

    @EJB(beanName = "ProductService")
    ProductService productService;

    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        templateResolver.setPrefix("/WEB-INF/templates/");
        templateResolver.setSuffix(".html");
        templateEngine.setTemplateResolver(templateResolver);
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("user");

        List<Answer> answers = (List<Answer>) currentUser.getAnswersByIdUser();
        List<Product> products = answers.stream().map(Answer::getIdProduct)
                .distinct().map( x -> productService.getProductById(x))
                .collect(Collectors.toList());

        Map<Product, List<Answer>> userQuestionnaires = new HashMap<>();

        for(Product pdr : products){
            userQuestionnaires.put(
                    pdr,
                    answers.stream().filter(x -> x.getIdProduct() == pdr.getIdProduct()).collect(Collectors.toList())
            );
        }

        final WebContext ctx = new WebContext(req, resp, getServletContext(), req.getLocale());
        ctx.setVariable("summary", userQuestionnaires);
        templateEngine.process(path, ctx, resp.getWriter());
    }
}























