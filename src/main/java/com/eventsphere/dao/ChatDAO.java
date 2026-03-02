package com.eventsphere.dao;

import com.eventsphere.model.ChatMessage;
import com.eventsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDAO {

    public ChatMessage sendMessage(int senderId, int receiverId, String message) throws SQLException {
        String sql = "INSERT INTO chat_messages (sender_id, receiver_id, message) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.setString(3, message);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        ChatMessage chatMessage = new ChatMessage();
                        chatMessage.setId(generatedKeys.getInt(1));
                        chatMessage.setSenderId(senderId);
                        chatMessage.setReceiverId(receiverId);
                        chatMessage.setMessage(message);
                        return chatMessage;
                    }
                }
            }
        }
        return null;
    }

    public List<ChatMessage> getConversation(int userId1, int userId2, int limit) throws SQLException {
        List<ChatMessage> messages = new ArrayList<>();
        String sql = "SELECT cm.*, " +
                     "u1.username as sender_username, " +
                     "u2.username as receiver_username " +
                     "FROM chat_messages cm " +
                     "JOIN users u1 ON cm.sender_id = u1.id " +
                     "JOIN users u2 ON cm.receiver_id = u2.id " +
                     "WHERE (cm.sender_id = ? AND cm.receiver_id = ?) " +
                     "OR (cm.sender_id = ? AND cm.receiver_id = ?) " +
                     "ORDER BY cm.sent_at DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);
            stmt.setInt(5, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(extractChatMessageFromResultSet(rs));
                }
            }
        }
        
        // Reverse to show oldest first
        List<ChatMessage> reversed = new ArrayList<>();
        for (int i = messages.size() - 1; i >= 0; i--) {
            reversed.add(messages.get(i));
        }
        return reversed;
    }

    public List<ChatMessage> getRecentChats(int userId) throws SQLException {
        List<ChatMessage> messages = new ArrayList<>();
        String sql = "SELECT cm.*, " +
                     "u1.username as sender_username, " +
                     "u2.username as receiver_username " +
                     "FROM chat_messages cm " +
                     "JOIN users u1 ON cm.sender_id = u1.id " +
                     "JOIN users u2 ON cm.receiver_id = u2.id " +
                     "WHERE cm.id IN ( " +
                     "  SELECT MAX(id) FROM chat_messages " +
                     "  WHERE sender_id = ? OR receiver_id = ? " +
                     "  GROUP BY LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id) " +
                     ") " +
                     "ORDER BY cm.sent_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    messages.add(extractChatMessageFromResultSet(rs));
                }
            }
        }
        return messages;
    }

    public int getUnreadCount(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM chat_messages WHERE receiver_id = ? AND is_read = FALSE";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public boolean markAsRead(int senderId, int receiverId) throws SQLException {
        String sql = "UPDATE chat_messages SET is_read = TRUE " +
                     "WHERE sender_id = ? AND receiver_id = ? AND is_read = FALSE";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            
            stmt.executeUpdate();
            return true;
        }
    }

    private ChatMessage extractChatMessageFromResultSet(ResultSet rs) throws SQLException {
        ChatMessage message = new ChatMessage();
        message.setId(rs.getInt("id"));
        message.setSenderId(rs.getInt("sender_id"));
        message.setReceiverId(rs.getInt("receiver_id"));
        message.setMessage(rs.getString("message"));
        message.setSentAt(rs.getTimestamp("sent_at"));
        message.setRead(rs.getBoolean("is_read"));
        message.setSenderUsername(rs.getString("sender_username"));
        message.setReceiverUsername(rs.getString("receiver_username"));
        return message;
    }
}
