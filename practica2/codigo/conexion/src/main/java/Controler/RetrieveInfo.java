package Controler;

import com.opencsv.CSVWriter;
import com.opencsv.ResultSetHelperService;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class RetrieveInfo {
    private Connect connect;
    private String path;


    public RetrieveInfo() {

        this.connect = new Connect();

    }


    public void retrieveInfo() throws SQLException {

        String[] local = {"circuits", "constructorResults", "constructorStandings", "constructors",
                "driverStandings", "drivers", "lapTimes", "pitStops", "qualifying", "races", "results", "seasons", "status"};

        connect.connectDatabases();


        try {
            for (int i = 0; i < local.length; i++) {
                String query = "SELECT * FROM " + local[i];
                ResultSet resultSet = connect.selectQuery(query, connect.getRemote());
                CSVWriter file = new CSVWriter(new FileWriter("src/main/resources/info.csv"));
                //Hacemos un result set helper service para indicarle el formato en el que esta la fecha
                ResultSetHelperService resultSetHelperService = new ResultSetHelperService();
                resultSetHelperService.setDateFormat("yyyy-MM-dd");

                //Incorporamos el servicio de result set a nuestro CSVWriter
                file.setResultService(resultSetHelperService);
                //importamos el resultSet
                file.writeAll(resultSet, false, false, true);
                //Escribimos el csv resultante
                path = new File("src/main/resources/info.csv").getAbsolutePath();
                insertInfo(local[i]);
            }


        } catch (IOException e) {
            e.printStackTrace();
        }


    }


    /**
     * Inserts all the information from the classes to the database
     */
    public void insertInfo(String table) {

        path = path.replaceAll("\\\\", "/");
        connect.importar(table, path, connect.getLocal());


    }

}

