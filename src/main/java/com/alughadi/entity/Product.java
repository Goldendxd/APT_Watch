package com.alughadi.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int id;
    private int categoryId;
    private String name;
    private String brand;
    private String description;
    private BigDecimal price;
    private BigDecimal oldPrice;
    private double rating;
    private String imageUrl;
    private boolean inStock;
    private int stockQuantity;
    private Timestamp createdAt;
    private String categoryName;

    public Product(int id, int categoryId, String name, String brand,
                   String description, BigDecimal price, BigDecimal oldPrice,
                   double rating, String imageUrl, boolean inStock,
                   Timestamp createdAt, String categoryName) {
        this.id = id;
        this.categoryId = categoryId;
        this.name = name;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.oldPrice = oldPrice;
        this.rating = rating;
        this.imageUrl = imageUrl;
        this.inStock = inStock;
        this.createdAt = createdAt;
        this.categoryName = categoryName;
    }

    public Product() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getOldPrice() {
        return oldPrice;
    }

    public void setOldPrice(BigDecimal oldPrice) {
        this.oldPrice = oldPrice;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", categoryId=" + categoryId +
                ", name='" + name + '\'' +
                ", brand='" + brand + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", oldPrice=" + oldPrice +
                ", rating=" + rating +
                ", imageUrl='" + imageUrl + '\'' +
                ", inStock=" + inStock +
                ", createdAt=" + createdAt +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }
}

