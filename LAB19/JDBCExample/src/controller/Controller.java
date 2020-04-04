package controller;

import db.ConectorDB;
import view.MainView;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Controller implements ActionListener {
    private boolean connected;
    private MainView mainView;
    private ConectorDB conn;


    public Controller(MainView mainView) {

        this.mainView = mainView;
        this.connected = false;
    }


    @Override
    public void actionPerformed(ActionEvent e) {


        JButton botoClickat = (JButton) e.getSource();
        if (botoClickat.getText().equals("Connect") && !connected) {
            conn = new ConectorDB("root", mainView.getPassword(), "Movies", 3306);
            connected = conn.connect();
        }
        if (botoClickat.getText().equals("Disconnect") && connected) {
            conn.disconnect();
            connected = false;
        }

        if (botoClickat.getText().equals("Search") && connected) {
            try {
                //Extreiem la paraula per la que l'usuari està cercant:
                String paraulaClau = mainView.getCerca();

                //Iniciem el resultat a cadena de caràcters buida
                String result = "";

                //TODO: Mitjançant ResultSet i selectQuery ompliu la variable result amb el resultat de la query
                ResultSet resultSet = (conn.selectQuery("SELECT * FROM movie m WHERE m.title = '" + paraulaClau + "';"));

                resultSet.next();

                result = resultSet.getString("title");

                resultSet.close();
                //Mostrem el resultat de la query a la interfície gràfica:
                mainView.setResult(result);

            } catch (SQLException e1) {
                System.out.println(e1.getErrorCode());
                System.out.println("Error a MySQL");
                mainView.setResult("404 NOT FOUND");
            }
        }

        if (botoClickat.getText().equals("Done") && connected) {
            String title = mainView.getMovieTitle();
            String idDirector = mainView.getIdDirector();
            String year = mainView.getYear();
            String duration = mainView.getDuration();
            String country = mainView.getCountry();
            String facebookLikes = mainView.getFacebookLikes();
            String imdbScore = mainView.getImdbScore();
            String gross = mainView.getGross();
            String budget = mainView.getBudget();

            //TODO: Inserir o modificar el nou element
            try {

                //Iniciem el resultat a cadena de caràcters buida
                String result = "";


                ResultSet resultSet = (conn.selectQuery("SELECT * FROM movie m WHERE m.title = '" + title + "';"));

                resultSet.next();

                resultSet.getString("title");

                resultSet.close();

                conn.updateQuery("UPDATE movie SET title = '"+ title + "', id_director ='" + idDirector + "',year ='" + year + "',duration ='" + duration + "',country = '" + country + "',movie_facebook_likes ='" + facebookLikes
                        + "', imdb_score ='" + imdbScore + "', gross = '" + gross + "', budget ='" + budget + "' WHERE title = '"+ title + "';");

            } catch (SQLException e1) {
                conn.insertQuery("INSERT INTO movie (title, id_director, year, duration, country, movie_facebook_likes, imdb_score, gross, budget) VALUES ('"
                        + title + "','" + idDirector + "','" + year + "','" + duration + "','" + country + "','" + facebookLikes + "','" + imdbScore + "','" + gross + "','" + budget + "');");
            }


        }

        if (connected) {
            mainView.setConnected();
        } else {
            mainView.setDisconnected();
        }
    }
}
