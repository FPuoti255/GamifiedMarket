package services;

import Utils.UserAction;
import entities.User;
import entities.Userlog;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Stateless
public class UserService {
    @PersistenceContext(unitName = "gamified_market")
    EntityManager em;

    @EJB(beanName = "Logger")
    Logger logger;

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

        if(userList.size() == 1){
            logger.logAction(
                    userList.get(0).getIdUser(),
                    UserAction.LOGIN,
                    null
            );
            return userList.get(0);
        }
        return null;
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


    public void banUser(int idUSer) {
        em.find(User.class, idUSer).setAuthorized(false);
        em.flush();
    }
}
