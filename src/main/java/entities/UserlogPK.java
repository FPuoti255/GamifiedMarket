package entities;

import javax.persistence.Column;
import javax.persistence.Id;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserlogPK implements Serializable {
    private int idUser;
    private Timestamp datetime;

    public UserlogPK() {
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

        UserlogPK userlogPK = (UserlogPK) o;

        if (idUser != userlogPK.idUser) return false;
        if (datetime != null ? !datetime.equals(userlogPK.datetime) : userlogPK.datetime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + (datetime != null ? datetime.hashCode() : 0);
        return result;
    }
}
