package entities;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

public class UserQuestionnairePointsPK implements Serializable {

    private int idProduct;
    private int idUser;

    public UserQuestionnairePointsPK(int idProduct, int idUser) {
        this.idProduct = idProduct;
        this.idUser = idUser;
    }

    @Id
    @Column(name = "id_product", nullable = false)
    public int getIdProduct() {
        return idProduct;
    }

    @Id
    @Column(name = "id_user", nullable = false)
    public int getIdUser() {
        return idUser;
    }
}
