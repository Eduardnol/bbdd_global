package Controler;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class RetrieveInfo {
    private Connection conn1 = null;
    private String url = "jdbc:mysql://localhost:3306";
    private String user = "lsmotor_user";
    private String password = "lsmotor_bbdd";
    private Connection conexion = null;


    public void retrieveInfo(){

        try{
            conexion = DriverManager.getConnection(url, user, password);

        }
        catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ERROR MySql");
        }


    }
}
