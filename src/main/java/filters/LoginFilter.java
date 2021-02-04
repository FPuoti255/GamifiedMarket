package filters;

import entities.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "LoginFilter")
public class LoginFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String loginpath = req.getServletContext().getContextPath() + "/index.html";
        User user = (User) ((HttpServletRequest) req).getSession().getAttribute("user");
        if (request.getSession().isNew() || user == null) {
            response.sendRedirect(loginpath);
            return;
        }
        chain.doFilter(req, resp);
    }
}
