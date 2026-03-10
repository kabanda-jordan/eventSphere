package com.eventsphere.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility to check if a plain password matches a BCrypt hash
 * This is for testing/debugging only - NOT for production use
 */
public class PasswordChecker {
    
    public static void main(String[] args) {
        // The BCrypt hash from your database
        String hash = "$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi";
        
        // Test different passwords
        String[] testPasswords = {
            "admin123",
            "student123",
            "password",
            "123456",
            "eventsphere"
        };
        
        System.out.println("Testing BCrypt hash:");
        System.out.println(hash);
        System.out.println("\nTrying different passwords...\n");
        
        for (String password : testPasswords) {
            boolean matches = BCrypt.checkpw(password, hash);
            System.out.println("Password: '" + password + "' → " + (matches ? "✅ MATCH!" : "❌ No match"));
        }
        
        System.out.println("\n" + "=".repeat(50));
        System.out.println("Note: BCrypt hashes CANNOT be decrypted!");
        System.out.println("You can only verify if a password matches.");
        System.out.println("=".repeat(50));
    }
    
    /**
     * Check if a plain password matches a BCrypt hash
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            System.err.println("Error checking password: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Generate a new BCrypt hash for a password
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }
}
