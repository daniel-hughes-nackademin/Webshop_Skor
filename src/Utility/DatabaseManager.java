package Utility;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseManager {

    private Connection connection;

    public Connection connect(){
        String connectionURL = null;
        String username = null;
        String password = null;

        try (InputStream input = new FileInputStream("src/Utility/Settings.properties")) {

            Properties prop = new Properties();
            prop.load(input);
            connectionURL = "jdbc:mysql://" + prop.getProperty("host") + ":" +
                    prop.getProperty("port") + "/" +
                    prop.getProperty("db");

            username = prop.getProperty("username");
            password = prop.getProperty("password");

        } catch (IOException ex) {
            ex.printStackTrace();
        }


        try {
            if (connectionURL != null) {
                connection = DriverManager.getConnection(connectionURL, username, password);
                System.out.println("Connected at: " + connectionURL);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return connection;
    }

    public void disconnect() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Connection getConnection() {
        return connection;
    }
}
