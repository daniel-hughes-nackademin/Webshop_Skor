package Program;

import Model.Customer;
import Model.Order;
import Utility.ViewManager;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Program extends Application {

    public static int customerID = 0;
    public static Customer customer = null;
    public static int currentOrderID = 0;
    public static Order currentOrder = null;
    public static int nrOfItemsInCart = 0;



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
        currentOrder = null;
        currentOrderID = 0;
        nrOfItemsInCart = 0;
        ViewManager.changeScene(ViewManager.View.LOGIN);
    }


}
