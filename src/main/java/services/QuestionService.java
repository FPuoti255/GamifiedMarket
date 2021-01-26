package services;

import entities.Question;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless(name = "QuestionService")
public class QuestionService {
    @PersistenceContext(unitName = "gamified_market")
    private EntityManager em;

    public QuestionService() {
    }

    public Question addQuestion(String questionText, int questionPoints){
        Question q = new Question(
            questionText,
            questionPoints
        );
        em.persist(q);
        em.flush();
        return q;
    }
}
