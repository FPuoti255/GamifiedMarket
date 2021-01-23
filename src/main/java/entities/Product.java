package entities;


import javax.persistence.*;
import java.sql.Date;
import java.util.Arrays;
import java.util.Collection;

@Entity
@Table(name = "product")
@NamedQueries({
        @NamedQuery(name = "Product.findAllProducts", query = "select p from Product p"),
        @NamedQuery(name = "Product.getProductOfTheDay", query = "SELECT p from Product p WHERE p.date = current_date")
})
public class Product {

    private int idProduct;
    private String name;
    private byte[] productImage;
    private Date date;
    private Collection<Answer> answersByIdProduct;
    private Collection<Questionnaire> questionnairesByIdProduct;
    private Collection<Review> reviewsByIdProduct;
    private Collection<Userlog> userlogsByIdProduct;


    public Product() {
    }

    public Product(String productName, byte[] productImage, Date productDate){
        this.name = productName;
        this.productImage = productImage;
        this.date = productDate;
    }

    @Id
    @Column(name = "id_product", nullable = false)
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }


    @Column(name = "name", nullable = false, length = 64)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    @Column(name = "product_image", nullable = false)
    public byte[] getProductImage() {
        return productImage;
    }

    public void setProductImage(byte[] productImage) {
        this.productImage = productImage;
    }


    @Column(name = "date", nullable = false)
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Product product = (Product) o;

        if (idProduct != product.idProduct) return false;
        if (name != null ? !name.equals(product.name) : product.name != null) return false;
        if (!Arrays.equals(productImage, product.productImage)) return false;
        if (date != null ? !date.equals(product.date) : product.date != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idProduct;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + Arrays.hashCode(productImage);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "productByIdProduct")
    public Collection<Answer> getAnswersByIdProduct() {
        return answersByIdProduct;
    }

    public void setAnswersByIdProduct(Collection<Answer> answersByIdProduct) {
        this.answersByIdProduct = answersByIdProduct;
    }

    @OneToMany(mappedBy = "productByIdProduct")
    public Collection<Questionnaire> getQuestionnairesByIdProduct() {
        return questionnairesByIdProduct;
    }

    public void setQuestionnairesByIdProduct(Collection<Questionnaire> questionnairesByIdProduct) {
        this.questionnairesByIdProduct = questionnairesByIdProduct;
    }

    @OneToMany(mappedBy = "productByIdProduct")
    public Collection<Review> getReviewsByIdProduct() {
        return reviewsByIdProduct;
    }

    public void setReviewsByIdProduct(Collection<Review> reviewsByIdProduct) {
        this.reviewsByIdProduct = reviewsByIdProduct;
    }

    @OneToMany(mappedBy = "productByIdProduct")
    public Collection<Userlog> getUserlogsByIdProduct() {
        return userlogsByIdProduct;
    }

    public void setUserlogsByIdProduct(Collection<Userlog> userlogsByIdProduct) {
        this.userlogsByIdProduct = userlogsByIdProduct;
    }
}
