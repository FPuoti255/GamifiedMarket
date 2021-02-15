package controllers;

import Utils.DateAlreadySelected;
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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AddNewProduct", value = "/AddNewProduct")
@MultipartConfig
public class AddNewProduct extends HttpServlet {

    @EJB(beanName = "ProductService")
    ProductService products;

    @EJB(beanName = "QuestionService")
    QuestionService qstService;

    @EJB(beanName = "QuestionnaireService")
    QuestionnaireService questionnaireService;

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "AddNewProductPage";

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
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        renderPage(req, resp, null);
    }

    private void renderPage(HttpServletRequest req, HttpServletResponse resp, String errorMsg) throws IOException {
        final WebContext context = new WebContext(req, resp, getServletContext(), req.getLocale());

        context.setVariable("errorMsg", errorMsg);
        context.setVariable("questions",
                //The statistical are fixed. Only the marketing can be added.
                // It could be kind to suggest some of them.
                qstService.getAllQuestions().stream().filter( x -> x.getPoints() == 1)
                        .collect(Collectors.toList()));
        context.setVariable("today", LocalDate.now());
        templateEngine.process(path, context, resp.getWriter());
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productName =  req.getParameter("productName");

        String insertedDate = req.getParameter("productDate");
        Date productDate = null;

        Part productImage = req.getPart("productImage");
        byte[] image = null;

        if(productName!=null && productImage!=null && insertedDate !=null){
            /*Image Parsing*/
            InputStream imageStream = productImage.getInputStream();
            String filename = productImage.getSubmittedFileName();
            String mimeType = getServletContext().getMimeType(filename);
            if ((imageStream.available() != 0)) {
                if (!mimeType.startsWith("image/")) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                    return;
                }
                image = imageStream.readAllBytes();
            }
            /*Date parsing*/
            if(! Date.valueOf(insertedDate).before(Date.valueOf(LocalDate.now()))){
                productDate = Date.valueOf(insertedDate);
            }else{
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        assert(image != null);
        assert (productDate != null);

        //Checking the inserted questions
        String textArea = req.getParameter("questionText");
        String[] insertedQuestions = null;
        if( textArea!=null && !textArea.isEmpty()) insertedQuestions = textArea.split("\r\n");

        //Checking the questions selected among those proposed
        List<Question> selectedQst =
                qstService.getAllQuestions().stream()
                        .filter(x -> x.getPoints() == 1
                                && req.getParameter(Integer.toString(x.getIdQuestion())) != null)
                        .collect(Collectors.toList());

        if(insertedQuestions == null && selectedQst.isEmpty()){
            renderPage(req, resp, "You have to insert at least one marketing question.");
            return;
        }


        Product p;
        try{
            p = products.addProduct(
                    productName,
                    image,
                    productDate);
            if( p == null){
                renderPage(req, resp, "Ops something went wrong!");
                return;
            }
        }catch (DateAlreadySelected ds) {
            renderPage(req, resp, "The selected date has been already chosen for another product!");
            return;
        }

        //Linking the product to the questions selected among those proposed
        for( Question qst : selectedQst){
            questionnaireService.linkQuestionToProduct(
                    qst.getIdQuestion(),
                    p.getIdProduct()
            );
        }

        //Inserting and linking to the product the new questions inserted by the admin
        if(insertedQuestions != null){
            Question newQst;
            for (String qst : insertedQuestions) {
                newQst = qstService.addQuestion(qst, 1);
                questionnaireService.linkQuestionToProduct(
                        newQst.getIdQuestion(),
                        p.getIdProduct()
                );
            }
        }

        renderPage(req, resp,
                "You have successfully inserted the new product!\nUse the navbar-link to go back to your home page.");
    }

}
