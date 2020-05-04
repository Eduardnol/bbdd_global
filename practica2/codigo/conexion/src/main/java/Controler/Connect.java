package Controler;

import Model.Settings;

import java.sql.Connection;
import java.sql.DriverManager;


/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class Connect {


    private Connection connection;
    private Connection local;


    public boolean serverConnect() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
             connection = DriverManager.getConnection("jdbc:mysql://"
                    + Settings.HOST
                    + "?user="
                    + Settings.USER
                    + "&password="
                    + Settings.PASSWORD);
            System.out.println("Success!");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public boolean localConnect(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            local = DriverManager.getConnection("jdbc:mysql://"
                    + Settings.LOCAL_HOST
                    + "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                    + "&user="
                    + Settings.USER_LOCAL
                    + "&password="
                    + Settings.PASSWORD_LOCAL);
            System.out.println("Success!");
            return true;
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }


    public Connection getConnection() {

        return connection;
    }


    public Connection getLocal() {

        return local;
    }
}
