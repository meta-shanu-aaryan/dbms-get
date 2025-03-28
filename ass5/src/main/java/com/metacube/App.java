package com.metacube;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.InputMismatchException;
import java.util.Scanner;

public class App {

    public static int intScanner() {
        int n;
        while (true) {
            try {
                Scanner sc = new Scanner(System.in);
                n = sc.nextInt();
                if (n < 0) {
                    System.out.println("input should be positive integers");
                } else {
                    break;
                }

            } catch (InputMismatchException e) {
                System.out.println("Enter positive Integer only");
            }
        }
        return n;
    }

    public static void main(String[] args) throws SQLException {
        System.out.println("Connecting to database");
        String url = "jdbc:mysql://localhost:3306/storefront";
        String username = "root";
        String pass = "root";
        Connection connection = DriverManager.getConnection(url, username, pass);
        String query = "SHOW TABLES";
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(query);

        System.out.println("Available Tables");
        while (rs.next()) {
            System.out.println(rs.getString("Tables_in_storefront"));
        }

        try {
            Storefront sf = new Storefront();
            System.out.println("Select the assignment you want to check...");
            System.out.println("1.\tShow the users");
            System.out.println("2.\tGiven the id of a user, fetch all orders of the user");
            System.out.println("3.\tInsert five or more images of a product using batch insert technique.");
            System.out.println("4.\tShow all those products which were not ordered by any Shopper in last 1 year.");
            System.out.println("5.\tDelete all those products which were not ordered by any Shopper in last 1 year.");
            System.out.println(
                    "6.\tDisplay the category title of all top parent categories sorted alphabetically and the count of their child categories.");
            System.out.println("7.\tExit...");

            int choice = App.intScanner();

            switch (choice) {
                case 1:
                    for (User user : sf.getUser()) {
                        System.out.print(user.getUserId());
                        System.out.println("\t" + user.getUser_name());
                    }
                case 2:
                    System.out.println("Enter the Id of the user to fetch orders");
                    int userId = App.intScanner();
                    PreparedStatement fetchOrderQuery = connection.prepareStatement(
                            "SELECT oi.order_item_id, o.order_id, o.order_date, oi.status FROM orders o JOIN order_item oi ON o.order_id = oi.order_id WHERE o.user_id = ? AND oi.status = \"shipped\" ORDER BY o.order_date DESC;");
                    fetchOrderQuery.setInt(1, userId);
                    // fetchOrderQuery.setString(2, "shipped");

                    ResultSet orderSet = fetchOrderQuery.executeQuery();

                    while (orderSet.next()) {
                        System.out.print(orderSet.getInt("order_item_id"));
                        System.out.print("\t" + orderSet.getInt("order_id"));
                        System.out.print("\t" + orderSet.getString("order_date"));
                        System.out.println("\t" + orderSet.getString("status"));
                    }
                    break;

                case 3:
                    String searchProductsQuery = "SELECT product_id, product_name from product";
                    // Statement statement2 = connection.createStatement();
                    ResultSet productSet = statement.executeQuery(searchProductsQuery);

                    while (productSet.next()) {
                        System.out.print(productSet.getInt("product_id"));
                        System.out.println("\t" + productSet.getString("product_name"));
                    }
                    break;
                case 4:
                    int productId = App.intScanner();
                    System.out.println("How many images you want to insert ?");
                    int noOfProducts = App.intScanner();

                default:
                    break;
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
