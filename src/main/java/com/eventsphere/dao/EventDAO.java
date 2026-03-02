package com.eventsphere.dao;

import com.eventsphere.model.Event;
import com.eventsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public Event createEvent(Event event) throws SQLException {
        String sql = "INSERT INTO events (title, description, event_date, location, capacity, created_by, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setTimestamp(3, event.getEventDate());
            stmt.setString(4, event.getLocation());
            stmt.setInt(5, event.getCapacity());
            stmt.setInt(6, event.getCreatedBy());
            stmt.setString(7, event.getStatus());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        event.setId(generatedKeys.getInt(1));
                        return event;
                    }
                }
            }
        }
        return null;
    }

    public Event getEventById(int id) throws SQLException {
        String sql = "SELECT e.*, COUNT(r.id) as registered_count " +
                     "FROM events e " +
                     "LEFT JOIN registrations r ON e.id = r.event_id AND r.status = 'REGISTERED' " +
                     "WHERE e.id = ? " +
                     "GROUP BY e.id";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractEventFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public List<Event> getAllEvents() throws SQLException {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, COUNT(r.id) as registered_count " +
                     "FROM events e " +
                     "LEFT JOIN registrations r ON e.id = r.event_id AND r.status = 'REGISTERED' " +
                     "GROUP BY e.id " +
                     "ORDER BY e.event_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        }
        return events;
    }

    public List<Event> getActiveEvents() throws SQLException {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, COUNT(r.id) as registered_count " +
                     "FROM events e " +
                     "LEFT JOIN registrations r ON e.id = r.event_id AND r.status = 'REGISTERED' " +
                     "WHERE e.status = 'ACTIVE' " +
                     "GROUP BY e.id " +
                     "ORDER BY e.event_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                events.add(extractEventFromResultSet(rs));
            }
        }
        return events;
    }

    public boolean updateEvent(Event event) throws SQLException {
        String sql = "UPDATE events SET title = ?, description = ?, event_date = ?, " +
                     "location = ?, capacity = ?, status = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setTimestamp(3, event.getEventDate());
            stmt.setString(4, event.getLocation());
            stmt.setInt(5, event.getCapacity());
            stmt.setString(6, event.getStatus());
            stmt.setInt(7, event.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteEvent(int id) throws SQLException {
        String sql = "DELETE FROM events WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Event> searchEvents(String keyword) throws SQLException {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT e.*, COUNT(r.id) as registered_count " +
                     "FROM events e " +
                     "LEFT JOIN registrations r ON e.id = r.event_id AND r.status = 'REGISTERED' " +
                     "WHERE e.title LIKE ? OR e.description LIKE ? OR e.location LIKE ? " +
                     "GROUP BY e.id " +
                     "ORDER BY e.event_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    events.add(extractEventFromResultSet(rs));
                }
            }
        }
        return events;
    }

    private Event extractEventFromResultSet(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setId(rs.getInt("id"));
        event.setTitle(rs.getString("title"));
        event.setDescription(rs.getString("description"));
        event.setEventDate(rs.getTimestamp("event_date"));
        event.setLocation(rs.getString("location"));
        event.setCapacity(rs.getInt("capacity"));
        event.setCreatedBy(rs.getInt("created_by"));
        event.setCreatedAt(rs.getTimestamp("created_at"));
        event.setStatus(rs.getString("status"));
        event.setRegisteredCount(rs.getInt("registered_count"));
        return event;
    }
}
