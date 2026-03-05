# 📧 Email Setup Guide for EventSphere 2FA

## Overview
EventSphere now sends real 2FA codes via Gmail SMTP instead of printing to the console.

## Setup Steps

### Step 1: Enable 2-Step Verification on Gmail
1. Go to your Google Account: https://myaccount.google.com/
2. Click on "Security" in the left sidebar
3. Under "Signing in to Google", click on "2-Step Verification"
4. Follow the prompts to enable 2-Step Verification
5. You MUST enable this before you can create App Passwords

### Step 2: Generate Gmail App Password
1. Go to: https://myaccount.google.com/apppasswords
2. You may need to sign in again
3. In the "Select app" dropdown, choose "Mail"
4. In the "Select device" dropdown, choose "Other (Custom name)"
5. Type "EventSphere" as the name
6. Click "Generate"
7. Google will show you a 16-character password (like: `abcd efgh ijkl mnop`)
8. **COPY THIS PASSWORD** - you won't be able to see it again!

### Step 3: Configure EventSphere
1. Open the file: `src/main/resources/email.properties`
2. Replace `your-email@gmail.com` with your actual Gmail address
3. Replace `your-app-password-here` with the 16-character App Password (remove spaces)

Example:
```properties
mail.from.email=kabanda.jordan@gmail.com
mail.smtp.password=abcdefghijklmnop
```

### Step 4: Rebuild and Deploy
1. Stop Tomcat if running
2. Run: `mvn clean package`
3. Copy the WAR file to Tomcat's webapps folder
4. Start Tomcat
5. Test login - you should receive an email with the OTP code!

## Testing

1. Go to the login page
2. Enter username and password
3. Complete the CAPTCHA
4. Click "Login"
5. Check the email inbox for the user's email address
6. You should receive an email with subject "Your EventSphere Login Code"
7. Enter the 6-digit code on the verification page

## Troubleshooting

### Email Not Received?
- Check spam/junk folder
- Verify the email address in the database is correct
- Check Tomcat console for error messages
- Verify App Password is correct (no spaces)
- Make sure 2-Step Verification is enabled on Gmail

### "EMAIL NOT CONFIGURED" Warning?
- Make sure you edited `email.properties` with your actual credentials
- Rebuild the project with `mvn clean package`
- Redeploy to Tomcat

### Authentication Failed?
- Double-check the App Password (not your regular Gmail password!)
- Make sure there are no spaces in the password
- Try generating a new App Password

### Still Not Working?
- Check Tomcat logs: `C:\Program Files\Apache Software Foundation\Tomcat 11.0\logs\catalina.out`
- Look for error messages starting with "❌ Failed to send email"
- The OTP will be printed to console as a fallback

## Security Notes

⚠️ **IMPORTANT SECURITY TIPS:**

1. **Never commit email.properties with real credentials to Git!**
   - Add it to .gitignore
   - Use environment variables in production

2. **App Passwords are sensitive**
   - Treat them like regular passwords
   - Don't share them
   - Revoke them if compromised

3. **For Production:**
   - Use environment variables instead of properties file
   - Consider using a dedicated email service (SendGrid, AWS SES)
   - Implement rate limiting to prevent abuse

## Email Template

Users will receive a beautiful HTML email with:
- EventSphere branding
- Large, easy-to-read OTP code
- Expiration warning (5 minutes)
- Professional styling with gradient colors

## Support

If you need help:
1. Check the Tomcat console for detailed error messages
2. Verify all setup steps were completed
3. Test with a different Gmail account
4. Make sure your Gmail account is not restricted

---

**Ready to test?** Follow the setup steps above and try logging in!
