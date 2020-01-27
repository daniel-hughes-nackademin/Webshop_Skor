package Program;

import Model.Customer;
import Model.Order;
import Utility.ViewManager;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.stage.Stage;

public class Program extends Application {

    public static int customerID;
    public static Customer customer;
    public static int currentOrderID;
    public static int nrOfItemsInCart;



    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("../View/Login.fxml"));
        primaryStage.setTitle("Fancy Shoes For Fancy Dudes");
        primaryStage.setScene(new Scene(root));
        ViewManager.stage = primaryStage;
        primaryStage.show();
    }


    public static void main(String[] args) {
        launch(args);
    }


    public static void logOut() {
        customer = null;
        customerID = 0;
        currentOrderID = 0;
        nrOfItemsInCart = 0;
        ViewManager.changeScene(ViewManager.View.LOGIN);
    }


    public static void viewMessage(String message, String title, Alert.AlertType alertType) {
        Alert alert = new Alert(alertType);
        alert.setContentText(message);
        alert.setTitle(title);
        alert.show();
    }

}
