package Program;

import Utility.DatabaseManager;
import Utility.ViewManager;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Program extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{
        DatabaseManager databaseManager = new DatabaseManager();
        databaseManager.connect();
        databaseManager.disconnect();
        Parent root = FXMLLoader.load(getClass().getResource("../View/Login.fxml"));
        primaryStage.setTitle("Fancy Shoes For Fancy Dudes");
        primaryStage.setScene(new Scene(root));
        ViewManager.stage = primaryStage;
        primaryStage.show();
    }


    public static void main(String[] args) {
        launch(args);
    }
}
