package controllers;

import entities.User;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.UserService;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet(name = "SignUp", value = "/SignUp")
public class SignUp extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private String path;

    @EJB(beanName = "UserService")
    UserService usrService;

    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        templateResolver.setSuffix(".html");
        templateEngine.setTemplateResolver(templateResolver);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
        path = "/WEB-INF/templates/SignUpPage";

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null ||
                username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            ctx.setVariable("errorMsg", "Invalid inserted credentials");
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }


        User newUser = usrService.registerNewUser(username, email, password);
        if (newUser == null) {
            ctx.setVariable("errorMsg", "Invalid data, username or password already present");
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }
        response.sendRedirect("index.html");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //when the servlet is called with a DoGet, it's display the sign up form
        path = "/WEB-INF/templates/SignUpPage";
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
        templateEngine.process(path, ctx, response.getWriter());
    }
}
