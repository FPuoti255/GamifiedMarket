package dataSource;

import java.sql.Date;
import java.util.Arrays;

@jakarta.persistence.Entity
@jakarta.persistence.Table(name = "product", schema = "gamified_market")
public class ProductEntity {
    private int idProduct;
    private String name;
    private byte[] productImage;
    private Date date;

    @jakarta.persistence.Id
    @jakarta.persistence.Column(name = "id_product")
    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "product_image")
    public byte[] getProductImage() {
        return productImage;
    }

    public void setProductImage(byte[] productImage) {
        this.productImage = productImage;
    }

    @jakarta.persistence.Basic
    @jakarta.persistence.Column(name = "date")
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

        ProductEntity that = (ProductEntity) o;

        if (idProduct != that.idProduct) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (!Arrays.equals(productImage, that.productImage)) return false;
        if (date != null ? !date.equals(that.date) : that.date != null) return false;

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
}
