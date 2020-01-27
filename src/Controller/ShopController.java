package Controller;

import Model.Shoe;
import Model.ShoeItem;
import javafx.beans.Observable;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.ListView;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;

public class ShopController {
    public ListView<Object> listView;



    public void initialize(){
        ObservableList listData = FXCollections.observableArrayList();
        Shoe shoe = new Shoe("Nike", "Air", "42EU", 5, 799);
        listData.addAll(new ImageView(new Image("Resources/shoe.png")), shoe.getBrand(), shoe.getModel(), shoe.getSize());
        listView.getItems().addAll(listData);
    }

    public void selectItem(MouseEvent mouseEvent) {
    }
}
