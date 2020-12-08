package dataSource;

import java.sql.Timestamp;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "userlog", schema = "gamified_market" )
@jakarta.persistence.IdClass(UserlogEntityPK.class)
public class UserlogEntity {
    private int idUser;
    private Timestamp datetime;
    private String action;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_user")
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "datetime")
    public Timestamp getDatetime() {
        return datetime;
    }

    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "action")
    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserlogEntity that = (UserlogEntity) o;

        if (idUser != that.idUser) return false;
        if (datetime != null ? !datetime.equals(that.datetime) : that.datetime != null) return false;
        if (action != null ? !action.equals(that.action) : that.action != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + (datetime != null ? datetime.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        return result;
    }
}
