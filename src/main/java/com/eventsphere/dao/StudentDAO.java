package com.eventsphere.dao;

import com.eventsphere.model.Student;
import com.eventsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public Student createStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (user_id, full_name, department, year, phone) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, student.getUserId());
            stmt.setString(2, student.getFullName());
            stmt.setString(3, student.getDepartment());
            stmt.setInt(4, student.getYear());
            stmt.setString(5, student.getPhone());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        student.setId(generatedKeys.getInt(1));
                        return student;
                    }
                }
            }
        }
        return null;
    }

    public Student getStudentById(int id) throws SQLException {
        String sql = "SELECT s.*, u.username, u.email FROM students s " +
                     "JOIN users u ON s.user_id = u.id WHERE s.id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractStudentFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public Student getStudentByUserId(int userId) throws SQLException {
        String sql = "SELECT s.*, u.username, u.email FROM students s " +
                     "JOIN users u ON s.user_id = u.id WHERE s.user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractStudentFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.*, u.username, u.email FROM students s " +
                     "JOIN users u ON s.user_id = u.id ORDER BY s.full_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
        }
        return students;
    }

    public boolean updateStudent(Student student) throws SQLException {
        String sql = "UPDATE students SET full_name = ?, department = ?, year = ?, phone = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getFullName());
            stmt.setString(2, student.getDepartment());
            stmt.setInt(3, student.getYear());
            stmt.setString(4, student.getPhone());
            stmt.setInt(5, student.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteStudent(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Student> searchStudents(String keyword) throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.*, u.username, u.email FROM students s " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE s.full_name LIKE ? OR s.department LIKE ? OR u.username LIKE ? " +
                     "ORDER BY s.full_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    students.add(extractStudentFromResultSet(rs));
                }
            }
        }
        return students;
    }

    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setUserId(rs.getInt("user_id"));
        student.setFullName(rs.getString("full_name"));
        student.setDepartment(rs.getString("department"));
        student.setYear(rs.getInt("year"));
        student.setPhone(rs.getString("phone"));
        student.setCreatedAt(rs.getTimestamp("created_at"));
        student.setUsername(rs.getString("username"));
        student.setEmail(rs.getString("email"));
        return student;
    }
}
