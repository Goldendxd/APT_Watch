package com.alughadi.utils;

import java.util.regex.Pattern;

/**
 * ValidationUtil — server-side input validation helpers used by RegisterServlet.
 *
 * isNullOrEmpty           — check that a field is actually filled in.
 * isAlphanumericStartingWithLetter — enforce username format rules.
 * isValidEmail            — check basic email format (something@domain.tld).
 * isValidPassword         — enforce strong password (8+ chars, uppercase, number, symbol).
 * doPasswordsMatch        — confirm the two password fields are the same.
 *
 * Client-side JS can be bypassed, so these server-side checks run even if the
 * browser already validated the form.
 */
public class ValidationUtil {

    /**
     * Check if a value is null or empty (after trimming whitespace).
     */
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Check if a string starts with a letter and contains only
     * letters and numbers (alphanumeric).
     * Example: "john123" → true, "123john" → false, "john@" → false
     */
    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    /**
     * Check if a string is a valid email format.
     * Uses regex pattern: word-chars/dots/hyphens @ domain . 2-4 char TLD
     */
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    /**
     * Check if a password meets strength requirements:
     * - At least 8 characters
     * - At least 1 uppercase letter
     * - At least 1 number
     * - At least 1 symbol (@$!%*?&)
     */
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    /**
     * Check if password and confirm password match.
     */
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }
}
