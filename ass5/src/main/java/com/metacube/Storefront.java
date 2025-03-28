package com.metacube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Storefront {
    private String url = "jdbc:mysql://localhost:3306/storefront";
    private String username = "root";
    private String pass = "root";

    public List<User> getUser() {
        String searchUsersQuery = "SELECT user_id, user_name from user";
        List<User> userList = new ArrayList<>();
        try {
            Connection connection = DriverManager.getConnection(url, username, pass);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(searchUsersQuery);
            while (rs.next()) {
                userList.add(new User(rs.getInt("user_id"), rs.getString("user_name")));
            }

            return userList;
        } catch (SQLException sException) {
            sException.printStackTrace();
            return userList;
        }
    }

    public List<OrderItem> getOrderOfUser(int userId) {

        String getOrderQuery = "SELECT oi.order_item_id, o.order_id, o.order_date, oi.status FROM orders o JOIN order_item oi ON o.order_id = oi.order_id WHERE o.user_id = ? AND oi.status = \\\"shipped\\\" ORDER BY o.order_date DESC;";
        List<OrderItem> orderItems = new ArrayList<>();
        try {
            Connection connection = DriverManager.getConnection(url, username, pass);
            PreparedStatement fetchOrderQuery = connection.prepareStatement(getOrderQuery);
            fetchOrderQuery.setInt(1, userId);

            ResultSet orderSet = fetchOrderQuery.executeQuery();

            while (orderSet.next()) {
                orderItems.add(new OrderItem(orderSet.getInt(1), orderSet.getInt(2), getOrderQuery, getOrderQuery));
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    // public List<Order>
}
