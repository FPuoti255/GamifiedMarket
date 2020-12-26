package services;

import entities.Answer;
import entities.Product;
import entities.Questionnaire;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Remove;
import javax.ejb.Stateful;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.PersistenceContextType;

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
    EntityManager em ;

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
    public void initialize(){
        currentUserSection = 0;
        product = pdrService.getProductOfTheDay();
        questions = (List<Questionnaire>) pdrService.getProductOfTheDay().getQuestionnairesByIdProduct();
        userMarketingAnswers = new ArrayList<>();
        userStatisticalAnswers = new ArrayList<>();
    }

    @Remove
    public void validateUserQuestionnaire(){

    }

    public List<Questionnaire> getCurrentSectionQuestions(){
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
