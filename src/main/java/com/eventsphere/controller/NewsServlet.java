package com.eventsphere.controller;

import com.eventsphere.dao.NewsDAO;
import com.eventsphere.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class NewsServlet extends HttpServlet {
    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    listNews(request, response);
                    break;
                case "view":
                    viewNews(request, response);
                    break;
                case "new":
                    showNewsForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteNews(request, response);
                    break;
                case "search":
                    searchNews(request, response);
                    break;
                default:
                    listNews(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                createNews(request, response);
            } else if ("update".equals(action)) {
                updateNews(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listNews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String category = request.getParameter("category");
        List<News> newsList;

        if (category != null && !category.isEmpty()) {
            newsList = newsDAO.getNewsByCategory(category);
        } else {
            newsList = newsDAO.getAllNews();
        }

        List<News> featuredNews = newsDAO.getFeaturedNews();

        request.setAttribute("newsList", newsList);
        request.setAttribute("featuredNews", featuredNews);
        request.getRequestDispatcher("/news.jsp").forward(request, response);
    }

    private void viewNews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        News news = newsDAO.getNewsById(id);

        if (news != null) {
            // Increment view count
            newsDAO.incrementViews(id);
            news.setViews(news.getViews() + 1);

            request.setAttribute("news", news);
            request.getRequestDispatcher("/news-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/news?action=list");
        }
    }

    private void showNewsForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/news-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        News news = newsDAO.getNewsById(id);

        request.setAttribute("news", news);
        request.getRequestDispatcher("/news-form.jsp").forward(request, response);
    }

    private void createNews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        News news = new News();
        news.setTitle(request.getParameter("title"));
        news.setContent(request.getParameter("content"));
        news.setCategory(request.getParameter("category"));
        news.setImageUrl(request.getParameter("imageUrl"));
        news.setAuthorId(userId);
        news.setAuthorName(username);
        news.setFeatured("on".equals(request.getParameter("isFeatured")));

        newsDAO.createNews(news);
        response.sendRedirect(request.getContextPath() + "/news?action=list");
    }

    private void updateNews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        News news = new News();
        news.setId(Integer.parseInt(request.getParameter("id")));
        news.setTitle(request.getParameter("title"));
        news.setContent(request.getParameter("content"));
        news.setCategory(request.getParameter("category"));
        news.setImageUrl(request.getParameter("imageUrl"));
        news.setFeatured("on".equals(request.getParameter("isFeatured")));

        newsDAO.updateNews(news);
        response.sendRedirect(request.getContextPath() + "/news?action=list");
    }

    private void deleteNews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        newsDAO.deleteNews(id);
        response.sendRedirect(request.getContextPath() + "/news?action=list");
    }

    private void searchNews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<News> newsList = newsDAO.searchNews(keyword);
        List<News> featuredNews = newsDAO.getFeaturedNews();

        request.setAttribute("newsList", newsList);
        request.setAttribute("featuredNews", featuredNews);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/news.jsp").forward(request, response);
    }
}
