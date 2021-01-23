package controllers;

import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddQuestions", value = "/AddQuestions")
public class AddQuestions extends HttpServlet {

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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final WebContext context = new WebContext(req, resp, getServletContext(), req.getLocale());

        templateEngine.process(path, context, resp.getWriter());
    }
}
