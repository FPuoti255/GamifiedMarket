package dataSource;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserlogEntityPK implements Serializable {
    private int idUser;
    private Timestamp datetime;

    @jakarta.persistence.Column(name = "id_user")
    @jakarta.persistence.Id
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @jakarta.persistence.Column(name = "datetime")
    @jakarta.persistence.Id
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

        UserlogEntityPK that = (UserlogEntityPK) o;

        if (idUser != that.idUser) return false;
        if (datetime != null ? !datetime.equals(that.datetime) : that.datetime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + (datetime != null ? datetime.hashCode() : 0);
        return result;
    }
}
