-- ========================================
-- UPDATE ADMIN ACCOUNT TO KABANDA
-- ========================================
-- This script will:
-- 1. Make kabanda the ADMIN
-- 2. Delete the old admin account
-- 3. Show all users to confirm
-- ========================================

USE eventsphere;

-- Step 1: Make kabanda ADMIN
UPDATE users SET role = 'ADMIN' WHERE username = 'kabanda';

-- Step 2: Delete old admin account
DELETE FROM users WHERE username = 'admin';

-- Step 3: Confirm the changes
SELECT id, username, email, role, created_at FROM users ORDER BY role DESC, username;

-- ========================================
-- DONE!
-- ========================================
-- Now you can login as:
-- Username: kabanda
-- Password: (your password)
-- Role: ADMIN
-- ========================================
