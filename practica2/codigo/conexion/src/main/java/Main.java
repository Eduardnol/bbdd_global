import Controler.RetrieveInfo;

import java.sql.SQLException;
import java.util.concurrent.TimeUnit;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class Main {


    public static void main(String[] args) throws SQLException {

        RetrieveInfo retrieve = new RetrieveInfo();

        long startTime = System.nanoTime();

        retrieve.retrieveInfo();

        long endTime = System.nanoTime();

        long durationInNano = (endTime - startTime);  //Total execution time in nano seconds

        //Same duration in millis

        long durationInMillis = TimeUnit.NANOSECONDS.toMillis(durationInNano);  //Total execution time in nano seconds
        long durationInSeconds = TimeUnit.NANOSECONDS.toSeconds(durationInNano);

        //System.out.println(durationInNano);
        System.out.println("Import database completed in: " + durationInMillis + "ms");
        System.out.println("Import database completed in: "+ durationInSeconds + "s");


    }

}
