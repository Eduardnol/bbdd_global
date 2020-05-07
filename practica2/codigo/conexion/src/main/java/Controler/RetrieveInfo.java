package Controler;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static Model.Settings.*;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class RetrieveInfo {
    private Connect connect;
//    private Connection conn = null;
//    private Connection connLocal = null;
//    private String url = "jdbc:mysql://localhost:3306";
//    private String user = "lsmotor_user";
//    private String password = "lsmotor_bbdd";
//    private Connection conexion = null;

//    private Statement statement = null;
//    private Statement resultset = null;
//
//    private Statement statementLocal = null;
//    private ResultSet resultsetLocal = null;

    String query = null;


    public RetrieveInfo() {

       this.connect = new Connect();

    }


    public void retrieveInfo() {


        String[] local = {"circuits", "constructorResults", "constructorStandings", "constructors",
                "driverStandings", "drivers", "lapTimes", "pitStops", "qualifying", "races", "results", "Seasons", "Status"};

        connect.connectDatabases();


   //     try {
//            statement = (Statement) conn.createStatement();
//            statementLocal = (Statement) connLocal.createStatement();
//
//            statementLocal.execute("DROP DATABASE IF EXISTS F1");
//            statementLocal.execute("CREATE DATABASE F1");
//            statementLocal.execute("USE F1");

            for (String s : local) {

            query = "CREATE TABLE " + "localhost.F1" + "." + s + " LIKE " + "f1" + "." + s;
            query = "SELECT * from " + s;

            ResultSet resultSet = connect.selectQuery(query, connect.getRemote());


                System.out.println("Pericion Enviada");
            }


       // } catch (SQLException e) {
     //       e.printStackTrace();
        }


        //CREATE DATABASE new database SELECT * FROM circuits;


    }

