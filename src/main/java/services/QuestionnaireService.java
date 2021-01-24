package services;

import entities.Answer;
import entities.Product;
import entities.Question;
import entities.Questionnaire;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Stateless(name = "QuestionnaireService")
public class QuestionnaireService {

    @PersistenceContext(unitName = "gamified_market")
    private EntityManager em;

    public QuestionnaireService() {
    }

    public List<Questionnaire> retrieveQuestionnaire (int idProduct){
        return em.createNamedQuery("Questionnaire.getQuestions", Questionnaire.class)
                .setParameter(1, idProduct).getResultList();
    }

    public List<Question> retrieveQuestions(int IdProduct){
        // retrieve the linked question's Id to this product
        List<Questionnaire> links = em.createNamedQuery("Questionnaire.getQuestions", Questionnaire.class)
                .setParameter(1, IdProduct).getResultList();

        // correlate the question's Id with his text
        List<Question> questionsLinked = new ArrayList<>();
        for (Questionnaire q : links)
            questionsLinked.add(q.getQuestionByIdQuestion());

        // return the result
        return questionsLinked;
    }

    public List<Answer> retrieveAllQuestionnaires() {
        return em.createNamedQuery("Answer.getAllAnswers", Answer.class).getResultList();
    }

    /**
     * this method creates 2 object: the actual question and the element in
     * the questionnaire table that links the question to the product
     *
     */
    public void addQuestion(int idProduct, String questionText, int questionPoints){
        Question toAdd = new Question(questionText, questionPoints);
        em.persist(toAdd);
        em.flush();
        refresh();

        // todo why in this point the toAdd.getIdQuestion is like not initialized?
        Questionnaire toAddQ = new Questionnaire();
        toAddQ.setIdProduct(idProduct);
        toAddQ.setIdQuestion(toAdd.getIdQuestion());
        em.persist(toAddQ);
        em.flush();
        refresh();
    }

    private void refresh(){
        em.clear();
        List<Question> qs = em.createNamedQuery("Question.findAllQuestions").getResultList();
        for(Question q : qs) em.refresh(q);
        List<Questionnaire> ps = em.createNamedQuery("Questionnaire.getAllQuestionnaires", Questionnaire.class).getResultList();
        for(Questionnaire p : ps) em.refresh(p);
    }
}
