package Controller;

import Model.Shoe;
import Program.Program;
import Utility.Repository;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

import java.util.HashMap;

public class ShopController {
    @FXML
    private Label customerNameLabel;

    @FXML
    private TableView shoeDisplay;
    @FXML
    private TableColumn colBrand;
    @FXML
    private TableColumn colModel;
    @FXML
    private TableColumn colColor;
    @FXML
    private TableColumn colEU;
    @FXML
    private TableColumn colUK;
    @FXML
    private TableColumn colUSM;
    @FXML
    private TableColumn colUSF;
    @FXML
    private TableColumn colJP;
    @FXML
    private TableColumn colPrice;
    @FXML
    private TableColumn colAction;
    @FXML
    private TableColumn colStock;




    public void initialize(){
        customerNameLabel.setText(Program.customer.getFirstName() + " " + Program.customer.getLastName());

        HashMap<Integer, Shoe> shoes = Repository.getShoesFromDB();

        shoes.forEach((id, shoe) -> System.out.println("Sko id " + id + ": " + shoe + "\n"));

    }


    public void goToProfileSettings(ActionEvent actionEvent) {
    }
}
