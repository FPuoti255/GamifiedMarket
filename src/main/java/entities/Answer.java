package entities;


import org.eclipse.persistence.annotations.NamedStoredFunctionQuery;
import org.eclipse.persistence.annotations.StoredProcedureParameter;

import javax.persistence.*;

@Entity
@Table(name = "answer")
@IdClass(AnswerPK.class)
@NamedQueries({
        @NamedQuery(name = "Answer.getAllAnswers", query = "SELECT a FROM Answer a")
})
public class Answer {
    public Answer() {
    }

    private int idProduct;
    private int idUser;
    private int idQuestion;
    private String answerText;
    private Product productByIdProduct;
    private User userByIdUser;
    private Question questionByIdQuestion;

    @Id
    @Column(name = "id_product", nullable = false)
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }


    @Column(name = "id_user", nullable = false)
    @Id
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }


    @Column(name = "id_question", nullable = false)
    @Id
    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }


    @Column(name = "answer_text", nullable = false, length = -1)
    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Answer answer = (Answer) o;

        if (idProduct != answer.idProduct) return false;
        if (idUser != answer.idUser) return false;
        if (idQuestion != answer.idQuestion) return false;
        if (answerText != null ? !answerText.equals(answer.answerText) : answer.answerText != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idProduct;
        result = 31 * result + idUser;
        result = 31 * result + idQuestion;
        result = 31 * result + (answerText != null ? answerText.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "id_product", referencedColumnName = "id_product")
    public Product getProductByIdProduct() {
        return productByIdProduct;
    }

    public void setProductByIdProduct(Product productByIdProduct) {
        this.productByIdProduct = productByIdProduct;
    }

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "id_user", referencedColumnName = "id_user")
    public User getUserByIdUser() {
        return userByIdUser;
    }

    public void setUserByIdUser(User userByIdUser) {
        this.userByIdUser = userByIdUser;
    }

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "id_question", referencedColumnName = "id_question")
    public Question getQuestionByIdQuestion() {
        return questionByIdQuestion;
    }

    public void setQuestionByIdQuestion(Question questionByIdQuestion) {
        this.questionByIdQuestion = questionByIdQuestion;
    }
}
