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

    public void linkQuestionToProduct(Question q, Product p){
        em.persist(new Questionnaire(
                p.getIdProduct(),
                q.getIdQuestion()
        ));
        em.flush();
    }
}
