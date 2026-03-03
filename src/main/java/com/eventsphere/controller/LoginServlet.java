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

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("verify2fa".equals(action)) {
            verify2FA(request, response);
        } else {
            login(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captchaInput = request.getParameter("captcha");
        
        HttpSession session = request.getSession();
        String actualCaptcha = (String) session.getAttribute("captcha");
        
        // Verify CAPTCHA first
        if (captchaInput == null || actualCaptcha == null || !captchaInput.trim().equalsIgnoreCase(actualCaptcha)) {
            request.setAttribute("error", "Invalid CAPTCHA. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Clear CAPTCHA from session after verification
        session.removeAttribute("captcha");

        try {
            User user = userDAO.authenticate(username, password);
            
            if (user != null) {
                // 2FA is REQUIRED for ALL users (both ADMIN and STUDENT)
                // Generate and send OTP
                String otp = OTPUtil.generateOTP();
                userDAO.updateTwoFactorCode(user.getId(), otp, OTPUtil.getOTPExpiry());
                
                // Send OTP via email (simulated - check console for code)
                EmailUtil.sendOTPEmail(user.getEmail(), otp);
                
                // Store user ID in session temporarily
                session.setAttribute("pending2FAUserId", user.getId());
                session.setAttribute("pending2FAUsername", user.getUsername());
                
                // Redirect to 2FA verification page
                response.sendRedirect(request.getContextPath() + "/verify-2fa.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void verify2FA(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("pending2FAUserId");
        String inputOTP = request.getParameter("otp");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            User user = userDAO.getUserById(userId);
            
            if (user != null && OTPUtil.validateOTP(inputOTP, user.getTwoFactorCode(), user.getTwoFactorExpiry())) {
                // OTP is valid, clear it and create session
                userDAO.clearTwoFactorCode(userId);
                
                // Remove pending attributes
                session.removeAttribute("pending2FAUserId");
                session.removeAttribute("pending2FAUsername");
                
                // Create full session
                createSession(request, user);
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("error", "Invalid or expired verification code");
                request.getRequestDispatcher("/verify-2fa.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/verify-2fa.jsp").forward(request, response);
        }
    }

    private void createSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute("userId", user.getId());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());
        session.setMaxInactiveInterval(30 * 60);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
