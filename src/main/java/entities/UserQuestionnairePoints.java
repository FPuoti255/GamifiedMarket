package entities;


import org.eclipse.persistence.annotations.ReadOnly;

import javax.persistence.*;

@ReadOnly
@Entity
@Table(name = "userquestionnairepoints")
@IdClass(UserQuestionnairePointsPK.class)
@NamedQuery(name = "UserQuestionnairePoints", query = "SELECT r FROM UserQuestionnairePoints r WHERE r.idProduct = ?1 ORDER BY r.userPoints DESC")
public class UserQuestionnairePoints {
    @Id
    @Column(name = "id_product", nullable = false)
    private int idProduct;
    @Id
    @Column(name = "id_user", nullable = false)
    private int idUser;
    @Column(name = "points")
    private int userPoints;

    public UserQuestionnairePoints() {
    }

    public int getIdProduct() {
        return idProduct;
    }

    public int getIdUser() {
        return idUser;
    }

    public int getUserPoints(){
        return userPoints;
    }

}
