package com.eventsphere.controller;

import com.eventsphere.dao.UserDAO;
import com.eventsphere.model.User;
import com.eventsphere.util.OTPUtil;
import com.eventsphere.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ResetPasswordServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("error", "Verification code is required");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (newPassword == null || newPassword.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }
        
        try {
            // Get user by email
            User user = userDAO.getUserByEmail(email);
            
            if (user == null) {
                request.setAttribute("error", "Invalid email address");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }
            
            // Validate verification code
            if (!OTPUtil.validateOTP(code, user.getTwoFactorCode(), user.getTwoFactorExpiry())) {
                request.setAttribute("error", "Invalid or expired verification code");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }
            
            // Hash new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            
            // Update password in database
            boolean updated = userDAO.updatePassword(user.getId(), hashedPassword);
            
            if (updated) {
                // Clear verification code
                userDAO.clearTwoFactorCode(user.getId());
                
                request.setAttribute("success", "Password reset successful! Redirecting to login...");
                
                // Redirect to login page after 2 seconds
                response.setHeader("Refresh", "2; URL=" + request.getContextPath() + "/login.jsp");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to update password. Please try again.");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        }
    }
}
