package entities;

import javax.persistence.*;

@Entity
@Table(name = "questionnaire")
@IdClass(QuestionnairePK.class)
@NamedQueries({
        @NamedQuery(name = "Questionnaire.getQuestions", query = "SELECT q from Questionnaire q WHERE q.idProduct = ?1")
})
public class Questionnaire {
    private int idProduct;
    private int idQuestion;
    private Product productByIdProduct;
    private Question questionByIdQuestion;

    public Questionnaire() {
    }

    @Id
    @Column(name = "id_product", nullable = false)
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @Id
    @Column(name = "id_question", nullable = false)
    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Questionnaire that = (Questionnaire) o;

        if (idProduct != that.idProduct) return false;
        if (idQuestion != that.idQuestion) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idProduct;
        result = 31 * result + idQuestion;
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
    @PrimaryKeyJoinColumn(name = "id_question", referencedColumnName = "id_question")
    public Question getQuestionByIdQuestion() {
        return questionByIdQuestion;
    }

    public void setQuestionByIdQuestion(Question questionByIdQuestion) {
        this.questionByIdQuestion = questionByIdQuestion;
    }
}
