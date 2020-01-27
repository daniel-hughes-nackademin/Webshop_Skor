package Controller;

import Model.Shoe;
import Program.Program;
import Utility.Repository;
import Utility.ViewManager;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.input.MouseEvent;
import javafx.util.Callback;
import java.util.HashMap;
import java.util.Map;

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
    private TableColumn<Shoe, String> colCategories;
    @FXML
    private TableColumn<Shoe, Integer> colPrice;
    @FXML
    private TableColumn colAction;
    @FXML
    private TableColumn<Shoe, Integer> colStock;
    @FXML
    private Label nrOfItemsInCartLabel;

    private HashMap<Integer, Shoe> shoes;



    public void initialize(){
        customerNameLabel.setText(Program.customer.getFirstName() + " " + Program.customer.getLastName());
        nrOfItemsInCartLabel.setText(String.valueOf(Program.nrOfItemsInCart));

        populateTableView();
    }

    private void populateTableView() {
        ObservableList<Shoe> shoeTableContentList = getObservableShoeListFromDB();

        colBrand.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getBrand().getBrand()));
        colModel.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getModel().getModel()));
        colColor.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getColor()));
        colEU.setCellValueFactory(shoe -> new SimpleIntegerProperty(shoe.getValue().getSize().getEu()).asObject());
        colCategories.setCellValueFactory(shoe -> new SimpleStringProperty(shoe.getValue().getConcatenatedCategories()));
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

    private ObservableList<Shoe> getObservableShoeListFromDB() {
        shoes = Repository.getShoesFromDB();
        ObservableList<Shoe> shoeTableContentList = FXCollections.observableArrayList();
        shoes.entrySet().stream().filter(shoeEntry -> shoeEntry.getValue().getStockQuantity() > 0).forEach(shoeEntry -> shoeTableContentList.add(shoeEntry.getValue()));
        //shoes.forEach((id, shoe) -> shoeTableContentList.add(shoe));
        return shoeTableContentList;
    }

    private void addToCart(Shoe shoe) {

        int shoeId = shoes.entrySet().stream()
                .filter(e -> e.getValue().equals(shoe))
                .map(Map.Entry::getKey)
                .findFirst().get();



        if(Repository.addToCart(shoeId)){
            Program.viewMessage("Selected shoe added to cart", "Happy Shopping!", Alert.AlertType.INFORMATION);
            Program.nrOfItemsInCart++;
            nrOfItemsInCartLabel.setText(Integer.toString(Program.nrOfItemsInCart));
            ObservableList<Shoe> shoeTableContentList = getObservableShoeListFromDB();
            shoeDisplay.setItems(shoeTableContentList);
            shoeDisplay.refresh();
            System.out.println("Order ID: " + Program.currentOrderID);
        }



    }


    public void goToProfileSettings(ActionEvent actionEvent) {
        ViewManager.changeScene(ViewManager.View.PROFILE);
    }

    @FXML
    private void goToCheckout(MouseEvent mouseEvent) {
        if(Program.currentOrderID != 0)
            ViewManager.changeScene(ViewManager.View.CART);
        else
            Program.viewMessage("Your cart is empty", "Don't be so stingy. Buy a few pairs", Alert.AlertType.INFORMATION);
    }

    @FXML
    private void logOut(ActionEvent actionEvent) {
        Program.logOut();
    }
}
