package services;

import Utils.QuestionnaireSection;
import Utils.UserAction;
import entities.*;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.*;
import javax.enterprise.context.SessionScoped;
import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.transaction.NotSupportedException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;

/**
 * Http Session is a perfect storage place where all request from same web client have access
 * to all attributes stored in http session. So you ask for it from the container and keep it in a place (http session)
 * from where it can be referred again by all requests for same session.
 * Therefore, if in the session there's no attribute userQuestionnaire, it means that it's the first time the user is fulfilling
 * the product's questionnaire
 */
@SessionScoped
@Stateful
@TransactionManagement(TransactionManagementType.BEAN)
public class UserQuestionnaire implements Serializable {
    /*
        Usually, an EntityManager lives and dies within a JTA transaction.
        Once the transaction is finished, all persistent objects are detached from the EntityManager and are no longer managed.
        Any local caching the EntityManager instance had done is lost.
        Long-living EntityManagers, that live beyond the scope of a JTA transaction, are called an Extended Persistence Context.
        When you specify that an injected EntityManager is an extended persistence context, all object instances remain managed.
     */
    @PersistenceContext(unitName = "gamified_market", type = PersistenceContextType.EXTENDED)
    EntityManager em;

    @EJB(beanName = "Logger")
    Logger logger;

    @Resource
    private UserTransaction utx;

    QuestionnaireSection currentUserSection;

    Product product;
    List<Questionnaire> questions;

    final List<Answer> userMarketingAnswers = new ArrayList<>();
    final List<Answer> userStatisticalAnswers = new ArrayList<>();

    @EJB(name = "ProductService")
    ProductService pdrService;

    public UserQuestionnaire() {
    }



    @PostConstruct
    public void initialize() {
        currentUserSection = QuestionnaireSection.MARKETING;
        product = pdrService.getProductOfTheDay();
        questions = (List<Questionnaire>) pdrService.getProductOfTheDay().getQuestionnairesByIdProduct();
    }

    public void insertSingleAnswer(Answer asw) throws Exception {
        int returned = (int) em.createNativeQuery("select insert_answer(?,?,?,?)")
                .setParameter(1, asw.getIdProduct())
                .setParameter(2, asw.getIdUser())
                .setParameter(3, asw.getIdQuestion())
                .setParameter(4, asw.getAnswerText()).getSingleResult();
        if (returned == -1) {
            throw new IllegalArgumentException(); // swears alert
        }
    }

    public int validateUserQuestionnaire() throws SystemException, NotSupportedException {
        utx.begin();
        try {
            for (Answer asw : this.userMarketingAnswers) {
                insertSingleAnswer(asw);
            }
            if(! this.userStatisticalAnswers.isEmpty()){
                for (Answer asw : this.userStatisticalAnswers) {
                    insertSingleAnswer(asw);
                }

            }
            utx.commit();
            // todo testami un botto (come jacoco)
            logger.logAction(
                    this.userMarketingAnswers.get(0).getIdUser(),
                    UserAction.SUBMITTED,
                    product.getIdProduct()
            );
        } catch (IllegalArgumentException e) {
            utx.rollback();
            logger.logAction(
                    this.userMarketingAnswers.get(0).getIdUser(),
                    UserAction.BANNED,
                    null
            );
            return -1;
        } catch (Exception x){
            utx.rollback();
            return -1;
        }
        return 1;
    }

    public boolean alreadyFulfilled (User currentUser){
        UserQuestionnairePointsPK pk = new UserQuestionnairePointsPK(product.getIdProduct(), currentUser.getIdUser());
        UserQuestionnairePoints uqp = em.find(UserQuestionnairePoints.class, pk);
        return uqp != null;
    }

    @Remove
    public void remove() {
    }

    public List<Questionnaire> getCurrentSectionQuestions() {
        int points = (this.currentUserSection == QuestionnaireSection.MARKETING ? 1 : 2);
        return this.questions.stream()
                .filter(x -> x.getQuestionByIdQuestion().getPoints() == points)
                .collect(Collectors.toList());
    }

    public QuestionnaireSection getCurrentUserSection() {
        return currentUserSection;
    }

    public void setCurrentUserSection(QuestionnaireSection currentUserSection) {
        this.currentUserSection = currentUserSection;
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
        this.userMarketingAnswers.addAll(userMarketingAnswers);
    }

    public List<Answer> getUserStatisticalAnswers() {
        return userStatisticalAnswers;
    }

    public void setUserStatisticalAnswers(List<Answer> userStatisticalAnswers) {
        this.userStatisticalAnswers.addAll(userStatisticalAnswers);
    }

    public void invalidateBean() {
        userMarketingAnswers.clear();
        userStatisticalAnswers.clear();
    }
}
