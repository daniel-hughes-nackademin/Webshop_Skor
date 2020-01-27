package Model;

public class OrderItem {

    private Shoe shoe;
    private int quantity;

    public OrderItem(Shoe shoe, int quantity) {
        this.shoe = shoe;
        this.quantity = quantity;
    }

    public Shoe getShoe() {
        return shoe;
    }

    public int getQuantity() {
        return quantity;
    }
}
