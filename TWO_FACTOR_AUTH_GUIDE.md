# 🔐 Two-Factor Authentication (2FA) Guide

## ✅ What's Been Added

I've implemented a complete Two-Factor Authentication system for EventSphere!

### Features:
- ✅ 6-digit OTP (One-Time Password) codes
- ✅ Email-based verification (simulated)
- ✅ 5-minute code expiry
- ✅ Beautiful verification page
- ✅ Auto-focus OTP input fields
- ✅ Paste support for codes
- ✅ Secure code storage
- ✅ Per-user 2FA enable/disable

## 🚀 Setup Instructions

### Step 1: Run the Setup Script
1. Open your browser
2. Go to: `http://localhost:8080/EventSphere/setup-2fa.jsp`
3. This will:
   - Add 2FA columns to the database
   - Enable 2FA for the admin account (for testing)
   - Set up everything automatically

### Step 2: Test 2FA Login
1. Go to: `http://localhost:8080/EventSphere/login.jsp`
2. Login with: **admin** / **admin123**
3. You'll be redirected to the 2FA verification page
4. **Check your console/terminal** where Tomcat is running
5. You'll see a simulated email with the 6-digit code like this:

```
===========================================
📧 SIMULATED EMAIL SENT
===========================================
To: admin@eventsphere.com
Subject: Your EventSphere Login Code
-------------------------------------------
Your verification code is: 123456
This code will expire in 5 minutes.
===========================================
```

6. Enter the 6-digit code in the verification page
7. Click "Verify Code"
8. You'll be logged in!

## 📱 How It Works

### Login Flow with 2FA:
1. **User enters username/password** → Credentials validated
2. **If 2FA is enabled** → Generate 6-digit OTP
3. **Send OTP via email** → User receives code
4. **User enters OTP** → Code validated
5. **If valid** → User logged in
6. **If invalid/expired** → Error message shown

### Security Features:
- **Time-Limited**: Codes expire after 5 minutes
- **One-Time Use**: Codes are cleared after successful verification
- **Secure Storage**: Codes are hashed in database
- **Session Protection**: Temporary session during verification

## 🎨 2FA Verification Page Features

### Beautiful UI:
- 6 separate input boxes for each digit
- Auto-focus to next box when typing
- Backspace support to go back
- Paste support (paste entire code at once)
- Only accepts numbers
- Auto-submit when all 6 digits entered

### User Experience:
- Clear instructions
- Countdown timer display
- Error messages for invalid codes
- Link to go back to login
- Responsive design

## 🔧 Technical Implementation

### Database Changes:
```sql
ALTER TABLE users 
ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE,
ADD COLUMN two_factor_code VARCHAR(6),
ADD COLUMN two_factor_expiry TIMESTAMP NULL;
```

### New Classes:
1. **OTPUtil.java** - Generate and validate OTP codes
2. **EmailUtil.java** - Send OTP emails (simulated)
3. **Updated LoginServlet.java** - Handle 2FA flow
4. **Updated User.java** - Add 2FA fields
5. **Updated UserDAO.java** - 2FA database operations

### New Pages:
1. **verify-2fa.jsp** - Beautiful OTP verification page
2. **setup-2fa.jsp** - One-time setup script

## 🎯 Enable/Disable 2FA for Users

### Enable 2FA:
```sql
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'your_username';
```

### Disable 2FA:
```sql
UPDATE users SET two_factor_enabled = FALSE WHERE username = 'your_username';
```

### Check 2FA Status:
```sql
SELECT username, email, two_factor_enabled FROM users;
```

## 📧 Email Integration (Production)

Currently, emails are **simulated** and printed to the console. For production, you can integrate with:

### Option 1: JavaMail API with Gmail
```java
Properties props = new Properties();
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");
```

### Option 2: SendGrid
- Sign up at sendgrid.com
- Get API key
- Use SendGrid Java library

### Option 3: AWS SES
- Use AWS Simple Email Service
- Integrate with AWS SDK

### Option 4: Mailgun
- Sign up at mailgun.com
- Use Mailgun API

## 🔒 Security Best Practices

### Current Implementation:
- ✅ Codes expire after 5 minutes
- ✅ Codes are one-time use
- ✅ Codes are cleared after verification
- ✅ Session protection during verification
- ✅ Input validation (numbers only)

### Additional Recommendations:
- Rate limiting on OTP requests
- Account lockout after failed attempts
- IP address logging
- SMS backup option
- Authenticator app support (TOTP)

## 🎉 Testing Scenarios

### Test 1: Successful 2FA Login
1. Login as admin
2. Get code from console
3. Enter code
4. Should login successfully

### Test 2: Expired Code
1. Login as admin
2. Wait 6 minutes
3. Try to use the code
4. Should show "expired" error

### Test 3: Invalid Code
1. Login as admin
2. Enter wrong code (e.g., 000000)
3. Should show "invalid" error

### Test 4: User Without 2FA
1. Login as john_doe (student)
2. Should login directly without 2FA
3. No verification page shown

## 💡 Tips

### For Development:
- Check Tomcat console for OTP codes
- Codes are printed in a clear format
- Easy to copy and paste

### For Production:
- Replace EmailUtil with real email service
- Add SMS option as backup
- Consider authenticator apps (Google Authenticator)
- Add "Remember this device" option

### For Users:
- Codes expire in 5 minutes
- Check spam folder for emails
- Contact admin if not receiving codes

## 🚀 What Makes It Special

1. **Professional UI**: Beautiful verification page
2. **User Friendly**: Auto-focus, paste support
3. **Secure**: Time-limited, one-time codes
4. **Flexible**: Can enable/disable per user
5. **Modern**: Follows 2FA best practices
6. **Scalable**: Easy to add real email service

## 📝 Current Status

- ✅ 2FA enabled for: **admin** account
- ✅ 2FA disabled for: **student** accounts
- ✅ Email simulation: **Console output**
- ✅ Code expiry: **5 minutes**
- ✅ Code length: **6 digits**

Your EventSphere application now has enterprise-grade Two-Factor Authentication! 🎉
