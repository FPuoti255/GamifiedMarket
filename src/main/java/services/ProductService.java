package services;

import entities.Product;
import entities.Review;

import javax.ejb.Stateless;
import javax.persistence.*;
import java.util.List;

@Stateless(name = "ProductService") // should not even provide the name
public class ProductService {
    @PersistenceContext(name = "gamified_market") // "name" should be "unitName"
    EntityManager em; // is it private? 

    public ProductService() {
    }

    public Product getProductOfTheDay() {
        return em.createNamedQuery("Product.getProductOfTheDay", Product.class).getSingleResult();
    }

    public List<Review> getReviews (int productId){
        return (List<Review>) em.find(Product.class, productId).getReviewsByIdProduct();
    }
}

