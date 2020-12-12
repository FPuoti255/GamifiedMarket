package entities;

import javax.persistence.Column;
import javax.persistence.Id;

import java.io.Serializable;

public class ReviewPK implements Serializable {
    private int idUser;
    private int idProduct;

    public ReviewPK() {
    }

    @Column(name = "id_user", nullable = false)
    @Id
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @Column(name = "id_product", nullable = false)
    @Id
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ReviewPK reviewPK = (ReviewPK) o;

        if (idUser != reviewPK.idUser) return false;
        if (idProduct != reviewPK.idProduct) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + idProduct;
        return result;
    }
}
