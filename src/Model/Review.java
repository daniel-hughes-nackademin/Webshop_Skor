package Model;

import java.time.LocalDate;

public class Review {
    private Shoe shoe;
    private Rating rating;
    private String comment;
    private LocalDate reviewDate;

    public Review(Shoe shoe, Rating rating, String comment) {
        this.shoe = shoe;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = LocalDate.now();
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

    public LocalDate getReviewDate() {
        return reviewDate;
    }
}
