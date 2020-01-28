package Controller;

import Program.Program;
import Utility.Repository;
import Utility.ViewManager;
import javafx.event.ActionEvent;
import javafx.scene.control.Alert;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;

public class LoginController {
    public TextField emailField;
    public PasswordField passwordField;

    public void login(ActionEvent actionEvent) {
        final String email = emailField.getText();
        final String password = passwordField.getText();

        if(email.isEmpty() || password.isEmpty()){
            Program.viewMessage("You must enter both email and password!", "Login Required", Alert.AlertType.WARNING);
        }

        //TODO Verify email
        //TODO Verify password

        else{
            boolean isSuccessful = Repository.attemptLogin(email, password);

            if(isSuccessful)
                ViewManager.changeScene(ViewManager.View.SHOP);
        }



    }

    public void goToRegistrationPage(MouseEvent mouseEvent) {
        ViewManager.changeScene(ViewManager.View.REGISTRATION);
    }
}
