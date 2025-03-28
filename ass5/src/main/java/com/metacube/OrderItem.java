package com.metacube;

import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private String orderDate;
    private String status;

    public OrderItem(int orderItemId, int orderId, String orderDate, String status) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public String getStatus() {
        return status;
    }
}
