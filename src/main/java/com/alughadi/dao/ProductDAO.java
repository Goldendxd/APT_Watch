package com.alughadi.dao;

import com.alughadi.entity.Product;

import java.util.List;

/** Defines all product DB operations. ProductDaoImpl provides the actual SQL. */
public interface ProductDAO {
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(String categoryName);
    Product getProductById(int id);

    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int id);
}
