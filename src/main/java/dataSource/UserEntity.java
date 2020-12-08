package dataSource;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "user", schema = "gamified_market" )
public class UserEntity {
    private int idUser;
    private String username;
    private String email;
    private String password;
    private boolean authorized;
    private int points;
    private boolean admin;
    private boolean active;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_user")
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "authorized")
    public boolean isAuthorized() {
        return authorized;
    }

    public void setAuthorized(boolean authorized) {
        this.authorized = authorized;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "points")
    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "admin")
    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "active")
    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserEntity that = (UserEntity) o;

        if (idUser != that.idUser) return false;
        if (authorized != that.authorized) return false;
        if (points != that.points) return false;
        if (admin != that.admin) return false;
        if (active != that.active) return false;
        if (username != null ? !username.equals(that.username) : that.username != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (authorized ? 1 : 0);
        result = 31 * result + points;
        result = 31 * result + (admin ? 1 : 0);
        result = 31 * result + (active ? 1 : 0);
        return result;
    }
}
