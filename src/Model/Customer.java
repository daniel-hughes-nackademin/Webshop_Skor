package Model;

import java.util.HashMap;
import java.util.Map;

public class Customer {
    private String firstName;
    private String lastName;
    private String email;
    private City city;

    private Map<Integer, Order> orders = new HashMap<>();
    private Map<Integer, Review> reviews = new HashMap<>();


    public Customer(String firstName, String lastName, String email, City city) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.city = city;
    }


    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Map<Integer, Order> getOrders() {
        return orders;
    }

    public void setOrders(Map<Integer, Order> orders) {
        this.orders = orders;
    }

    public Map<Integer, Review> getReviews() {
        return reviews;
    }

    public void setReviews(Map<Integer, Review> reviews) {
        this.reviews = reviews;
    }
}
