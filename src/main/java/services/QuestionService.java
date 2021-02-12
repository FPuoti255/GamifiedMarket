package services;

import entities.Question;
import entities.Questionnaire;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;

@Stateless(name = "QuestionService")
public class QuestionService {
    @PersistenceContext(unitName = "gamified_market")
    private EntityManager em;

    public QuestionService() {
    }

    /**
     * adds a question to the database
     */
    public Question addQuestion(String questionText, int questionPoints){
        Question q = new Question(
            questionText,
            questionPoints
        );
        em.persist(q);
        em.flush();
        return q;
    }



    /**
     * I know we've defined the named query, but it does not work
     * @param qText the text of the question searched
     * @return the question id
     */
    public int findQuestionByText(String qText){
        for(Question q : em.createNamedQuery("Question.findAllQuestions", Question.class).getResultList()){
            if(q.getQuestionText().equals(qText)) return q.getIdQuestion();
        }
        return -1;
    }

    public List<Question> getAllQuestions() {
        return em.createNamedQuery("Question.findAllQuestions", Question.class).getResultList();
    }

}
