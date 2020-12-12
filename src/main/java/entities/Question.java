package entities;

import javax.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "question")
public class Question {
    private int idQuestion;
    private String questionText;
    private int points;
    private Collection<Answer> answersByIdQuestion;
    private Collection<Questionnaire> questionnairesByIdQuestion;

    public Question() {
    }

    @Id
    @Column(name = "id_question", nullable = false)
    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }


    @Column(name = "question_text", nullable = false, length = 255)
    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }


    @Column(name = "points", nullable = false)
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

        Question question = (Question) o;

        if (idQuestion != question.idQuestion) return false;
        if (points != question.points) return false;
        if (questionText != null ? !questionText.equals(question.questionText) : question.questionText != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idQuestion;
        result = 31 * result + (questionText != null ? questionText.hashCode() : 0);
        result = 31 * result + points;
        return result;
    }

    @OneToMany(mappedBy = "questionByIdQuestion")
    public Collection<Answer> getAnswersByIdQuestion() {
        return answersByIdQuestion;
    }

    public void setAnswersByIdQuestion(Collection<Answer> answersByIdQuestion) {
        this.answersByIdQuestion = answersByIdQuestion;
    }

    @OneToMany(mappedBy = "questionByIdQuestion")
    public Collection<Questionnaire> getQuestionnairesByIdQuestion() {
        return questionnairesByIdQuestion;
    }

    public void setQuestionnairesByIdQuestion(Collection<Questionnaire> questionnairesByIdQuestion) {
        this.questionnairesByIdQuestion = questionnairesByIdQuestion;
    }
}
