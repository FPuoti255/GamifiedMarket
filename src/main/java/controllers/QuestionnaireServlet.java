package controllers;

import entities.*;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.ProductService;
import services.QuestionnaireService;
import services.UserQuestionnaire;
import services.UserService;

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
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "QuestionnaireServlet", value = "/QuestionnaireServlet")
public class QuestionnaireServlet extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private String path;

    @EJB(beanName = "UserQuestionnaire")
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

        // case in which I'm arriving from the marketing section
        if (userQuestionnaire.getCurrentUserSection() == 0) {
            userQuestionnaire.setUserMarketingAnswers(userAnswers);
            userQuestionnaire.setCurrentUserSection(1);
            renderStatisticalPage(request, response);
        } else {
            userQuestionnaire.setUserStatisticalAnswers(userAnswers);
            if (request.getParameter("turnBack") != null) {
                renderMarketingPage(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/UserHomePage");
            }
        }
    }

    public void renderStatisticalPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
        path = "StatisticalSection";

        try{
            //case in which it's the first time the user visits the statistical section
            if (userQuestionnaire.getUserStatisticalAnswers().isEmpty()) {
                ctx.setVariable("questions", userQuestionnaire.getCurrentSectionQuestions());
            } else { //the user is reviewing his/her answers
                ctx.setVariable("answers", userQuestionnaire.getUserStatisticalAnswers());
            }
            ctx.setVariable("product", userQuestionnaire.getProduct());
        }catch (Throwable e){
            ctx.setVariable("errorMsg", "Ops, something went wrong!");
        }
        templateEngine.process(path, ctx, response.getWriter());
    }

    public void renderMarketingPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
        path = "QuestionnairePage";

        try {
            if (userQuestionnaire.getCurrentUserSection() == 1) {
                ctx.setVariable("answers", userQuestionnaire.getUserMarketingAnswers());
                userQuestionnaire.setCurrentUserSection(0);
            } else {
                ctx.setVariable("questions", userQuestionnaire.getCurrentSectionQuestions());
            }
            ctx.setVariable("product", userQuestionnaire.getProduct());

        } catch (Throwable t) {
            ctx.setVariable("errorMsg", "Ops, something went wrong!");
        }
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        renderMarketingPage(request, response);
    }
}
