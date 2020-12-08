package dataSource;

import java.io.Serializable;

public class ReviewEntityPK implements Serializable {
    private int idUser;
    private int idProduct;

    @jakarta.persistence.Column(name = "id_user")
    @jakarta.persistence.Id
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @jakarta.persistence.Column(name = "id_product")
    @jakarta.persistence.Id
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

        ReviewEntityPK that = (ReviewEntityPK) o;

        if (idUser != that.idUser) return false;
        if (idProduct != that.idProduct) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + idProduct;
        return result;
    }
}
