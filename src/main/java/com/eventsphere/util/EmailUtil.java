package com.eventsphere.util;

/**
 * Email utility for sending OTP codes
 * NOTE: This is a SIMULATED email service for demonstration purposes.
 * In production, you would integrate with a real email service like:
 * - JavaMail API with SMTP
 * - SendGrid
 * - AWS SES
 * - Mailgun
 */
public class EmailUtil {
    
    /**
     * Simulate sending OTP email
     * In production, this would actually send an email
     */
    public static boolean sendOTPEmail(String email, String otp) {
        // Simulate email sending
        System.out.println("===========================================");
        System.out.println("📧 SIMULATED EMAIL SENT");
        System.out.println("===========================================");
        System.out.println("To: " + email);
        System.out.println("Subject: Your EventSphere Login Code");
        System.out.println("-------------------------------------------");
        System.out.println("Your verification code is: " + otp);
        System.out.println("This code will expire in 5 minutes.");
        System.out.println("===========================================");
        
        // In production, replace with actual email sending logic:
        /*
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("your-email@gmail.com", "your-password");
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("noreply@eventsphere.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Your EventSphere Login Code");
            message.setText("Your verification code is: " + otp + "\n\nThis code will expire in 5 minutes.");
            
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
        */
        
        return true; // Simulate success
    }
}
