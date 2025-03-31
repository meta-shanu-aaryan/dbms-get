package com.metacube;

public class Category {
    private int categoryId;
    private String categoryName;
    private int childCategory;

    public Category(int categoryId, String categoryName, int childCategory) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.childCategory = childCategory;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public int getChildCategory() {
        return childCategory;
    }

}
