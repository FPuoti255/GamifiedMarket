package services;

import Utils.UserAction;
import entities.QuestionnaireLog;
import entities.Userlog;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Stateless
public class Logger {
    @PersistenceContext(unitName = "gamified_market")
    EntityManager em;

    public Logger() {
    }

    public void logAction(int idUser, UserAction action, Integer idProduct) {
        if(idProduct == null){
            em.persist(
                    new Userlog(
                            idUser,
                            Timestamp.valueOf(LocalDateTime.now()),
                            action.getName()
                    )
            );
        }else {
            em.persist(
                    new QuestionnaireLog(
                            idUser,
                            Timestamp.valueOf(LocalDateTime.now()),
                            action.getName(),
                            idProduct
                    )
            );
        }
        em.flush();
    }
}
