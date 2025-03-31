package com.metacube;

import java.sql.Connection;
import java.sql.Driver;
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

            return orderItems;
        } catch (SQLException e) {
            e.printStackTrace();
            return orderItems;
        }
    }

    public int addImage(int productId, List<String> imageUrlList) {
        try {
            String addImageQuery = "INSERT INTO image(image_url, product_id) VALUES(?,?)";
            Connection connection = DriverManager.getConnection(url, username, pass);
            PreparedStatement batchImageInsertion = connection.prepareStatement(addImageQuery);
            for (int i = 0; i < imageUrlList.size(); i++) {
                batchImageInsertion.setString(1, imageUrlList.get(i));
                batchImageInsertion.setInt(2, productId);
                batchImageInsertion.addBatch();
            }
            int[] result = batchImageInsertion.executeBatch();

            return result.length;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<Product> getNotOrderedProducts() {
        List<Product> productList = new ArrayList<>();
        try {
            String getUnOrderedProduct = "SELECT product_id, product_name, price FROM product WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_item oi JOIN orders o ON oi.order_id = o.order_id WHERE o.order_date >= (current_date() - INTERVAL 1 YEAR));";
            Connection connection = DriverManager.getConnection(url, username, pass);
            Statement st = connection.createStatement();
            ResultSet res = st.executeQuery(getUnOrderedProduct);
            while (res.next()) {
                productList.add(new Product(res.getInt("product_id"), res.getString("product_name"),
                        res.getInt("price")));
            }

            return productList;
        } catch (SQLException e) {
            e.printStackTrace();
            return productList;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return productList;
        }
    }

    public int deleteNotOrderedProducts() {
        try {
            String deletionQuery = "DELETE FROM product WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_item oi JOIN orders o ON oi.order_id = o.order_id WHERE o.order_date >= (current_date() - INTERVAL 1 YEAR))";
            Connection connection = DriverManager.getConnection(url, username, pass);
            Statement st = connection.createStatement();
            int r = st.executeUpdate(deletionQuery);
            return r;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<Category> getSubCategoryInfo() {
        List<Category> categoryList = new ArrayList<>();
        try {
            String query = "SELECT p.category_id, p.category_name, COUNT(c.category_id) AS sub_categories FROM category p JOIN category c ON p.category_id = c.parent_category_id GROUP BY p.category_id;";
            Connection connection = DriverManager.getConnection(url, username, pass);
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                categoryList.add(new Category(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }

            return categoryList;
        } catch (SQLException e) {
            e.printStackTrace();
            return categoryList;
        }
    }
}
