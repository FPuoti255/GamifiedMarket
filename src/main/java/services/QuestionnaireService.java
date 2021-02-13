package services;

import entities.Answer;
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

    /**
     * given an id of a product, this method gets all the questions of the correlated questionnaire
     * @param IdProduct the searched id
     * @return the list of the questions
     */
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
     * given a product and a question's id it creates a new entry in questionnaires table to line them
     */
    public void linkQuestionToProduct(int questionId, int productId){
        em.persist(new Questionnaire(
                productId,
                questionId
        ));
        em.flush();
    }

}
