package com.eventsphere.model;

import java.sql.Timestamp;

public class News {
    private int id;
    private String title;
    private String content;
    private String category;
    private String imageUrl;
    private int authorId;
    private String authorName;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isFeatured;
    private int views;

    // Constructors
    public News() {
    }

    public News(int id, String title, String content, String category, String imageUrl, 
                int authorId, String authorName, Timestamp createdAt, Timestamp updatedAt, 
                boolean isFeatured, int views) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.imageUrl = imageUrl;
        this.authorId = authorId;
        this.authorName = authorName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isFeatured = isFeatured;
        this.views = views;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    // Helper method to get short content preview
    public String getPreview() {
        if (content == null) return "";
        return content.length() > 150 ? content.substring(0, 150) + "..." : content;
    }
}
