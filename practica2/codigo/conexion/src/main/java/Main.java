import Controler.Connect;
import Controler.RetrieveInfo;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class Main {


    public static void main(String[] args) {
        Connect go = new Connect();

        go.startRemoteConnection();


        RetrieveInfo retrieve = new RetrieveInfo();

        retrieve.retrieveInfo();

    }

}
