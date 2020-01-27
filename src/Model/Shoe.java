package Model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Shoe {

    private Model model;
    private Size size;
    private Brand brand;
    private int price;
    private String color;
    private int stockQuantity;
    private List<Category> categories = new ArrayList<Category>();


    public Shoe(Model model, Size size, Brand brand, int price, String color, int stockQuantity, List<Category> categories) {
        this.model = model;
        this.size = size;
        this.brand = brand;
        this.price = price;
        this.color = color;
        this.stockQuantity = stockQuantity;
        this.categories = categories;
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public List getCategories() {
        return categories;
    }

    public void setCategories(List categories) {
        this.categories = categories;
    }

    @Override
    public String toString() {
        return model.getModel() + ", " + brand.getBrand() + ", storlek " + size.getEu() + "/" + size.getJapan() + ", " + price + " kr, " + color + " färg, i lager: " + stockQuantity;
    }
}
