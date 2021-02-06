package controllers;

import Utils.QuestionnaireSection;
import Utils.UserAction;
import entities.Answer;
import entities.Questionnaire;
import entities.User;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;
import services.Logger;
import services.UserQuestionnaire;

import javax.ejb.EJB;
import javax.inject.Inject;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.transaction.NotSupportedException;
import javax.transaction.SystemException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "QuestionnaireServletStatistical", value = "/QuestionnaireServletStatistical")
public class QuestionnaireServletStatistical extends HttpServlet {

    private final TemplateEngine templateEngine = new TemplateEngine();
    private final String path = "StatisticalSection";

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (userQuestionnaire.getCurrentUserSection() != QuestionnaireSection.STATISTICAL) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }

        renderStatisticalPage(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (userQuestionnaire.getCurrentUserSection() != QuestionnaireSection.STATISTICAL) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }

        User user = (User) request.getSession().getAttribute("user");
        String msg = "";

        if (request.getParameter("cancelled") != null){
            userQuestionnaire.cancelQuestionnaire(user);
            renderEndQuestionnairePage(request,response, msg = "Your questionnaire has been successfully cancelled.");
            return;
        }

        List<Answer> userAnswers = new ArrayList<>();
        Answer answer;

        for (Questionnaire qst : userQuestionnaire.getCurrentSectionQuestions()) {
            answer = new Answer();
            answer.setIdUser(user.getIdUser());
            answer.setIdProduct(userQuestionnaire.getProduct().getIdProduct());
            answer.setIdQuestion(qst.getIdQuestion());
            answer.setAnswerText(request.getParameter(String.valueOf(qst.getIdQuestion())));
            answer.setQuestionByIdQuestion(qst.getQuestionByIdQuestion());
            if (answer.getAnswerText() != null & !answer.getAnswerText().isEmpty()) {
                userAnswers.add(answer);
            }
        }

        if (!userAnswers.isEmpty()) {
            userQuestionnaire.setUserStatisticalAnswers(userAnswers);
        }

        if (request.getParameter("turnBack") != null) {
            response.sendRedirect(request.getContextPath() + "/QuestionnaireServletMarketing");
        } else {
            try {
                UserAction act = userQuestionnaire.validateUserQuestionnaire();
                if(act == UserAction.BANNED){
                    request.getSession().invalidate();
                    msg = "Ops, we detected swears in your answers. From now on, you're banned from our website.";
                }else  msg = "Thank you for having submitted the questionnaire!" ;

                renderEndQuestionnairePage(request, response, msg);
            }catch( SystemException | NotSupportedException e2){
                e2.printStackTrace();
            }
        }
    }


    public void renderEndQuestionnairePage(HttpServletRequest request, HttpServletResponse response, String msg) throws IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());
        ctx.setVariable("msg", msg);
        String finPage = "EndQuestionnairePage";
        templateEngine.process(finPage, ctx, response.getWriter());
    }

    /**
     * If the statistical answers are empty, it means that is the first time the user visits the statistical section;
     * Otherwise, the user is reviewing his/her statistical answers, thus we have to display them.
     */
    public void renderStatisticalPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        final WebContext ctx = new WebContext(request, response, getServletContext(), request.getLocale());

        try {
            if (userQuestionnaire.getUserStatisticalAnswers().isEmpty()) {
                ctx.setVariable("questions", userQuestionnaire.getCurrentSectionQuestions());
            } else {
                ctx.setVariable("answers", userQuestionnaire.getUserStatisticalAnswers());
            }
            ctx.setVariable("product", userQuestionnaire.getProduct());
        } catch (Throwable e) {
            ctx.setVariable("errorMsg", "Ops, something went wrong!");
        }
        templateEngine.process(path, ctx, response.getWriter());
    }
}
