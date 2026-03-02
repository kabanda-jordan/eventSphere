package com.eventsphere.dao;

import com.eventsphere.model.Registration;
import com.eventsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO {

    public Registration createRegistration(int studentId, int eventId) throws SQLException {
        String sql = "INSERT INTO registrations (student_id, event_id, status) VALUES (?, ?, 'REGISTERED')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, eventId);
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        Registration registration = new Registration();
                        registration.setId(generatedKeys.getInt(1));
                        registration.setStudentId(studentId);
                        registration.setEventId(eventId);
                        registration.setStatus("REGISTERED");
                        return registration;
                    }
                }
            }
        }
        return null;
    }

    public boolean isStudentRegistered(int studentId, int eventId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM registrations WHERE student_id = ? AND event_id = ? AND status = 'REGISTERED'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, eventId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public int getEventRegistrationCount(int eventId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM registrations WHERE event_id = ? AND status = 'REGISTERED'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, eventId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<Registration> getStudentRegistrations(int studentId) throws SQLException {
        List<Registration> registrations = new ArrayList<>();
        String sql = "SELECT r.*, e.title as event_title " +
                     "FROM registrations r " +
                     "JOIN events e ON r.event_id = e.id " +
                     "WHERE r.student_id = ? " +
                     "ORDER BY r.registered_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Registration registration = extractRegistrationFromResultSet(rs);
                    registration.setEventTitle(rs.getString("event_title"));
                    registrations.add(registration);
                }
            }
        }
        return registrations;
    }

    public List<Registration> getEventRegistrations(int eventId) throws SQLException {
        List<Registration> registrations = new ArrayList<>();
        String sql = "SELECT r.*, s.full_name as student_name " +
                     "FROM registrations r " +
                     "JOIN students s ON r.student_id = s.id " +
                     "WHERE r.event_id = ? " +
                     "ORDER BY r.registered_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, eventId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Registration registration = extractRegistrationFromResultSet(rs);
                    registration.setStudentName(rs.getString("student_name"));
                    registrations.add(registration);
                }
            }
        }
        return registrations;
    }

    public boolean cancelRegistration(int studentId, int eventId) throws SQLException {
        String sql = "UPDATE registrations SET status = 'CANCELLED' WHERE student_id = ? AND event_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, eventId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteRegistration(int id) throws SQLException {
        String sql = "DELETE FROM registrations WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private Registration extractRegistrationFromResultSet(ResultSet rs) throws SQLException {
        Registration registration = new Registration();
        registration.setId(rs.getInt("id"));
        registration.setStudentId(rs.getInt("student_id"));
        registration.setEventId(rs.getInt("event_id"));
        registration.setRegisteredAt(rs.getTimestamp("registered_at"));
        registration.setStatus(rs.getString("status"));
        return registration;
    }
}
