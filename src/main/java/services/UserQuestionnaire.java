package services;

import entities.Answer;
import entities.Product;
import entities.Questionnaire;
import org.eclipse.persistence.annotations.StoredProcedureParameter;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.*;
import javax.persistence.*;
import java.sql.SQLData;
import java.sql.SQLType;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.criteria.CriteriaBuilder;
import javax.transaction.NotSupportedException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;

@Stateful(name = "UserQuestionnaire")
public class UserQuestionnaire {
    /*
    Usually, an EntityManager lives and dies within a JTA transaction.
    Once the transaction is finished, all persistent objects are detached from the EntityManager and are no longer managed.
    Any local caching the EntityManager instance had done is lost.
    Long-living EntityManagers, that live beyond the scope of a JTA transaction, are called an Extended Persistence Context.
    When you specify that an injected EntityManager is an extended persistence context, all object instances remain managed.
     */
    @PersistenceContext(unitName = "gamified_market", type = PersistenceContextType.EXTENDED)
    EntityManager em;

    @Resource
    private UserTransaction utx;

    // we assume 0 for marketing section and 1 for statistical section
    int currentUserSection;

    public int getCurrentUserSection() {
        return currentUserSection;
    }

    public void setCurrentUserSection(int currentUserSection) {
        this.currentUserSection = currentUserSection;
    }

    Product product;
    List<Questionnaire> questions;

    List<Answer> userMarketingAnswers;
    List<Answer> userStatisticalAnswers;

    @EJB(name = "ProductService")
    ProductService pdrService;

    public UserQuestionnaire() {
    }

    @PostConstruct
    public void initialize() {
        currentUserSection = 0;
        product = pdrService.getProductOfTheDay();
        questions = (List<Questionnaire>) pdrService.getProductOfTheDay().getQuestionnairesByIdProduct();
        userMarketingAnswers = new ArrayList<>();
        userStatisticalAnswers = new ArrayList<>();
    }

    public void insertSingleAnswer(Answer asw) throws Exception {
        int returned = (int) em.createNativeQuery("select insert_answer(?,?,?,?)")
                .setParameter(1, asw.getIdProduct())
                .setParameter(2, asw.getIdUser())
                .setParameter(3, asw.getIdQuestion())
                .setParameter(4, asw.getAnswerText()).getSingleResult();
        if (returned == -1) {
            throw new Exception();
        }
    }

    public void validateUserQuestionnaire() throws SystemException, NotSupportedException {
        utx.begin();
        try {
            for (Answer asw : this.userMarketingAnswers) {
                insertSingleAnswer(asw);
            }
            for (Answer asw : this.userStatisticalAnswers) {
                insertSingleAnswer(asw);
            }
            utx.commit();
        } catch (Exception e) {
            utx.rollback();
        }
    }

    @Remove
    public void remove() {
    }

    public List<Questionnaire> getCurrentSectionQuestions() {
        int points = (this.currentUserSection == 0 ? 1 : 2);
        return this.questions.stream()
                .filter(x -> x.getQuestionByIdQuestion().getPoints() == points)
                .collect(Collectors.toList());
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Questionnaire> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Questionnaire> questions) {
        this.questions = questions;
    }

    public List<Answer> getUserMarketingAnswers() {
        return userMarketingAnswers;
    }

    public void setUserMarketingAnswers(List<Answer> userMarketingAnswers) {
        this.userMarketingAnswers = userMarketingAnswers;
    }

    public List<Answer> getUserStatisticalAnswers() {
        return userStatisticalAnswers;
    }

    public void setUserStatisticalAnswers(List<Answer> userStatisticalAnswers) {
        this.userStatisticalAnswers = userStatisticalAnswers;
    }
}
