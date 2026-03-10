package com.eventsphere.controller;

import com.eventsphere.dao.UserDAO;
import com.eventsphere.model.User;
import com.eventsphere.util.EmailUtil;
import com.eventsphere.util.OTPUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Please enter your email address");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check if user exists with this email
            User user = userDAO.getUserByEmail(email);
            
            if (user == null) {
                // Don't reveal if email exists or not (security best practice)
                request.setAttribute("success", "If this email is registered, you will receive a verification code shortly.");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                return;
            }
            
            // Generate 6-digit verification code
            String verificationCode = OTPUtil.generateOTP();
            
            // Store code in database with expiry (5 minutes)
            userDAO.updateTwoFactorCode(user.getId(), verificationCode, OTPUtil.getOTPExpiry());
            
            // Send verification code via email
            boolean emailSent = sendPasswordResetEmail(user.getEmail(), verificationCode);
            
            if (emailSent) {
                // Store email in session for reset page
                HttpSession session = request.getSession();
                session.setAttribute("resetEmail", email);
                
                request.setAttribute("success", "Verification code sent to your email! Check your inbox.");
                
                // Redirect to reset password page after 2 seconds
                response.setHeader("Refresh", "2; URL=" + request.getContextPath() + "/reset-password.jsp");
            } else {
                request.setAttribute("error", "Failed to send email. Please try again.");
            }
            
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }
    
    private boolean sendPasswordResetEmail(String email, String code) {
        try {
            // Use EmailUtil to send the code
            return EmailUtil.sendPasswordResetEmail(email, code);
        } catch (Exception e) {
            System.err.println("Failed to send password reset email: " + e.getMessage());
            return false;
        }
    }
}
