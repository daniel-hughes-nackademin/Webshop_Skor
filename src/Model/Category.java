package Model;

public class Category {

    private String category;

    public Category(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    @Override
    public String toString() {
        return category;
    }
}
