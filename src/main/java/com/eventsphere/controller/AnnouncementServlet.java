package com.eventsphere.controller;

import com.eventsphere.dao.NewsDAO;
import com.eventsphere.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

public class AnnouncementServlet extends HttpServlet {
    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get all announcements (category = "Announcement")
            List<News> allAnnouncements = newsDAO.getNewsByCategory("Announcement");
            
            // Get featured announcements
            List<News> featuredAnnouncements = allAnnouncements.stream()
                    .filter(News::isFeatured)
                    .limit(3)
                    .collect(Collectors.toList());

            request.setAttribute("announcements", allAnnouncements);
            request.setAttribute("featuredAnnouncements", featuredAnnouncements);
            request.getRequestDispatcher("/announcements.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
