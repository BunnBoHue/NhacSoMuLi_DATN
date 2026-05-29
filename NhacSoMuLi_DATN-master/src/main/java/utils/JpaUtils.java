package utils;

import javax.persistence.*;

public class JpaUtils {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("MusicPU");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}
