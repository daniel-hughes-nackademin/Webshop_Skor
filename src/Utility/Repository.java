package Utility;

import Controller.ShopController;
import Model.*;
import Program.Program;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import javafx.scene.control.Alert;

import javax.swing.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.*;

public class Repository {

    private static Connection connection;

    private static void connect() {
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

            System.out.println(connectionURL);

        } catch (IOException ex) {
            ex.printStackTrace();
        }


        try {
            if (connectionURL != null) {
                connection = DriverManager.getConnection(connectionURL, username, password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    private static void disconnect() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static boolean columnExists(ResultSet resultSet, String columnName) throws SQLException {
        ResultSetMetaData meta = resultSet.getMetaData();
        int nrOfColumns = meta.getColumnCount();

        for (int i = 1; i <= nrOfColumns; i++) {
            System.out.println("Column: " + meta.getColumnName(i));
            if (meta.getColumnName(i).equals(columnName))
                return true; //Column name found in result set
        }

        //Column name was not found in result set
        return false;
    }


    public static boolean attemptLogin(String email, String password) {

        boolean isSuccessfulLogin = false;

        connect();

        try {
            PreparedStatement prepStmt = connection.prepareCall("CALL attempt_login(?,?)");
            prepStmt.setString(1, email);
            prepStmt.setString(2, password);

            ResultSet resultSet = prepStmt.executeQuery();
            resultSet.next();

            if (columnExists(resultSet, "ERROR"))
                JOptionPane.showMessageDialog(null, resultSet.getString("ERROR"), "Login failed", JOptionPane.WARNING_MESSAGE);
            else {
                Program.customerID = resultSet.getInt("id");
                String firstName = resultSet.getString("first");
                String lastName = resultSet.getString("last");
                City city = new City(resultSet.getString("city"));

                Program.customer = new Customer(firstName, lastName, email, city);
                isSuccessfulLogin = true;
            }


        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error occurred when connecting to database", "Login failed", JOptionPane.WARNING_MESSAGE);
            e.printStackTrace();
        } finally {
            disconnect();
        }


        return isSuccessfulLogin;
    }


    public static HashMap<Integer, Shoe> getShoesFromDB() {
        HashMap<Integer, Shoe> shoes = new HashMap<>();

        connect();

        try {
            Statement statement = connection.createStatement();
            statement.execute("SELECT * FROM shoe_view");

            ResultSet resultSet = statement.getResultSet();


            while (resultSet.next()) {
                int shoeId = resultSet.getInt("shoe_id");
                Model model = new Model(resultSet.getString("model"));
                Brand brand = new Brand(resultSet.getString("brand"));

                Size size = new Size(
                        resultSet.getInt("eu"),
                        resultSet.getDouble("uk"),
                        resultSet.getDouble("usa_male"),
                        resultSet.getDouble("usa_female"),
                        resultSet.getDouble("japan")
                );

                String color = resultSet.getString("color");
                int price = resultSet.getInt("price");
                int stockQuantity = resultSet.getInt("stock_quantity");

                List<Category> categories = getCategoriesFromDB(shoeId);

                Shoe shoe = new Shoe(
                        model,
                        size,
                        brand,
                        price,
                        color,
                        stockQuantity,
                        categories
                );

                shoes.put(shoeId, shoe);
            }




            shoes.forEach((id, shoe) -> {
                System.out.println("Shoe: " + id);
                for (int i = 0; i < shoe.getCategories().size(); i++) {
                    System.out.println(shoe.getCategories().get(i));
                }
            });

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }


        return shoes;
    }



    private static List<Category> getCategoriesFromDB(int shoeID) throws SQLException {
        List<Category> categories = new ArrayList<>();

        PreparedStatement prepStmt = connection.prepareStatement("SELECT * FROM shoe_categories_view WHERE shoe_id = ?");
        prepStmt.setInt(1, shoeID);
        ResultSet resultSet = prepStmt.executeQuery();

        while(resultSet.next()){
            categories.add(new Category(resultSet.getString("category")));
        }

        return categories;
    }



    public static boolean addToCart(int shoeId) {
        connect();

        boolean isAddedToCart = false;

        try {
            PreparedStatement prepStmt = connection.prepareCall("CALL add_to_cart(?,?,?)");
            prepStmt.setInt(1, Program.customerID);
            prepStmt.setInt(2, Program.currentOrderID);
            prepStmt.setInt(3, shoeId);

            ResultSet resultSet = prepStmt.executeQuery();

            resultSet.next();

            if (columnExists(resultSet, "ERROR")) {
                ShopController.viewMessage(resultSet.getString("ERROR"), "ERROR", Alert.AlertType.WARNING);
            } else if (columnExists(resultSet, "current_order_id")){
                Program.currentOrderID = resultSet.getInt(1);
            }
            else {
                System.out.println("Updated order");
            }

            isAddedToCart = true;
        } catch (MySQLIntegrityConstraintViolationException e){
          ShopController.viewMessage("Shoe is out of stock!", "Too bad :(", Alert.AlertType.WARNING);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }


        return isAddedToCart;
    }
}
