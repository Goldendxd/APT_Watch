package com.alughadi.entity;

import java.sql.Timestamp;

public class Cart {
    // ── Cart table fields ──────────────────────────────────────
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private Timestamp createdAt;

    // ── Joined product fields (for display) ───────────────────
    private String productName;
    private String brand;
    private String imageUrl;
    private double price;
    private double totalPrice;

    public Cart(int id, int userId, int productId, int quantity, Timestamp createdAt, String productName,
                String brand, String imageUrl, double price, double totalPrice) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.createdAt = createdAt;
        this.productName = productName;
        this.brand = brand;
        this.imageUrl = imageUrl;
        this.price = price;
        this.totalPrice = totalPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "id=" + id +
                ", userId=" + userId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", createdAt=" + createdAt +
                ", productName='" + productName + '\'' +
                ", brand='" + brand + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", price=" + price +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
