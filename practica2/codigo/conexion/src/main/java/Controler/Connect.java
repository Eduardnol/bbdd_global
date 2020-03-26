package Controler;

import Model.Settings;

import java.sql.Connection;
import java.sql.DriverManager;

import static com.jcraft.jsch.JSch.setConfig;


/**
 * @author Eduardo Nolla
 * @version 1.0
 * @since 26/03/2020
 */

public class Connect {



    private Connection remoteConnection;

    public boolean startRemoteConnection(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            remoteConnection = DriverManager.getConnection("jdbc:mysql://"+ Settings.HOST+"/?user=" + Settings.REMOTEUSER + "&password=" + Settings.REMOTEPASSWORD + "&serverTimezone=UTC");
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

}
