# 🔐 Enable Two-Factor Authentication - Quick Guide

## 3 Easy Ways to Enable 2FA

### ✨ Option 1: Automatic Setup (EASIEST!)

Just visit one of these pages in your browser:

1. **http://localhost:8080/EventSphere/enable-2fa-now.jsp** (Recommended - checks status first)
2. **http://localhost:8080/EventSphere/setup-2fa.jsp** (Direct setup)

Click the button and you're done! The page will automatically:
- Add the required database columns
- Enable 2FA for the admin account
- Show you next steps

### 📝 Option 2: Manual SQL Commands

1. Open **XAMPP Control Panel**
2. Click **"Shell"** button
3. Type: `mysql -u root` and press Enter
4. Copy and paste:

```sql
USE eventsphere;

ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6);
ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL;

UPDATE users SET two_factor_enabled = FALSE;
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';
```

### 🖥️ Option 3: Using MySQL Workbench or phpMyAdmin

1. Open phpMyAdmin: **http://localhost/phpmyadmin**
2. Select **eventsphere** database
3. Click **SQL** tab
4. Paste the SQL commands from Option 2
5. Click **Go**

---

## Testing 2FA

After enabling 2FA:

1. **Logout** from EventSphere
2. Go to: **http://localhost:8080/EventSphere/login.jsp**
3. Login with: `admin` / `admin123`
4. You'll see the **2FA verification page** 🎉
5. **Check your Tomcat console** (the black window where Tomcat runs)
6. You'll see something like:

```
===========================================
📧 SIMULATED EMAIL SENT
===========================================
To: admin@eventsphere.com
Your verification code is: 123456
===========================================
```

7. Enter the **6-digit code** in the verification page
8. Click **"Verify Code"**
9. You're in! 🚀

---

## Troubleshooting

### "HTTP Status 404 - Not Found"
- Make sure Tomcat is running
- Check the URL is correct: `http://localhost:8080/EventSphere/enable-2fa-now.jsp`
- Try restarting Tomcat

### "Database error occurred"
- Make sure XAMPP MySQL is running (green in XAMPP Control Panel)
- Check that the `eventsphere` database exists
- Try the manual SQL option instead

### "Duplicate column" error
- That's OK! It means the columns already exist
- Just continue with the UPDATE commands to enable 2FA for admin

### Can't find the 6-digit code
- Look at the **Tomcat console window** (where you started Tomcat)
- The code is printed there in a box
- Code expires in 5 minutes - if expired, logout and login again

### 2FA page doesn't show after login
- Check that admin has 2FA enabled:
  ```sql
  SELECT two_factor_enabled FROM users WHERE username='admin';
  ```
- Should return `1` (enabled)
- If it returns `0`, run:
  ```sql
  UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';
  ```

---

## Managing 2FA

### Enable 2FA for other users:
```sql
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'john_doe';
```

### Disable 2FA for a user:
```sql
UPDATE users SET two_factor_enabled = FALSE WHERE username = 'admin';
```

### Check who has 2FA enabled:
```sql
SELECT username, email, two_factor_enabled FROM users;
```

---

## How It Works

1. User enters username/password
2. If 2FA is enabled for that user:
   - System generates a random 6-digit code
   - Code is "sent" via email (simulated - printed to console)
   - Code expires in 5 minutes
   - User must enter the code to complete login
3. If 2FA is not enabled:
   - User logs in directly (normal flow)

---

## Current Status

- ✅ All 2FA code is implemented and ready
- ✅ Login flow handles 2FA automatically
- ✅ Verification page is beautiful and functional
- ✅ OTP generation and validation working
- ⚠️ Just need to add database columns (use one of the 3 options above)

---

## Need Help?

If you're still having issues:

1. Check that XAMPP MySQL is running
2. Check that Tomcat is running
3. Try restarting both XAMPP and Tomcat
4. Clear your browser cache
5. Check Tomcat logs for errors

---

**That's it! Your 2FA system is ready to impress your teacher! 🎓**
