-- ========================================
-- COMPLETE SETUP FOR KABANDA ADMIN WITH 2FA
-- ========================================
-- This script will:
-- 1. Add 2FA columns to users table (if not exist)
-- 2. Make kabanda the ADMIN
-- 3. Enable 2FA for kabanda
-- 4. Delete the old admin account
-- 5. Show all users to confirm
-- ========================================

USE eventsphere;

-- ========================================
-- STEP 1: Add 2FA Columns (if not exist)
-- ========================================

-- Add two_factor_enabled column
ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_enabled BOOLEAN DEFAULT FALSE;

-- Add two_factor_code column
ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_code VARCHAR(6);

-- Add two_factor_expiry column
ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_expiry TIMESTAMP NULL;

SELECT '✅ Step 1: 2FA columns added/verified' AS Status;

-- ========================================
-- STEP 2: Make kabanda ADMIN
-- ========================================

UPDATE users SET role = 'ADMIN' WHERE username = 'kabanda';

SELECT '✅ Step 2: kabanda is now ADMIN' AS Status;

-- ========================================
-- STEP 3: Enable 2FA for kabanda
-- ========================================

UPDATE users SET two_factor_enabled = TRUE WHERE username = 'kabanda';

SELECT '✅ Step 3: 2FA enabled for kabanda' AS Status;

-- ========================================
-- STEP 4: Delete old admin account
-- ========================================

DELETE FROM users WHERE username = 'admin';

SELECT '✅ Step 4: Old admin account deleted' AS Status;

-- ========================================
-- STEP 5: Verify Everything
-- ========================================

SELECT 
    id, 
    username, 
    email, 
    role, 
    two_factor_enabled AS '2FA',
    created_at 
FROM users 
ORDER BY role DESC, username;

-- ========================================
-- DONE! ✅
-- ========================================
-- Now you can login as:
-- Username: kabanda
-- Password: (your password)
-- Role: ADMIN
-- 2FA: ENABLED
-- 
-- When you login, you'll see the 2FA verification page!
-- Check Tomcat console for the 6-digit code.
-- ========================================
