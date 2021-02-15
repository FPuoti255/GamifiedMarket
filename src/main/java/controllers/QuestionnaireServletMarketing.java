package controllers;

import Utils.QuestionnaireSection;
import entities.*;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.ProductService;
import services.UserQuestionnaire;

import javax.ejb.EJB;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


/*
 * First page of the questionnaire: The marketing section is loaded and the user can starts filling the questionnaire
 */
@WebServlet(name = "QuestionnaireServletMarketing", value = "/QuestionnaireServletMarketing")
public class QuestionnaireServletMarketing extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "QuestionnairePage";

    @Inject
    UserQuestionnaire userQuestionnaire;


    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        templateResolver.setPrefix("/WEB-INF/templates/");
        templateResolver.setSuffix(".html");
        templateEngine.setTemplateResolver(templateResolver);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");


        List<Answer> userAnswers = new ArrayList<>();
        Answer answer;

        for (Questionnaire qst : userQuestionnaire.getCurrentSectionQuestions()) {
            answer = new Answer();
            answer.setIdUser(user.getIdUser());
            answer.setIdProduct(userQuestionnaire.getProduct().getIdProduct());
            answer.setIdQuestion(qst.getIdQuestion());
            answer.setAnswerText(request.getParameter(String.valueOf(qst.getIdQuestion())));
            answer.setQuestionByIdQuestion(qst.getQuestionByIdQuestion());
            if (answer.getAnswerText() == null || answer.getAnswerText().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            userAnswers.add(answer);
        }

        userQuestionnaire.setUserMarketingAnswers(userAnswers);
        userQuestionnaire.setCurrentUserSection(QuestionnaireSection.STATISTICAL);

        response.sendRedirect(request.getContextPath() + "/QuestionnaireServletStatistical");
    }


    /**
     * If userCurrentSection is equal to Marketing, it means that it's the first time the user visits the questionnaire;
     * Otherwise, if the user current section is equal to Statistical, it means that the user is coming from the
     * statistical section, thus s/he has already answered the mandatory marketing questions.
     */
    public void renderMarketingPage(HttpServletRequest request, HttpServletResponse response, String errorMsg) throws IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());

        if (errorMsg != null) {
            ctx.setVariable("errorMsg", errorMsg);
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }

        ctx.setVariable("product", userQuestionnaire.getProduct());
        ctx.setVariable("questions", userQuestionnaire.getCurrentSectionQuestions());
        templateEngine.process(path, ctx, response.getWriter());
    }

    public void renderToBeReviewed(HttpServletRequest request, HttpServletResponse response, String errorMsg) throws IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());

        if (errorMsg != null) {
            ctx.setVariable("errorMsg", errorMsg);
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }

        userQuestionnaire.setCurrentUserSection(QuestionnaireSection.MARKETING);
        ctx.setVariable("answers", userQuestionnaire.getUserMarketingAnswers());
        ctx.setVariable("product", userQuestionnaire.getProduct());

        templateEngine.process(path, ctx, response.getWriter());
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("user");


        if (userQuestionnaire.getProduct() == null) { //if the product is null, there's no product of the day
            response.sendRedirect("UserHomePage");
            return;
        }

        if (userQuestionnaire.isCancelled()) {
            userQuestionnaire.reset();
            renderMarketingPage(request, response, null);
        } else if (userQuestionnaire.getCurrentUserSection() == QuestionnaireSection.STATISTICAL ||
                !userQuestionnaire.getUserMarketingAnswers().isEmpty()) {
            renderToBeReviewed(request, response, null);
        } else {
            renderMarketingPage(request, response,
                    userQuestionnaire.alreadyFulfilled(currentUser) ? "You have already fulfilled the questionnaire for this product!" : null);
        }
    }
}
