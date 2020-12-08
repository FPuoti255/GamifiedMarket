package dataSource;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "answer", schema = "gamified_market")
public class AnswerEntity {
    private String answerText;

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "answer_text")
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

        AnswerEntity that = (AnswerEntity) o;

        if (answerText != null ? !answerText.equals(that.answerText) : that.answerText != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return answerText != null ? answerText.hashCode() : 0;
    }
}
