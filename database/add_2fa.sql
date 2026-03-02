-- Add Two-Factor Authentication fields to users table
USE eventsphere;

-- Add 2FA columns
ALTER TABLE users 
ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE,
ADD COLUMN two_factor_code VARCHAR(6),
ADD COLUMN two_factor_expiry TIMESTAMP NULL;

-- Update existing users to have 2FA disabled by default
UPDATE users SET two_factor_enabled = FALSE WHERE two_factor_enabled IS NULL;

SELECT 'Two-Factor Authentication fields added successfully!' AS message;
