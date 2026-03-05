package com.eventsphere.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Email utility for sending OTP codes via Gmail SMTP
 */
public class EmailUtil {
    
    private static Properties emailConfig;
    
    static {
        emailConfig = new Properties();
        try (InputStream input = EmailUtil.class.getClassLoader().getResourceAsStream("email.properties")) {
            if (input != null) {
                emailConfig.load(input);
            } else {
                System.err.println("WARNING: email.properties not found. Email sending will fail.");
            }
        } catch (IOException e) {
            System.err.println("ERROR: Failed to load email.properties: " + e.getMessage());
        }
    }
    
    /**
     * Send OTP email via Gmail SMTP
     */
    public static boolean sendOTPEmail(String toEmail, String otp) {
        String fromEmail = emailConfig.getProperty("mail.from.email");
        String fromName = emailConfig.getProperty("mail.from.name", "EventSphere");
        String password = emailConfig.getProperty("mail.smtp.password");
        
        // Validate configuration
        if (fromEmail == null || password == null || 
            fromEmail.equals("your-email@gmail.com") || 
            password.equals("your-app-password-here")) {
            
            System.err.println("===========================================");
            System.err.println("⚠️  EMAIL NOT CONFIGURED");
            System.err.println("===========================================");
            System.err.println("Please configure email.properties with:");
            System.err.println("1. Your Gmail address");
            System.err.println("2. Your Gmail App Password");
            System.err.println("-------------------------------------------");
            System.err.println("For now, showing OTP in console:");
            System.err.println("To: " + toEmail);
            System.err.println("OTP Code: " + otp);
            System.err.println("===========================================");
            return true; // Return true to not block login
        }
        
        try {
            // Setup mail server properties
            Properties props = new Properties();
            props.put("mail.smtp.host", emailConfig.getProperty("mail.smtp.host"));
            props.put("mail.smtp.port", emailConfig.getProperty("mail.smtp.port"));
            props.put("mail.smtp.auth", emailConfig.getProperty("mail.smtp.auth"));
            props.put("mail.smtp.starttls.enable", emailConfig.getProperty("mail.smtp.starttls.enable"));
            
            // Create session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });
            
            // Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, fromName));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(emailConfig.getProperty("mail.otp.subject", "Your EventSphere Login Code"));
            
            // Create HTML email body
            String htmlBody = "<!DOCTYPE html>" +
                "<html>" +
                "<head><style>" +
                "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }" +
                ".container { background-color: white; padding: 30px; border-radius: 10px; max-width: 600px; margin: 0 auto; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }" +
                ".header { text-align: center; color: #667eea; margin-bottom: 30px; }" +
                ".otp-code { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; font-size: 32px; font-weight: bold; padding: 20px; text-align: center; border-radius: 8px; letter-spacing: 8px; margin: 20px 0; }" +
                ".message { color: #333; line-height: 1.6; margin: 20px 0; }" +
                ".footer { text-align: center; color: #999; font-size: 12px; margin-top: 30px; }" +
                "</style></head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'><h1>🎯 EventSphere</h1></div>" +
                "<div class='message'>" +
                "<p>Hello,</p>" +
                "<p>You requested to log in to your EventSphere account. Please use the verification code below:</p>" +
                "</div>" +
                "<div class='otp-code'>" + otp + "</div>" +
                "<div class='message'>" +
                "<p><strong>This code will expire in 5 minutes.</strong></p>" +
                "<p>If you didn't request this code, please ignore this email.</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>© 2024 EventSphere. All rights reserved.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
            
            message.setContent(htmlBody, "text/html; charset=utf-8");
            
            // Send email
            Transport.send(message);
            
            System.out.println("✅ Email sent successfully to: " + toEmail);
            return true;
            
        } catch (MessagingException | IOException e) {
            System.err.println("❌ Failed to send email to: " + toEmail);
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            
            // Fallback: Show OTP in console
            System.err.println("-------------------------------------------");
            System.err.println("FALLBACK - OTP Code: " + otp);
            System.err.println("-------------------------------------------");
            
            return false;
        }
    }
}
