package dataSource;

import java.sql.Timestamp;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "review", schema = "gamified_market" )
@jakarta.persistence.IdClass(ReviewEntityPK.class)
public class ReviewEntity {
    private int idUser;
    private int idProduct;
    private String reviewText;
    private Timestamp date;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_user")
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_product")
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "review_text")
    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "date")
    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ReviewEntity that = (ReviewEntity) o;

        if (idUser != that.idUser) return false;
        if (idProduct != that.idProduct) return false;
        if (reviewText != null ? !reviewText.equals(that.reviewText) : that.reviewText != null) return false;
        if (date != null ? !date.equals(that.date) : that.date != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + idProduct;
        result = 31 * result + (reviewText != null ? reviewText.hashCode() : 0);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        return result;
    }
}
