package controllers;

import entities.Product;
import services.ProductService;
import javax.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "helloServlet", value = "/hello")
public class HelloWorld extends HttpServlet {
    private String message;

    @EJB(beanName = "ProductService")
    private ProductService pdrservice;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        Product prodotto1 = pdrservice.getAllProducts();

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "\nProdotto1 = "+ prodotto1.getName() + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}
