-- Update passwords to match BCrypt hashes for admin123 and student123
USE eventsphere;

-- Update admin password (admin123)
-- BCrypt hash for "admin123"
UPDATE users SET password = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy' WHERE username = 'admin';

-- Update student passwords (student123)
-- BCrypt hash for "student123"
UPDATE users SET password = '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi' WHERE role = 'STUDENT';

SELECT 'Passwords updated successfully!' AS message;
SELECT id, username, email, role, LEFT(password, 30) AS password_hash FROM users;
