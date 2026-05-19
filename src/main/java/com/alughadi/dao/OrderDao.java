package com.alughadi.dao;

import java.util.List;
import java.util.Map;

public interface OrderDao {
    int saveOrder(int userId, double totalAmount, String paymentMethod, List<Object[]> items);
    double getTotalRevenue();
    int getTotalOrderCount();
    List<Map<String, Object>> getMonthlySales(int months);
    List<Map<String, Object>> getTopProducts(int limit);
    List<Map<String, Object>> getUserOrders(int userId);
}
