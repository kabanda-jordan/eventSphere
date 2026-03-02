package com.eventsphere.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        
        String loginURI = httpRequest.getContextPath() + "/login.jsp";
        String registerURI = httpRequest.getContextPath() + "/register.jsp";
        String loginServlet = httpRequest.getContextPath() + "/login";
        String registerServlet = httpRequest.getContextPath() + "/register";
        String diagnosticURI = httpRequest.getContextPath() + "/diagnostic.jsp";
        String testDbURI = httpRequest.getContextPath() + "/test-db-connection.jsp";
        String testPasswordURI = httpRequest.getContextPath() + "/test-password.jsp";
        String fixPasswordURI = httpRequest.getContextPath() + "/fix-passwords.jsp";
        String checkPasswordURI = httpRequest.getContextPath() + "/check-passwords.jsp";
        String verify2FAURI = httpRequest.getContextPath() + "/verify-2fa.jsp";
        String setup2FAURI = httpRequest.getContextPath() + "/setup-2fa.jsp";
        String enable2FAURI = httpRequest.getContextPath() + "/enable-2fa-now.jsp";
        
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);
        boolean loginRequest = httpRequest.getRequestURI().equals(loginURI) || 
                                httpRequest.getRequestURI().equals(loginServlet);
        boolean registerRequest = httpRequest.getRequestURI().equals(registerURI) || 
                                   httpRequest.getRequestURI().equals(registerServlet);
        boolean diagnosticRequest = httpRequest.getRequestURI().equals(diagnosticURI) ||
                                    httpRequest.getRequestURI().equals(testDbURI) ||
                                    httpRequest.getRequestURI().equals(testPasswordURI) ||
                                    httpRequest.getRequestURI().equals(fixPasswordURI) ||
                                    httpRequest.getRequestURI().equals(checkPasswordURI) ||
                                    httpRequest.getRequestURI().equals(verify2FAURI) ||
                                    httpRequest.getRequestURI().equals(setup2FAURI) ||
                                    httpRequest.getRequestURI().equals(enable2FAURI);
        
        if (loggedIn || loginRequest || registerRequest || diagnosticRequest) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
    }
}
