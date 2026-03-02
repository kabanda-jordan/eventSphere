package com.eventsphere.controller;

import com.eventsphere.dao.ChatDAO;
import com.eventsphere.dao.UserDAO;
import com.eventsphere.model.ChatMessage;
import com.eventsphere.model.User;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatServlet extends HttpServlet {
    private ChatDAO chatDAO;
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        chatDAO = new ChatDAO();
        userDAO = new UserDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("page".equals(action)) {
            showChatPage(request, response);
        } else if ("messages".equals(action)) {
            getMessages(request, response);
        } else if ("unread".equals(action)) {
            getUnreadCount(request, response);
        } else {
            showChatPage(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("send".equals(action)) {
            sendMessage(request, response);
        } else if ("markRead".equals(action)) {
            markAsRead(request, response);
        }
    }

    private void showChatPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession(false);
            int userId = (Integer) session.getAttribute("userId");
            
            // Get all users except the current user
            List<User> users = userDAO.getAllUsers();
            users.removeIf(u -> u.getId() == userId);
            
            request.setAttribute("users", users);
            request.getRequestDispatcher("/chat.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading chat");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void getMessages(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            int userId = (Integer) session.getAttribute("userId");
            int otherUserId = Integer.parseInt(request.getParameter("userId"));
            
            List<ChatMessage> messages = chatDAO.getConversation(userId, otherUserId, 50);
            
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(messages));
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void sendMessage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            int senderId = (Integer) session.getAttribute("userId");
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
            String message = request.getParameter("message");
            
            ChatMessage chatMessage = chatDAO.sendMessage(senderId, receiverId, message);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", chatMessage != null);
            result.put("message", chatMessage);
            
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(result));
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void markAsRead(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            int userId = (Integer) session.getAttribute("userId");
            int senderId = Integer.parseInt(request.getParameter("senderId"));
            
            boolean success = chatDAO.markAsRead(senderId, userId);
            
            Map<String, Boolean> result = new HashMap<>();
            result.put("success", success);
            
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(result));
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void getUnreadCount(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            int userId = (Integer) session.getAttribute("userId");
            
            int count = chatDAO.getUnreadCount(userId);
            
            Map<String, Integer> result = new HashMap<>();
            result.put("count", count);
            
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(result));
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
