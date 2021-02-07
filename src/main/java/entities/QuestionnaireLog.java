package entities;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "questionnaire_log")
@IdClass(QuestionnaireLogPK.class)
public class QuestionnaireLog {

    private int idUser;
    private Timestamp datetime;
    private String action;
    private Integer idProduct;
    private User userByIdUser;
    private Product productByIdProduct;

    public QuestionnaireLog() {
    }

    public QuestionnaireLog(int idUser, Timestamp datetime, String action, Integer idProduct) {
        this.idUser = idUser;
        this.datetime = datetime;
        this.action = action;
        this.idProduct = idProduct;
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
    @Column(name = "datetime", nullable = false)
    public Timestamp getDatetime() {
        return datetime;
    }

    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }


    @Column(name = "action", nullable = false, length = 64)
    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    @Column(name = "id_product")
    public Integer getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(Integer idProduct) {
        this.idProduct = idProduct;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        entities.QuestionnaireLog questionnaireLog = (entities.QuestionnaireLog) o;

        if (idUser != questionnaireLog.idUser) return false;
        if (datetime != null ? !datetime.equals(questionnaireLog.datetime) : questionnaireLog.datetime != null)
            return false;
        if (action != null ? !action.equals(questionnaireLog.action) : questionnaireLog.action != null) return false;
        if (idProduct != null ? !idProduct.equals(questionnaireLog.idProduct) : questionnaireLog.idProduct != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idUser;
        result = 31 * result + (datetime != null ? datetime.hashCode() : 0);
        result = 31 * result + (action != null ? action.hashCode() : 0);
        result = 31 * result + (idProduct != null ? idProduct.hashCode() : 0);
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


