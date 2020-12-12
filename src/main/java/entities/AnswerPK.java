package entities;

import javax.persistence.Column;
import javax.persistence.Id;

import java.io.Serializable;
import java.util.Objects;

public class AnswerPK implements Serializable {
    private int idProduct;
    private int idUser;
    private int idQuestion;

    public AnswerPK() {
    }
    @Column(name = "id_product", nullable = false)
    @Id
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AnswerPK answerPK = (AnswerPK) o;
        return idProduct == answerPK.idProduct && idUser == answerPK.idUser && idQuestion == answerPK.idQuestion;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idProduct, idUser, idQuestion);
    }
}
