package dataSource;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "question", schema = "gamified_market")
public class QuestionEntity {
    private int idQuestion;
    private String questionText;
    private int points;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_question")
    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "question_text")
    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "points")
    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        QuestionEntity that = (QuestionEntity) o;

        if (idQuestion != that.idQuestion) return false;
        if (points != that.points) return false;
        if (questionText != null ? !questionText.equals(that.questionText) : that.questionText != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idQuestion;
        result = 31 * result + (questionText != null ? questionText.hashCode() : 0);
        result = 31 * result + points;
        return result;
    }
}
