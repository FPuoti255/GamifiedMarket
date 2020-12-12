package entities;

import javax.persistence.*;

import java.sql.Timestamp;

@Entity
@Table(name = "review")
@IdClass(ReviewPK.class)
public class Review {
    private int idUser;
    private int idProduct;
    private String reviewText;
    private Timestamp date;
    private User userByIdUser;
    private Product productByIdProduct;

    public Review() {
    }

    @Id
    @Column(name = "id_user", nullable = false)
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    @Id
    @Column(name = "id_product", nullable = false)
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }


    @Column(name = "review_text", nullable = false, length = -1)
    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }


    @Column(name = "date", nullable = false)
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

        Review review = (Review) o;

        if (idUser != review.idUser) return false;
        if (idProduct != review.idProduct) return false;
        if (reviewText != null ? !reviewText.equals(review.reviewText) : review.reviewText != null) return false;
        if (date != null ? !date.equals(review.date) : review.date != null) return false;

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

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "id_user", referencedColumnName = "id_user")
    public User getUserByIdUser() {
        return userByIdUser;
    }

    public void setUserByIdUser(User userByIdUser) {
        this.userByIdUser = userByIdUser;
    }

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "id_product", referencedColumnName = "id_product")
    public Product getProductByIdProduct() {
        return productByIdProduct;
    }

    public void setProductByIdProduct(Product productByIdProduct) {
        this.productByIdProduct = productByIdProduct;
    }
}
