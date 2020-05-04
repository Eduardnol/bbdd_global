package Controler;





import com.mysql.cj.protocol.Resultset;

import java.sql.*;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class RetrieveInfo {
    private Connect conn = null;
//    private String url = "jdbc:mysql://localhost:3306";
//    private String user = "lsmotor_user";
//    private String password = "lsmotor_bbdd";
//    private Connection conexion = null;

    private Statement statement = null;
    private PreparedStatement resultset = null;

    private Statement statementLocal = null;
    private ResultSet resultsetLocal = null;


    public RetrieveInfo(Connect conn) {

        this.conn = conn;
    }


    public void retrieveInfo(){


        String[] local = {"circuits", "constructorResults", "constructorStandings", "constructors",
                "driverStandings", "drivers", "lapTimes", "pitStops", "qualifying", "races", "results", "Seasons", "Status"};




        try {
            statement = conn.getConnection().createStatement();
            statementLocal = conn.getLocal().createStatement();

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
