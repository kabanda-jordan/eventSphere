package com.eventsphere.dao;

import com.eventsphere.model.News;
import com.eventsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {

    // Get all news
    public List<News> getAllNews() throws SQLException {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                newsList.add(extractNewsFromResultSet(rs));
            }
        }
        return newsList;
    }

    // Get featured news
    public List<News> getFeaturedNews() throws SQLException {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE is_featured = TRUE ORDER BY created_at DESC LIMIT 3";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                newsList.add(extractNewsFromResultSet(rs));
            }
        }
        return newsList;
    }

    // Get news by category
    public List<News> getNewsByCategory(String category) throws SQLException {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE category = ? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsList.add(extractNewsFromResultSet(rs));
                }
            }
        }
        return newsList;
    }

    // Get news by ID
    public News getNewsById(int id) throws SQLException {
        String sql = "SELECT * FROM news WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractNewsFromResultSet(rs);
                }
            }
        }
        return null;
    }

    // Create news
    public boolean createNews(News news) throws SQLException {
        String sql = "INSERT INTO news (title, content, category, image_url, author_id, author_name, is_featured) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, news.getTitle());
            stmt.setString(2, news.getContent());
            stmt.setString(3, news.getCategory());
            stmt.setString(4, news.getImageUrl());
            stmt.setInt(5, news.getAuthorId());
            stmt.setString(6, news.getAuthorName());
            stmt.setBoolean(7, news.isFeatured());

            return stmt.executeUpdate() > 0;
        }
    }

    // Update news
    public boolean updateNews(News news) throws SQLException {
        String sql = "UPDATE news SET title = ?, content = ?, category = ?, image_url = ?, is_featured = ? " +
                     "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, news.getTitle());
            stmt.setString(2, news.getContent());
            stmt.setString(3, news.getCategory());
            stmt.setString(4, news.getImageUrl());
            stmt.setBoolean(5, news.isFeatured());
            stmt.setInt(6, news.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Delete news
    public boolean deleteNews(int id) throws SQLException {
        String sql = "DELETE FROM news WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    // Increment views
    public void incrementViews(int id) throws SQLException {
        String sql = "UPDATE news SET views = views + 1 WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Search news
    public List<News> searchNews(String keyword) throws SQLException {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE title LIKE ? OR content LIKE ? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    newsList.add(extractNewsFromResultSet(rs));
                }
            }
        }
        return newsList;
    }

    // Helper method to extract News from ResultSet
    private News extractNewsFromResultSet(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getInt("id"));
        news.setTitle(rs.getString("title"));
        news.setContent(rs.getString("content"));
        news.setCategory(rs.getString("category"));
        news.setImageUrl(rs.getString("image_url"));
        news.setAuthorId(rs.getInt("author_id"));
        news.setAuthorName(rs.getString("author_name"));
        news.setCreatedAt(rs.getTimestamp("created_at"));
        news.setUpdatedAt(rs.getTimestamp("updated_at"));
        news.setFeatured(rs.getBoolean("is_featured"));
        news.setViews(rs.getInt("views"));
        return news;
    }
}
