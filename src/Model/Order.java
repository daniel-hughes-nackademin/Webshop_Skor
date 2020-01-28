package Model;

import java.util.Date;
import java.util.HashMap;

public class Order {

    private Date orderDate;
    private HashMap<Integer, OrderItem> orderItems;

    public Order(Date orderDate, HashMap<Integer, OrderItem> orderItems) {
        this.orderDate = orderDate;
        this.orderItems = orderItems;
    }


    public Date getOrderDate() {
        return orderDate;
    }

    public HashMap<Integer, OrderItem> getOrderItems() {
        return orderItems;
    }
}
