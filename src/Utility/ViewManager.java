package Utility;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class ViewManager {

    public static Stage stage;

    public enum Window {
        LOGIN,
        SHOP,
        REGISTRATION
    }


    public static void changeScene(Window window){

        String fxmlName;


        switch (window){

            case LOGIN:
                fxmlName = "Login";
                break;
            case SHOP:
                fxmlName = "Shop";
                break;
            case REGISTRATION:
                fxmlName = "Registration";
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + window);
        }

        try {
            Parent parent = FXMLLoader.load(ViewManager.class.getResource("../View/" + fxmlName + ".fxml"));
            stage.setScene(new Scene(parent));
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
