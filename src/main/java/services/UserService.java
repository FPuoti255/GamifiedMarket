package services;

import entities.User;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class UserService {
    @PersistenceContext(unitName = "gamified_market")
    EntityManager em;

    public UserService() {
    }

    public User checkCredentials(String email, String password) {
        List<User> userList;
        try {
            userList = em.createNamedQuery("User.checkCredentials", User.class)
                    .setParameter(1, email)
                    .setParameter(2, password)
                    .getResultList();
        }catch(Throwable te){
            System.out.println(te.getMessage());
            return  null;
        }

        return (userList.size() != 1) ? null : userList.get(0);
    }

    public User registerNewUser(String usrname, String email, String psw){
        User newUsr = new User();
        newUsr.setAdmin(false);
        newUsr.setActive(true);
        newUsr.setAuthorized(true);
        newUsr.setEmail(email);
        newUsr.setPassword(psw);
        newUsr.setUsername(usrname);
        try{
            em.persist(newUsr);
            em.flush();
        }catch (Exception e){
            return null;
        }
        return newUsr;
    }

}
