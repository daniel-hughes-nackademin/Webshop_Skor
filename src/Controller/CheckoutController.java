package Controller;

import Model.OrderItem;
import Program.Program;
import Utility.Repository;
import Utility.ViewManager;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.print.PageLayout;
import javafx.print.Paper;
import javafx.print.PrinterJob;
import javafx.scene.control.*;
import javafx.scene.input.MouseEvent;

import java.util.HashMap;
import java.util.List;

public class CheckoutController {
    @FXML
    private Label customerNameLabel;

    @FXML
    private TableView<OrderItem> shoeDisplay;
    @FXML
    private TableColumn<OrderItem, String> colBrand;
    @FXML
    private TableColumn<OrderItem, String> colModel;
    @FXML
    private TableColumn<OrderItem, String> colColor;
    @FXML
    private TableColumn<OrderItem, Integer> colEU;
    @FXML
    private TableColumn<OrderItem, String> colCategories;
    @FXML
    private TableColumn<OrderItem, Integer> colPrice;
    @FXML
    private TableColumn<OrderItem, Integer> colQuantity;
    @FXML
    private TableColumn<OrderItem, Integer> colTotal;
    @FXML
    private Label nrOfItemsInCartLabel;

    private HashMap<Integer, OrderItem> cart;
    @FXML
    private Label totalPriceLabel;


    public void initialize(){
        customerNameLabel.setText(Program.customer.getFirstName() + " " + Program.customer.getLastName());
        nrOfItemsInCartLabel.setText(String.valueOf(Program.nrOfItemsInCart));


        populateTableView();
    }

    private void populateTableView() {


        colBrand.setCellValueFactory(orderItem -> new SimpleStringProperty(orderItem.getValue().getShoe().getBrand().getBrand()));
        colModel.setCellValueFactory(orderItem -> new SimpleStringProperty(orderItem.getValue().getShoe().getModel().getModel()));
        colColor.setCellValueFactory(orderItem -> new SimpleStringProperty(orderItem.getValue().getShoe().getColor()));
        colEU.setCellValueFactory(orderItem -> new SimpleIntegerProperty(orderItem.getValue().getShoe().getSize().getEu()).asObject());
        colCategories.setCellValueFactory(orderItem -> new SimpleStringProperty(orderItem.getValue().getShoe().getConcatenatedCategories()));
        colPrice.setCellValueFactory(orderItem -> new SimpleIntegerProperty(orderItem.getValue().getShoe().getPrice()).asObject());
        colQuantity.setCellValueFactory(orderItem -> new SimpleIntegerProperty(orderItem.getValue().getQuantity()).asObject());
        colTotal.setCellValueFactory(orderItem -> new SimpleIntegerProperty(
                                                                    orderItem.getValue().getQuantity()
                                                                               * orderItem.getValue().getShoe().getPrice()).asObject());
        ObservableList<OrderItem> cartContentList = getOrderItemsAsObservableListFromDB();
        shoeDisplay.setItems(cartContentList);

        int totalPrice = cartContentList.stream().mapToInt(orderItem -> orderItem.getShoe().getPrice() * orderItem.getQuantity()).sum();

        totalPriceLabel.setText(String.valueOf(totalPrice));
    }

    private ObservableList<OrderItem> getOrderItemsAsObservableListFromDB() {
        cart = Repository.getCurrentOrderItemsFromDB();
        ObservableList<OrderItem> cartContentList = FXCollections.observableArrayList();
        cart.forEach((shoeId, orderItem) -> cartContentList.add(orderItem));
        return cartContentList;
    }


    @FXML
    private void goToProfileSettings(ActionEvent actionEvent) {
        ViewManager.changeScene(ViewManager.View.PROFILE);
    }

    @FXML
    private void logOut(ActionEvent actionEvent) {
        Program.logOut();
    }

    @FXML
    private void goToShop(ActionEvent actionEvent) {
        ViewManager.changeScene(ViewManager.View.SHOP);
    }

    @FXML
    private void openPrinterDialog(MouseEvent mouseEvent) {
        PrinterJob job = PrinterJob.createPrinterJob();
        if(job != null){
            job.showPrintDialog(ViewManager.stage); // Window must be your main Stage
            job.printPage(shoeDisplay);
            job.endJob();
        }
    }
}
