package com.alughadi.dao;

import com.alughadi.entity.User;

/** Defines all user DB operations. UserDaoImpl provides the actual SQL. */
public interface UserDao {
    boolean insertUser(User user);
    User findByUsername(String username);
    User findByEmail(String email);
    User findById(int id);
    int countCustomers();
    boolean updateProfile(User user);
    boolean changePassword(int userId, String newHashedPassword);
    boolean updateProfileImage(int userId, String imagePath);
}
