package services;

import Utils.DateAlreadySelected;
import entities.Product;
import entities.Review;

import javax.ejb.Stateless;
import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
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

    /**
     * I need this function to get detailed information from a call that provides only the
     * product's ID
     */
    public Product getProductById(int productId){
        return em.createNamedQuery("Product.getProductByIdProduct", Product.class).setParameter("idProduct", productId).getSingleResult();
    }

    public List<Review> getReviews (int productId){
        return (List<Review>) em.find(Product.class, productId).getReviewsByIdProduct();
    }

    public List<Product> getAllProducts(){
        return em.createNamedQuery("Product.findAllProducts", Product.class).getResultList();
    }

    /**
     * method to add a review to the specified product. parameters are self explicative
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

    /**
     * adds a product to the database
     *
     * @param productName the product name
     * @param productImage the image
     * @param productDate the date in which this product is product of the day
     * @return
     */
    public Product addProduct(String productName, byte[] productImage, Date productDate) throws DateAlreadySelected {
        Product newProduct = new Product(productName, productImage, productDate);
        try {
            em.createNamedQuery("Product.getProductByDate").setParameter(1, productDate).getSingleResult();
        }catch(NoResultException e){
            try{
                em.persist(newProduct);
                em.flush();
            }catch (Exception x){
                return null;
            }
            //refresh();
            return newProduct;
        }
        throw new DateAlreadySelected();

    }

    public List<Product> getPastProducts() {
        return em.createNamedQuery("Product.getPastProduct", Product.class).getResultList();
    }

    /**
     * method to remove a product from the DB. the actual schema has a predefined procedure to do so,
     * so we use it.
     * @param toRemoveProductId the product's id
     */
    public void removeProduct(int toRemoveProductId) {
        em.createNativeQuery("{call delete_questionnaires_details(?)}")
                .setParameter(1, toRemoveProductId)
                .executeUpdate();

        em.remove(getProductById(toRemoveProductId));
        em.flush();
    }
}

