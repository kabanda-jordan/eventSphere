package com.eventsphere.controller;

import com.eventsphere.util.CaptchaUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

public class CaptchaServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Generate new CAPTCHA
        String captchaText = CaptchaUtil.generateCaptchaText();
        String captchaImage = CaptchaUtil.generateCaptchaImage(captchaText);
        
        // Store CAPTCHA in session
        session.setAttribute("captcha", captchaText);
        
        // Return as JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.print("{\"image\":\"data:image/png;base64," + captchaImage + "\"}");
        out.flush();
    }
}
