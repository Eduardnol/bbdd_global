import Controler.Connect;
import Controler.RetrieveInfo;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class Main {


    public static void main(String[] args) {


        //if(go.serverConnect() && go.localConnect()){
            RetrieveInfo retrieve = new RetrieveInfo();
            retrieve.retrieveInfo();
            System.out.println("Success");
    //    }




    }

}
