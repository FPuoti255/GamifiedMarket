package entities;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Timestamp;

public class QuestionnaireLogPK implements Serializable {
    private int idUser;
    private Timestamp datetime;

    public QuestionnaireLogPK() {
    }

    @Column(name = "id_user", nullable = false)
    @Id
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @Column(name = "datetime", nullable = false)
    @Id
    public Timestamp getDatetime() {
        return datetime;
    }

    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        QuestionnaireLogPK questionnaireLogPK = (QuestionnaireLogPK) o;

        if (idUser != questionnaireLogPK.idUser) return false;
        if (datetime != null ? !datetime.equals(questionnaireLogPK.datetime) : questionnaireLogPK.datetime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + (datetime != null ? datetime.hashCode() : 0);
        return result;
    }
}
