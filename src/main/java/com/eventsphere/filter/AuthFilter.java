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
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Public pages (no authentication required)
        String loginURI = contextPath + "/login.jsp";
        String registerURI = contextPath + "/register.jsp";
        String loginServlet = contextPath + "/login";
        String registerServlet = contextPath + "/register";
        String indexURI = contextPath + "/index.jsp";
        String rootURI = contextPath + "/";
        String captchaServlet = contextPath + "/captcha";
        String diagnosticURI = contextPath + "/diagnostic.jsp";
        String testDbURI = contextPath + "/test-db-connection.jsp";
        String testPasswordURI = contextPath + "/test-password.jsp";
        String fixPasswordURI = contextPath + "/fix-passwords.jsp";
        String checkPasswordURI = contextPath + "/check-passwords.jsp";
        String verify2FAURI = contextPath + "/verify-2fa.jsp";
        String setup2FAURI = contextPath + "/setup-2fa.jsp";
        String enable2FAURI = contextPath + "/enable-2fa-now.jsp";
        
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);
        
        // Check if request is for public resources
        boolean isPublicResource = requestURI.equals(loginURI) || 
                                   requestURI.equals(loginServlet) ||
                                   requestURI.equals(registerURI) || 
                                   requestURI.equals(registerServlet) ||
                                   requestURI.equals(indexURI) ||
                                   requestURI.equals(rootURI) ||
                                   requestURI.equals(contextPath) ||
                                   requestURI.equals(captchaServlet) ||
                                   requestURI.equals(diagnosticURI) ||
                                   requestURI.equals(testDbURI) ||
                                   requestURI.equals(testPasswordURI) ||
                                   requestURI.equals(fixPasswordURI) ||
                                   requestURI.equals(checkPasswordURI) ||
                                   requestURI.equals(verify2FAURI) ||
                                   requestURI.equals(setup2FAURI) ||
                                   requestURI.equals(enable2FAURI) ||
                                   requestURI.startsWith(contextPath + "/css/") ||
                                   requestURI.startsWith(contextPath + "/js/") ||
                                   requestURI.startsWith(contextPath + "/images/") ||
                                   requestURI.endsWith(".css") ||
                                   requestURI.endsWith(".js") ||
                                   requestURI.endsWith(".png") ||
                                   requestURI.endsWith(".jpg") ||
                                   requestURI.endsWith(".jpeg") ||
                                   requestURI.endsWith(".gif") ||
                                   requestURI.endsWith(".svg") ||
                                   requestURI.endsWith(".ico");
        
        if (loggedIn || isPublicResource) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
    }
}
