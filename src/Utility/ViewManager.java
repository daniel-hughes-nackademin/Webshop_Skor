package Utility;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class ViewManager {

    public static Stage stage;

    public enum View {
        LOGIN,
        SHOP,
        REGISTRATION,
        PROFILE
    }


    public static void changeScene(View view){

        String fxmlName;


        switch (view){

            case LOGIN:
                fxmlName = "Login";
                break;
            case SHOP:
                fxmlName = "Shop";
                break;
            case REGISTRATION:
                fxmlName = "Registration";
                break;
            case PROFILE:
                fxmlName = "Profile";
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + view);
        }

        try {
            Parent parent = FXMLLoader.load(ViewManager.class.getResource("../View/" + fxmlName + ".fxml"));
            stage.setScene(new Scene(parent));
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
