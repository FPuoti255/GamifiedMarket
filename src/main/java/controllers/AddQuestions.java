package controllers;

import entities.Question;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.ProductService;
import services.QuestionnaireService;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddQuestions", value = "/AddQuestions")
public class AddQuestions extends HttpServlet {
    @EJB(beanName = "ProductService")
    ProductService products;

    @EJB(beanName = "QuestionnaireService")
    QuestionnaireService questions;

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "AddQuestions";

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
     * loads the list of questions already correlated to this product, which is also added to the context
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final WebContext context = new WebContext(req, resp, getServletContext(), req.getLocale());
        context.setVariable("product", products.getProductOfTheDay());
        context.setVariable(
                "questions",
                questions.retrieveQuestions(
                        products.getProductOfTheDay().getIdProduct()
                ));

        templateEngine.process(path, context, resp.getWriter());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // prepare the question to be added
        // statistical questions got double points
        questions.addQuestion(
                products.getProductOfTheDay().getIdProduct(),
                req.getParameter("questionText"),
                req.getParameter("facultativeQuestion") == "true" ? 2 : 1
        );

        resp.sendRedirect(path);
    }
}
