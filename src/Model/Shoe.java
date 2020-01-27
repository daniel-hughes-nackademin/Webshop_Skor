package Model;

public class Shoe {

    private String brand;
    private String model;
    private String size;
    private int stock_quantity;
    private int price;

    public Shoe(String brand, String model, String size, int stock_quantity, int price) {
        this.brand = brand;
        this.model = model;
        this.size = size;
        this.stock_quantity = stock_quantity;
        this.price = price;
    }


    public String getBrand() {
        return brand;
    }

    public String getModel() {
        return model;
    }

    public String getSize() {
        return size;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public int getPrice() {
        return price;
    }
}
