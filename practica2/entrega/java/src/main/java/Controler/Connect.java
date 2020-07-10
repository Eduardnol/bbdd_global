package Controler;


import java.sql.*;

import static Model.Settings.*;


/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class Connect {

    /**
     * Username of the user that will administrate the database
     */
    static String userName;
    /**
     * Password of the user that will administrate the database
     */
    static String password;
    /**
     * Name of the database to be connected to
     */
    static String db;
    /**
     * Port to connect to the database server
     */
    static int port;
    /**
     * URL where we can find the Server storing the database
     */
    static String url = "jdbc:mysql://localhost";
    private Connection remote;
    private Connection local;
    private Statement s;


    public Connection getRemote() {

        return remote;
    }


    public Connection getLocal() {

        return local;
    }


    public Statement getS() {

        return s;
    }


    public void connectDatabases() {

        try {
            //Realizamos la conexion a las dos bases de datos
            Class.forName("com.mysql.jdbc.Connection");
            this.remote = (com.mysql.jdbc.Connection) DriverManager.getConnection(HOST, USER, PASSWORD);
            this.local = (com.mysql.jdbc.Connection) DriverManager.getConnection(LOCAL_HOST, USER_LOCAL, PASSWORD_LOCAL);

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al conectar");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }


    /**
     * Inserts a query passed as a parameter to the connected database
     *
     * @param query String of the query to be executed to the database
     * @return Boolean true -> Execution Successfull
     * false -> ERROR while executing
     */

    public boolean insertQuery(String query, Connection database) {

        try {
            s = (Statement) database.createStatement();
            s.executeUpdate(query);
            return true;

        } catch (SQLException ex) {
            System.out.println("Problema al Inserir --> " + ex.getSQLState());
            return false;
        }

    }


    public void updateQuery(String query, Connection database) {

        try {
            s = (Statement) database.createStatement();
            s.executeUpdate(query);

        } catch (SQLException ex) {
            System.out.println("Problema al Modificar --> " + ex.getSQLState());
        }
    }


    public void deleteQuery(String query, Connection database) {

        try {
            s = (Statement) database.createStatement();
            s.executeUpdate(query);

        } catch (SQLException ex) {
            System.out.println("Problema al Eliminar --> " + ex.getSQLState());
        }

    }


    /**
     * Function to execute Select queries to the database
     *
     * @param query String containing the query to be executed
     * @return The information returned by the Database
     */
    public ResultSet selectQuery(String query, Connection database) {

        ResultSet rs = null;
        try {
            s = (Statement) database.createStatement();
            rs = s.executeQuery(query);

        } catch (SQLException ex) {
            System.out.println("Problema al Recuperar les dades --> " + ex.getSQLState());
        }
        return rs;
    }


    /**
     * Order to disconnect from the database
     */

    public void disconnect(Connection database) {

        try {
            database.close();
            System.out.println("Desconnectat!");
        } catch (SQLException e) {
            System.out.println("Problema al tancar la connexió --> " + e.getSQLState());
        }
    }


    public void importar(String tabla, String path, Connection database) {
                                                                                                                                //ENCLOSED BY'\\\"'"
        String query = ("LOAD  DATA LOCAL INFILE '" + path + "' INTO TABLE " + tabla + " CHARACTER SET 'utf8'" + " FIELDS TERMINATED BY ',' ESCAPED BY '' " +
                "LINES TERMINATED BY '\\n' IGNORE 1 LINES;");

        try {
            s = (Statement) database.createStatement();
            s.execute(query);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
