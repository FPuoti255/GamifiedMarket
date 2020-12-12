package entities;

import javax.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "user")
public class User {
    private int idUser;
    private String username;
    private String email;
    private String password;
    private boolean authorized;
    private int points;
    private boolean admin;
    private boolean active;
    private Collection<Answer> answersByIdUser;
    private Collection<Review> reviewsByIdUser;
    private Collection<Userlog> userlogsByIdUser;

    public User() {
    }

    @Id
    @Column(name = "id_user", nullable = false)
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }


    @Column(name = "username", nullable = false, length = 64)
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    @Column(name = "email", nullable = false, length = 64)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    @Column(name = "password", nullable = false, length = 255)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    @Column(name = "authorized", nullable = false)
    public boolean isAuthorized() {
        return authorized;
    }

    public void setAuthorized(boolean authorized) {
        this.authorized = authorized;
    }


    @Column(name = "points", nullable = false)
    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }


    @Column(name = "admin", nullable = false)
    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }


    @Column(name = "active", nullable = false)
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

        User user = (User) o;

        if (idUser != user.idUser) return false;
        if (authorized != user.authorized) return false;
        if (points != user.points) return false;
        if (admin != user.admin) return false;
        if (active != user.active) return false;
        if (username != null ? !username.equals(user.username) : user.username != null) return false;
        if (email != null ? !email.equals(user.email) : user.email != null) return false;
        if (password != null ? !password.equals(user.password) : user.password != null) return false;

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

    @OneToMany(mappedBy = "userByIdUser")
    public Collection<Answer> getAnswersByIdUser() {
        return answersByIdUser;
    }

    public void setAnswersByIdUser(Collection<Answer> answersByIdUser) {
        this.answersByIdUser = answersByIdUser;
    }

    @OneToMany(mappedBy = "userByIdUser")
    public Collection<Review> getReviewsByIdUser() {
        return reviewsByIdUser;
    }

    public void setReviewsByIdUser(Collection<Review> reviewsByIdUser) {
        this.reviewsByIdUser = reviewsByIdUser;
    }

    @OneToMany(mappedBy = "userByIdUser")
    public Collection<Userlog> getUserlogsByIdUser() {
        return userlogsByIdUser;
    }

    public void setUserlogsByIdUser(Collection<Userlog> userlogsByIdUser) {
        this.userlogsByIdUser = userlogsByIdUser;
    }
}
