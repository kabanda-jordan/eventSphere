package com.eventsphere.util;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class OTPUtil {
    private static final SecureRandom random = new SecureRandom();
    private static final int OTP_LENGTH = 6;
    private static final int OTP_VALIDITY_MINUTES = 5;

    /**
     * Generate a 6-digit OTP code
     */
    public static String generateOTP() {
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Get OTP expiry time (5 minutes from now)
     */
    public static Date getOTPExpiry() {
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(OTP_VALIDITY_MINUTES);
        return Date.from(expiry.atZone(ZoneId.systemDefault()).toInstant());
    }

    /**
     * Check if OTP is expired
     */
    public static boolean isOTPExpired(Date expiryDate) {
        if (expiryDate == null) {
            return true;
        }
        return new Date().after(expiryDate);
    }

    /**
     * Validate OTP code
     */
    public static boolean validateOTP(String inputOTP, String storedOTP, Date expiryDate) {
        if (inputOTP == null || storedOTP == null || expiryDate == null) {
            return false;
        }
        
        if (isOTPExpired(expiryDate)) {
            return false;
        }
        
        return inputOTP.equals(storedOTP);
    }
}
