package Controller;

import Utility.Repository;
import Utility.ViewManager;
import javafx.event.ActionEvent;
import javafx.scene.control.Alert;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;

import javax.swing.*;

public class LoginController {
    public TextField emailField;
    public PasswordField passwordField;

    public void login(ActionEvent actionEvent) {
        final String email = emailField.getText();
        final String password = passwordField.getText();

        if(email.isEmpty() || password.isEmpty()){
            showErrorMessage("You must enter both email and password!", "Login Required");
        }

        //TODO Verify email
        //TODO Verify password

        else{
            boolean isSuccessful = Repository.attemptLogin(email, password);

            if(isSuccessful)
                ViewManager.changeScene(ViewManager.View.SHOP);
        }



    }

    public void showErrorMessage(String errorMessage){
        Alert alert = new Alert(Alert.AlertType.WARNING);
        alert.setContentText("You need to enter both email and password!");
        alert.setTitle("Error");
        alert.show();
    }

    public void showErrorMessage(String errorMessage, String title){
        Alert alert = new Alert(Alert.AlertType.WARNING);
        alert.setContentText("You need to enter both email and password!");
        alert.setTitle(title);
        alert.show();
    }

    public void goToRegistrationPage(MouseEvent mouseEvent) {
        ViewManager.changeScene(ViewManager.View.REGISTRATION);
    }
}
