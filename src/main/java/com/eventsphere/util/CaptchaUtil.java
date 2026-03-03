package com.eventsphere.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Random;

public class CaptchaUtil {
    
    private static final String CAPTCHA_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final int CAPTCHA_LENGTH = 6;
    private static final int WIDTH = 200;
    private static final int HEIGHT = 60;
    
    /**
     * Generate a random CAPTCHA text
     */
    public static String generateCaptchaText() {
        Random random = new Random();
        StringBuilder captcha = new StringBuilder();
        
        for (int i = 0; i < CAPTCHA_LENGTH; i++) {
            captcha.append(CAPTCHA_CHARS.charAt(random.nextInt(CAPTCHA_CHARS.length())));
        }
        
        return captcha.toString();
    }
    
    /**
     * Generate CAPTCHA image as Base64 string
     */
    public static String generateCaptchaImage(String captchaText) {
        try {
            BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = image.createGraphics();
            
            // Set rendering hints for better quality
            g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
            
            Random random = new Random();
            
            // Background with gradient
            GradientPaint gradient = new GradientPaint(
                0, 0, new Color(99, 102, 241),
                WIDTH, HEIGHT, new Color(139, 92, 246)
            );
            g2d.setPaint(gradient);
            g2d.fillRect(0, 0, WIDTH, HEIGHT);
            
            // Add noise lines
            g2d.setColor(new Color(255, 255, 255, 100));
            for (int i = 0; i < 8; i++) {
                int x1 = random.nextInt(WIDTH);
                int y1 = random.nextInt(HEIGHT);
                int x2 = random.nextInt(WIDTH);
                int y2 = random.nextInt(HEIGHT);
                g2d.setStroke(new BasicStroke(2));
                g2d.drawLine(x1, y1, x2, y2);
            }
            
            // Add noise dots
            for (int i = 0; i < 50; i++) {
                int x = random.nextInt(WIDTH);
                int y = random.nextInt(HEIGHT);
                g2d.fillOval(x, y, 2, 2);
            }
            
            // Draw CAPTCHA text
            g2d.setColor(Color.WHITE);
            Font font = new Font("Arial", Font.BOLD, 32);
            g2d.setFont(font);
            
            int x = 15;
            for (int i = 0; i < captchaText.length(); i++) {
                // Random rotation for each character
                double angle = (random.nextDouble() - 0.5) * 0.4;
                g2d.rotate(angle, x + 15, HEIGHT / 2);
                
                // Random y position
                int y = HEIGHT / 2 + random.nextInt(10) - 5;
                
                g2d.drawString(String.valueOf(captchaText.charAt(i)), x, y + 10);
                
                // Reset rotation
                g2d.rotate(-angle, x + 15, HEIGHT / 2);
                
                x += 28;
            }
            
            g2d.dispose();
            
            // Convert to Base64
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(image, "png", baos);
            byte[] imageBytes = baos.toByteArray();
            return Base64.getEncoder().encodeToString(imageBytes);
            
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Verify CAPTCHA input
     */
    public static boolean verifyCaptcha(String userInput, String actualCaptcha) {
        if (userInput == null || actualCaptcha == null) {
            return false;
        }
        return userInput.trim().equalsIgnoreCase(actualCaptcha.trim());
    }
}
