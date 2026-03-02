-- ========================================
-- SETUP KABANDA AS ADMIN WITH 2FA
-- ========================================
-- Run this in XAMPP MySQL Shell
-- ========================================

USE eventsphere;

-- Add 2FA columns (ignore errors if they exist)
ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6);
ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL;

-- Make kabanda ADMIN
UPDATE users SET role = 'ADMIN' WHERE username = 'kabanda';

-- Enable 2FA for kabanda
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'kabanda';

-- Delete old admin
DELETE FROM users WHERE username = 'admin';

-- Verify
SELECT id, username, email, role, two_factor_enabled AS '2FA' FROM users ORDER BY role DESC;

-- ========================================
-- DONE!
-- Login as: kabanda (with your password)
-- 2FA is ENABLED - check Tomcat console for code
-- ========================================
