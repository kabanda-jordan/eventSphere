-- Run this in your MySQL/XAMPP to add 2FA support
USE eventsphere;

-- Add 2FA columns if they don't exist
ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_code VARCHAR(6);
ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_expiry TIMESTAMP NULL;

-- Set all existing users to have 2FA disabled
UPDATE users SET two_factor_enabled = FALSE WHERE two_factor_enabled IS NULL;

-- Enable 2FA for admin account (for testing)
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';

-- Verify the changes
SELECT username, email, two_factor_enabled FROM users;

SELECT 'Two-Factor Authentication setup complete!' AS Status;
