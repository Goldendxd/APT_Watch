package com.alughadi.dao;

import com.alughadi.entity.Product;

import java.util.List;

public interface ProductDAO {
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(String categoryName);
    int getTotalInStockCount();
    double getAverageRating();

}
