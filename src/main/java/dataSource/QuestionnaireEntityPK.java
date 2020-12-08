package dataSource;

import java.io.Serializable;

public class QuestionnaireEntityPK implements Serializable {
    private int idProduct;
    private int idQuestion;

    @jakarta.persistence.Column(name = "id_product")
    @jakarta.persistence.Id
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @jakarta.persistence.Column(name = "id_question")
    @jakarta.persistence.Id
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

        QuestionnaireEntityPK that = (QuestionnaireEntityPK) o;

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
