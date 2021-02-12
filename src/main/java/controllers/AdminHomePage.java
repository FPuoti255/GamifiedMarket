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
import java.util.stream.Collectors;

@WebServlet(name = "AdminHomePage", value = "/AdminHomePage")
@MultipartConfig
public class AdminHomePage extends HttpServlet {
    @EJB(beanName = "ProductService")
    ProductService products;

    @EJB(beanName = "QuestionService")
    QuestionService qstService;

    @EJB(beanName = "QuestionnaireService")
    QuestionnaireService questionnaireService;

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "AdminHomePage";

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
     * main method of the servlet, override of the original HttpServlet.doGet method.
     * renders the landing page of the administration, in the form of a "create new product" / "add
     * questionnaire to current product" page
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        renderPage(req, resp, null);
    }

    private void renderPage(HttpServletRequest req, HttpServletResponse resp, String errorMsg) throws IOException {
        final WebContext context = new WebContext(req, resp, getServletContext(), req.getLocale());

        Product dayProduct = products.getProductOfTheDay();
        context.setVariable("errorMsg", errorMsg);
        context.setVariable("product", dayProduct);
        context.setVariable("qstsProposed",
                qstService.getAllQuestions().stream().filter( x -> x.getPoints() == 2) //Only the marketing can be added (from assignment)
                        .collect(Collectors.toList()));
        context.setVariable("today", LocalDate.now());
        templateEngine.process(path, context, resp.getWriter());
    }

    /**
     * this method intercepts the action of adding a product to the application
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
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


        /**
         * marshal the parameters from the form and invoke the
         * productService to add the product to the database
         */
        Product p = null;
        try{
            p = products.addProduct(
                    productName,
                    image,
                    productDate);
        }catch (DateAlreadySelected ds) {
            renderPage(req, resp, "The selected date has been already chosen for another product!");
            return;
        }

        if( p == null){
            renderPage(req, resp, "Ops something went wrong!");
            return;
        }

        //Inserting questions to the product questionnaire
        for(Question qst : qstService.getAllQuestions()){
            if(req.getParameter(Integer.toString(qst.getIdQuestion())) != null){
                questionnaireService.linkQuestionToProduct(qst.getIdQuestion(), p.getIdProduct());
            }
        }

        renderPage(req, resp, null);
    }
}
