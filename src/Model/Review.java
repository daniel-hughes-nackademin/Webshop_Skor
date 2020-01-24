package Model;

public class Review {
    private Customer customer;
    private Shoe shoe;
    private Rating rating;
    private String comment;

    public Review(Customer customer, Shoe shoe, Rating rating, String comment) {
        this.customer = customer;
        this.shoe = shoe;
        this.rating = rating;
        this.comment = comment;
    }

    public Customer getCustomer() {
        return customer;
    }

    public Shoe getShoe() {
        return shoe;
    }

    public Rating getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }
}
