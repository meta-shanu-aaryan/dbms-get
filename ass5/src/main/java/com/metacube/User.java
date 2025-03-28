package com.metacube;

public class User {
    private int userId;
    private String user_name;

    public User(int userId, String name) {
        this.userId = userId;
        this.user_name = name;
    }

    public int getUserId() {
        return userId;
    }

    public String getUser_name() {
        return user_name;
    }
}
