package entities;

import javax.persistence.Column;
import javax.persistence.Id;

import java.io.Serializable;

public class QuestionnairePK implements Serializable {
    private int idProduct;
    private int idQuestion;

    @Column(name = "id_product", nullable = false)
    @Id
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @Column(name = "id_question", nullable = false)
    @Id
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

        QuestionnairePK that = (QuestionnairePK) o;

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
}
