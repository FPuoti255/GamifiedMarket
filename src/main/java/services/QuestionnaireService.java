package services;

import entities.Answer;
import entities.Product;
import entities.Questionnaire;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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

    public List<Answer> retrieveAllQuestionnaires() {
        return em.createNamedQuery("Answer.getAllAnswers", Answer.class).getResultList();
    }
}
