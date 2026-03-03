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
        } else if ("broadcast".equals(action)) {
            sendBroadcastMessage(request, response);
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
            
            List<ChatMessage> messages;
            
            // If otherUserId is 0, return only broadcast messages
            if (otherUserId == 0) {
                messages = chatDAO.getBroadcastMessages(50);
            } else {
                // Return conversation between two users + broadcast messages
                messages = chatDAO.getConversation(userId, otherUserId, 50);
            }
            
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
        
        System.out.println("=== SEND MESSAGE REQUEST ===");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            System.out.println("Session: " + session);
            
            if (session == null) {
                System.out.println("ERROR: No session!");
                PrintWriter out = response.getWriter();
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("error", "No session");
                String json = gson.toJson(result);
                System.out.println("JSON response: " + json);
                out.print(json);
                out.flush();
                return;
            }
            
            int senderId = (Integer) session.getAttribute("userId");
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
            String message = request.getParameter("message");
            System.out.println("Sender ID: " + senderId + ", Receiver ID: " + receiverId + ", Message: " + message);
            
            ChatMessage chatMessage = chatDAO.sendMessage(senderId, receiverId, message);
            System.out.println("Chat message created: " + (chatMessage != null));
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", chatMessage != null);
            result.put("message", chatMessage);
            
            String json = gson.toJson(result);
            System.out.println("JSON response: " + json);
            
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
            System.out.println("Response sent successfully");
        } catch (Exception e) {
            System.out.println("ERROR in sendMessage:");
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("error", "Error sending message: " + e.getMessage());
            String json = gson.toJson(result);
            System.out.println("Error JSON response: " + json);
            out.print(json);
            out.flush();
        }
    }

    private void sendBroadcastMessage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        System.out.println("=== BROADCAST MESSAGE REQUEST ===");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            System.out.println("Session: " + session);
            
            if (session == null) {
                System.out.println("ERROR: No session!");
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("error", "No session");
                out.print(gson.toJson(result));
                out.flush();
                return;
            }
            
            int senderId = (Integer) session.getAttribute("userId");
            String role = (String) session.getAttribute("role");
            System.out.println("Sender ID: " + senderId + ", Role: " + role);
            
            // Only admins can send broadcast messages
            if (!"ADMIN".equals(role)) {
                System.out.println("ERROR: Not admin!");
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("error", "Only admins can send broadcast messages");
                out.print(gson.toJson(result));
                out.flush();
                return;
            }
            
            String message = request.getParameter("message");
            System.out.println("Message: " + message);
            
            ChatMessage chatMessage = chatDAO.sendBroadcastMessage(senderId, message);
            System.out.println("Chat message created: " + (chatMessage != null));
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", chatMessage != null);
            result.put("message", chatMessage);
            
            String json = gson.toJson(result);
            System.out.println("JSON response: " + json);
            out.print(json);
            out.flush();
            System.out.println("Response sent successfully");
        } catch (Exception e) {
            System.out.println("ERROR in sendBroadcastMessage:");
            e.printStackTrace();
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("error", "Error sending broadcast: " + e.getMessage());
            out.print(gson.toJson(result));
            out.flush();
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
