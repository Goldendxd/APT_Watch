package com.alughadi.entity;

import java.sql.Timestamp;

/**
 * Cart — represents one row in the cart table, plus extra fields joined in
 * from the products table so the cart page can show product name, image, and price
 * without a second query.
 *
 * DB columns (cart table): id, user_id, product_id, quantity, created_at
 * Extra joined fields:     productName, brand, imageUrl, price, oldPrice,
 *                          stockQuantity, totalPrice (price * quantity)
 */
public class Cart {
    // ── Cart table fields ──────────────────────────────────────
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private int stockQuantity;
    private Timestamp createdAt;

    // ── Joined product fields (for display) ───────────────────
    private String productName;
    private String brand;
    private String imageUrl;
    private double price;
    private double oldPrice;
    private double totalPrice;

    public Cart() {}

    public Cart(int id, int userId,double oldPrice, int productId, int quantity, Timestamp createdAt, String productName,
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

    public double getOldPrice() {
        return oldPrice;
    }

    public void setOldPrice(double oldPrice) {
        this.oldPrice = oldPrice;
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

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
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
                ", oldPrice=" + oldPrice +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
