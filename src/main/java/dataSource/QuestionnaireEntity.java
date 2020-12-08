package dataSource;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "questionnaire", schema = "gamified_market" )
@jakarta.persistence.IdClass(QuestionnaireEntityPK.class)
public class QuestionnaireEntity {
    private int idProduct;
    private int idQuestion;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_product")
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_question")
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

        QuestionnaireEntity that = (QuestionnaireEntity) o;

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
