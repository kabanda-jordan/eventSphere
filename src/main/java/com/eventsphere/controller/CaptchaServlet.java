package com.eventsphere.controller;

import com.eventsphere.util.CaptchaUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

public class CaptchaServlet extends HttpServlet {
    
    private static final String CAPTCHA_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    private static final int CAPTCHA_LENGTH = 6;
    private static final int WIDTH = 200;
    private static final int HEIGHT = 60;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Generate new CAPTCHA text
        String captchaText = generateCaptchaText();
        
        // Store CAPTCHA in session
        session.setAttribute("captcha", captchaText);
        
        // Set response headers for image
        response.setContentType("image/png");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        // Generate and write image directly to response
        BufferedImage image = generateCaptchaImage(captchaText);
        ImageIO.write(image, "png", response.getOutputStream());
    }
    
    /**
     * Generate a random CAPTCHA text
     */
    private String generateCaptchaText() {
        Random random = new Random();
        StringBuilder captcha = new StringBuilder();
        
        for (int i = 0; i < CAPTCHA_LENGTH; i++) {
            captcha.append(CAPTCHA_CHARS.charAt(random.nextInt(CAPTCHA_CHARS.length())));
        }
        
        return captcha.toString();
    }
    
    /**
     * Generate CAPTCHA image
     */
    private BufferedImage generateCaptchaImage(String captchaText) {
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = image.createGraphics();
        
        // Set rendering hints for better quality
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        
        Random random = new Random();
        
        // Background with gradient (using new design colors)
        GradientPaint gradient = new GradientPaint(
            0, 0, new Color(99, 102, 241),      // Deep Indigo
            WIDTH, HEIGHT, new Color(168, 85, 247)  // Purple
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
        return image;
    }
}
