package Controller;

import Model.Shoe;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;

public class CheckoutController {
    @FXML
    private Label customerNameLabel;

    @FXML
    private TableView<Shoe> shoeDisplay;
    @FXML
    private TableColumn<Shoe, String> colBrand;
    @FXML
    private TableColumn<Shoe, String> colModel;
    @FXML
    private TableColumn<Shoe, String> colColor;
    @FXML
    private TableColumn<Shoe, Integer> colEU;
    @FXML
    private TableColumn<Shoe, Double> colUK;
    @FXML
    private TableColumn<Shoe, Double> colUSM;
    @FXML
    private TableColumn<Shoe, Double> colUSF;
    @FXML
    private TableColumn<Shoe, Double> colJP;
    @FXML
    private TableColumn<Shoe, Integer> colPrice;
    @FXML
    private TableColumn colAmount;
    @FXML
    private TableColumn<Shoe, Integer> colTotal;
    @FXML
    private Label nrOfItemsInCartLabel;



    public void initialize(){

    }
}
