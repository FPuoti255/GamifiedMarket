package controllers;

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

@WebServlet(name = "QuestionnaireSummary", value = "/QuestionnaireSummary")
public class QuestionnaireSummary extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "QuestionnaireSummary";

    @EJB(beanName = "QuestionnaireService")
    QuestionnaireService questionnaireService;

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
        final WebContext ctx = new WebContext(req, resp, getServletContext(), req.getLocale());

        ctx.setVariable("answers", questionnaireService.retrieveAllQuestionnaires());

        templateEngine.process(path, ctx, resp.getWriter());
    }
}























