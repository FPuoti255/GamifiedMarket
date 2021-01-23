package services;

import entities.Product;
import entities.Review;

import javax.ejb.Stateless;
import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Stateless(name = "ProductService")

public class ProductService {
    @PersistenceContext(name = "gamified_market")
    EntityManager em;

    public ProductService() {
    }

    public Product getProductOfTheDay() {
        Product productOfTheDay;
        try{
            productOfTheDay = em.createNamedQuery("Product.getProductOfTheDay", Product.class).getSingleResult();
        }catch(Exception e){
            productOfTheDay = null;
        }

        return productOfTheDay;
    }

    public List<Review> getReviews (int productId){
        return (List<Review>) em.find(Product.class, productId).getReviewsByIdProduct();
    }

    public List<Product> getAllProducts(){
        return em.createNamedQuery("Product.findAllProducts", Product.class).getResultList();
    }

    /**
     * method to add a review to the specified product. parameters are self explicative
     * @param IdProduct
     * @param IdUser
     * @param reviewTxt
     * @param date
     * @return
     * @author Elia Ravella
     */
    public Review addReview(int IdProduct, int IdUser, String reviewTxt, Timestamp date){
        Review newRev = new Review(IdUser, IdProduct, reviewTxt, date);

        try{
            em.persist(newRev);
            em.flush();
        }catch (Exception x){
            return null;
        }

        return newRev;
    }
}

