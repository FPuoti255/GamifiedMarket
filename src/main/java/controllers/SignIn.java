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
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "SignIn", value = "/SignIn")
public class SignIn extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "index";

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
        String email = request.getParameter("email"), //email is the id of the field in the form
                pwd = request.getParameter("password"); //same as above

        if (email == null || email.isEmpty() ||
                pwd == null || pwd.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        User user = usrService.checkCredentials(email, pwd);

        if (user == null) {
            final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
            ctx.setVariable("errorMsg", "Invalid Credentials");
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }
        request.getSession().setAttribute("user", user);
        String servlet = user.isAdmin() ? "AdminHomePage" : "UserHomePage";
        response.sendRedirect(servlet);
    }
}
