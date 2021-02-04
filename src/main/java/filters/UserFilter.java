package filters;


import entities.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "UserFilter")
public class UserFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        User user = ((User) request.getSession().getAttribute("user"));
        if (user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You are not authorized to access this page, please go back");
            return;
        }
        chain.doFilter(req, resp);
    }
}
