# 🔐 Simple 2FA Setup - 3 Steps Only!

## Step 1: Open XAMPP MySQL Shell

1. Open **XAMPP Control Panel**
2. Click the **"Shell"** button (it opens a black terminal window)
3. Type this command and press Enter:
   ```
   mysql -u root
   ```

## Step 2: Run These SQL Commands

Copy and paste ALL of these lines into the MySQL shell:

```sql
USE eventsphere;

ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6);
ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL;

UPDATE users SET two_factor_enabled = FALSE;
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';

SELECT username, email, two_factor_enabled FROM users;
```

You should see a table showing all users with their 2FA status.
Admin should show `1` (enabled), others should show `0` (disabled).

## Step 3: Test 2FA!

1. **Logout** from EventSphere (if you're logged in)
2. Go to: `http://localhost:8080/EventSphere/login.jsp`
3. Login with: **admin** / **admin123**
4. **You'll see the 2FA verification page!** 🎉
5. **Look at your Tomcat console** (the black window where Tomcat runs)
6. You'll see something like:
   ```
   ===========================================
   📧 SIMULATED EMAIL SENT
   ===========================================
   To: admin@eventsphere.com
   Your verification code is: 123456
   ===========================================
   ```
7. **Enter the 6-digit code** in the verification page
8. Click "Verify Code"
9. **You're in!** 🚀

## Troubleshooting

### If SQL gives "Duplicate column" error:
- That's OK! It means the columns already exist
- Just continue with the UPDATE commands

### If you don't see the 2FA page after login:
- Make sure you ran ALL the SQL commands
- Check that admin has 2FA enabled:
  ```sql
  SELECT two_factor_enabled FROM users WHERE username='admin';
  ```
- Should return `1`

### If you can't find the code:
- Look at the **Tomcat console window** (where you started Tomcat)
- The code is printed there in a box
- Code expires in 5 minutes

### To disable 2FA:
```sql
UPDATE users SET two_factor_enabled = FALSE WHERE username = 'admin';
```

### To enable 2FA for students:
```sql
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'john_doe';
```

## That's It!

Your 2FA is now working! The application already has all the code, you just needed to add the database columns. 🎉
