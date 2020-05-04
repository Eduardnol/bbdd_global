package Controler;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;

import static Model.Settings.*;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class RetrieveInfo {
    private Connection conn = null;
    private Connection connLocal = null;
//    private String url = "jdbc:mysql://localhost:3306";
//    private String user = "lsmotor_user";
//    private String password = "lsmotor_bbdd";
//    private Connection conexion = null;

    private Statement statement = null;
    private PreparedStatement resultset = null;

    private Statement statementLocal = null;
    private ResultSet resultsetLocal = null;


    public RetrieveInfo() {

        try {
            Class.forName("com.mysql.jdbc.Connection");
            this.conn = (Connection) DriverManager.getConnection(HOST, USER, PASSWORD);
            this.connLocal = (Connection) DriverManager.getConnection(LOCAL_HOST, USER_LOCAL, PASSWORD_LOCAL);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al conectar");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }


    public void retrieveInfo(){


        String[] local = {"circuits", "constructorResults", "constructorStandings", "constructors",
                "driverStandings", "drivers", "lapTimes", "pitStops", "qualifying", "races", "results", "Seasons", "Status"};




        try {
            statement = (Statement) conn.createStatement();
            statementLocal = (Statement) connLocal.createStatement();

            statementLocal.execute("DROP DATABASE IF EXISTS F1");
            statementLocal.execute("CREATE DATABASE F1");
            statementLocal.execute("USE F1");

            for (String s : local) {

                resultset = conn.prepareStatement("SELECT * FROM " + s);
                statementLocal.execute("CREATE TABLE " + s );

            }


        } catch (SQLException e) {
            e.printStackTrace();
        }


            //CREATE DATABASE new database SELECT * FROM circuits;



    }
}
