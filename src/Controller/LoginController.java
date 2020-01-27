package Controller;

import Utility.ViewManager;
import javafx.event.ActionEvent;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;

public class LoginController {
    public PasswordField passwordField;
    public TextField usernameField;

    public void login(ActionEvent actionEvent) {
        ViewManager.changeScene(ViewManager.Window.SHOP);
    }

    public void goToRegistrationPage(MouseEvent mouseEvent) {
        ViewManager.changeScene(ViewManager.Window.REGISTRATION);
    }
}
