package services;

import entities.Product;
import entities.Review;

import javax.ejb.Stateless;
import javax.persistence.*;
import java.util.List;

@Stateless(name = "ProductService")

public class ProductService {
    @PersistenceContext(name = "gamified_market")
    EntityManager em;

    public ProductService() {
    }

    public Product getProductOfTheDay() {
        return em.createNamedQuery("Product.getProductOfTheDay", Product.class).getSingleResult();
    }

    public List<Review> getReviews (int productId){
        return (List<Review>) em.find(Product.class, productId).getReviewsByIdProduct();
    }

    public List<Product> getAllProducts(){
        return em.createNamedQuery("Product.findAllProducts", Product.class).getResultList();
    }
}

