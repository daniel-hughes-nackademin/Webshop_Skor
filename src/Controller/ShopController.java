package Controller;

import Model.Shoe;
import Program.Program;
import Utility.Repository;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.util.Callback;

import java.util.HashMap;

public class ShopController {
    @FXML
    private Label customerNameLabel;

    @FXML
    private TableView <Shoe> shoeDisplay;
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
    private TableColumn colAction;
    @FXML
    private TableColumn<Shoe, Integer> colStock;

    private HashMap<Integer, Shoe> shoes;




    public void initialize(){
        customerNameLabel.setText(Program.customer.getFirstName() + " " + Program.customer.getLastName());

        shoes = Repository.getShoesFromDB();
        shoes.forEach((id, shoe) -> System.out.println("Sko id " + id + ": " + shoe + "\n"));

        populateTableView();

    }

    private void populateTableView() {

        ObservableList<Shoe> shoeTableContentList = FXCollections.observableArrayList();
        shoes.forEach((id, shoe) -> shoeTableContentList.add(shoe));

        colBrand.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getBrand().getBrand()));
        colModel.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getModel().getModel()));
        colColor.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getColor()));
        colEU.setCellValueFactory(shoe -> new SimpleIntegerProperty(shoe.getValue().getSize().getEu()).asObject());
        colUK.setCellValueFactory(shoe -> new SimpleDoubleProperty(shoe.getValue().getSize().getUk()).asObject());
        colUSM.setCellValueFactory(shoe -> new SimpleDoubleProperty(shoe.getValue().getSize().getUsMale()).asObject());
        colUSF.setCellValueFactory(shoe -> new SimpleDoubleProperty(shoe.getValue().getSize().getUsFemale()).asObject());
        colJP.setCellValueFactory(shoe -> new SimpleDoubleProperty(shoe.getValue().getSize().getJapan()).asObject());
        colPrice.setCellValueFactory(shoe -> new SimpleIntegerProperty(shoe.getValue().getPrice()).asObject());
        colStock.setCellValueFactory(shoe -> new SimpleIntegerProperty(shoe.getValue().getStockQuantity()).asObject());

        //Making a cell factory to insert add to cart button
        Callback<TableColumn<Shoe, String>, TableCell<Shoe, String>> cellFactory
                = //
                new Callback<>() {
                    @Override
                    public TableCell call(final TableColumn<Shoe, String> param) {
                        return new TableCell<Shoe, String>() {

                            final Button addToCartButton = new Button("Add to Cart");

                            @Override
                            public void updateItem(String item, boolean empty) {
                                super.updateItem(item, empty);
                                if (empty) {
                                    setGraphic(null);
                                    setText(null);
                                } else {
                                    addToCartButton.setOnAction(event -> {
                                        Shoe shoe = getTableView().getItems().get(getIndex());
                                        //System.out.println(shoe);
                                        addToCart(shoe);
                                    });
                                    addToCartButton.setStyle("-fx-background-color: #0000A7; -fx-text-fill: yellow;");
                                    setGraphic(addToCartButton);
                                    setText(null);
                                }
                            }
                        };
                    }
                };

        //noinspection unchecked
        colAction.setCellFactory(cellFactory);
        shoeDisplay.setItems(shoeTableContentList);

    }

    private void addToCart(Shoe shoe) {
       // Repository.addToCart(shoe);
       Alert shoeAlert = new Alert(Alert.AlertType.INFORMATION);
       shoeAlert.setContentText("Selected shoe: " + shoe);
       shoeAlert.show();


    }


    public void goToProfileSettings(ActionEvent actionEvent) {
    }
}
