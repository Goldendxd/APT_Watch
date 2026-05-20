package com.alughadi.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil — handles password hashing and checking using BCrypt.
 *
 * getHashPassword(plainText) — generate a salted BCrypt hash. Call this once
 *   when the user registers or changes their password. Store the hash in the DB.
 * checkPassword(typed, stored) — compare a plain-text password against the stored
 *   hash. Returns true if they match. Call this during login.
 *
 * BCrypt is slow by design — the cost factor (10) means each hash takes ~100ms,
 * which makes brute-force attacks much harder.
 */
public class PasswordUtil {

    // Cost factor: 2^COST iterations. 10-12 is typical.
    // Higher = slower = more brute-force resistant, but slower login.
    private static final int COST = 10;

    public static String getHashPassword(String inputPassword) {
        String salt = BCrypt.gensalt(COST);
        return BCrypt.hashpw(inputPassword, salt);
    }

    public static boolean checkPassword(String passwordTyped, String hashedPassword) {
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }
}
