package controllers;

import entities.Answer;
import entities.Product;
import entities.Question;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.ProductService;
import services.QuestionService;
import services.QuestionnaireService;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "InspectQuestionnaire", value = "/InspectQuestionnaire")
public class InspectQuestionnaire extends HttpServlet {
    @EJB(beanName = "ProductService")
    ProductService products;

    @EJB(beanName = "QuestionnaireService")
    QuestionnaireService links;

    private final TemplateEngine engine = new TemplateEngine();
    private final String localPath = "InspectQuestionnaire";

    @Override
    public void init() throws ServletException {
        ServletContext cont = getServletContext();
        ServletContextTemplateResolver resolver = new ServletContextTemplateResolver(cont);

        resolver.setTemplateMode(TemplateMode.HTML);
        resolver.setPrefix("/WEB-INF/templates/");
        resolver.setSuffix(".html");
        engine.setTemplateResolver(resolver);
    }

    /**
     * loads the product passed as parameter in the request and all the questions of its questionnaire
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        WebContext context = new WebContext(req, resp, getServletContext(), req.getLocale());
        int idProduct = Integer.parseInt(req.getParameter("productId"));

        // get the questions
        List<Question> questions = links.retrieveQuestions(idProduct);

        // get all the answers: the template will sort them out accordingly
        List<Answer> answers = new ArrayList<>();
        for(Question q : questions){
            answers.addAll(q.getAnswersByIdQuestion());
        }

        // set up the context variables
        context.setVariable(
                "questions",
                questions
        );

        context.setVariable(
                "answers",
                answers
        );

        context.setVariable(
                "product",
                products.getProductById(idProduct)
        );

        engine.process(localPath, context, resp.getWriter());
    }
}
