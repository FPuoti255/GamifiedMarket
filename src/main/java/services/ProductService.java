package services;

import entities.Product;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;


@Stateless(name = "ProductService") // should not even provide the name
public class ProductService {
    @PersistenceContext(name = "gamified_market") // "name" should be "unitName"
    EntityManager em; // is it private? 

    public ProductService() {
    }

    public Product getAllProducts() {
        Product product1 =  em.find(Product.class, 1);
        return product1;
    }
}

