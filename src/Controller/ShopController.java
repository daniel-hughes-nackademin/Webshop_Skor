package Controller;

import Program.Program;
import javafx.event.ActionEvent;
import javafx.scene.control.Label;

public class ShopController {
    public Label customerNameLabel;

    public void initialize(){
        customerNameLabel.setText(Program.customer.getFirstName() + " " + Program.customer.getLastName());
    }


    public void goToProfileSettings(ActionEvent actionEvent) {
    }
}
