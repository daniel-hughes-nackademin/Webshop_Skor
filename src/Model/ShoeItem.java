package Model;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

public class ShoeItem {

    private ImageView shoeImage;
    private Shoe shoe;

    public ShoeItem(Shoe shoe, String imageURL) {
        this.shoe = shoe;
        shoeImage = new ImageView(new Image(imageURL));
    }
}
