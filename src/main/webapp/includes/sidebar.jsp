<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Vertical Sidebar -->
<aside class="sidebar" id="sidebar">
    <!-- Logo -->
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-logo">
            EventSphere
        </a>
    </div>

    <!-- User Profile -->
    <div class="sidebar-user">
        <div class="sidebar-user-avatar">
            ${sessionScope.username.substring(0, 1).toUpperCase()}
        </div>
        <div class="sidebar-user-info">
            <div class="sidebar-user-name">${sessionScope.username}</div>
            <div class="sidebar-user-role">${sessionScope.role}</div>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="sidebar-nav">
        <div class="sidebar-nav-section">
            <div class="sidebar-nav-title">Main Menu</div>
            <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-nav-item ${pageContext.request.servletPath == '/dashboard.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">📊</span>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/events?action=list" class="sidebar-nav-item ${pageContext.request.servletPath == '/events.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">🎉</span>
                <span>Events</span>
            </a>
            <a href="${pageContext.request.contextPath}/announcements" class="sidebar-nav-item ${pageContext.request.servletPath == '/announcements.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">📢</span>
                <span>Announcements</span>
            </a>
            <a href="${pageContext.request.contextPath}/news?action=list" class="sidebar-nav-item ${pageContext.request.servletPath == '/news.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">📰</span>
                <span>News</span>
            </a>
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/students?action=list" class="sidebar-nav-item ${pageContext.request.servletPath == '/students.jsp' ? 'active' : ''}">
                    <span class="sidebar-nav-icon">👥</span>
                    <span>Students</span>
                </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/chat?action=page" class="sidebar-nav-item ${pageContext.request.servletPath == '/chat.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">💬</span>
                <span>Messages</span>
            </a>
        </div>

        <c:if test="${sessionScope.role == 'ADMIN'}">
            <div class="sidebar-nav-section">
                <div class="sidebar-nav-title">Quick Actions</div>
                <a href="${pageContext.request.contextPath}/events?action=new" class="sidebar-nav-item">
                    <span class="sidebar-nav-icon">➕</span>
                    <span>Create Event</span>
                </a>
                <a href="${pageContext.request.contextPath}/students?action=new" class="sidebar-nav-item">
                    <span class="sidebar-nav-icon">👤</span>
                    <span>Add Student</span>
                </a>
            </div>
        </c:if>

        <div class="sidebar-nav-section">
            <div class="sidebar-nav-title">Account</div>
            <a href="${pageContext.request.contextPath}/settings.jsp" class="sidebar-nav-item ${pageContext.request.servletPath == '/settings.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">⚙️</span>
                <span>Settings</span>
            </a>
            <a href="${pageContext.request.contextPath}/help.jsp" class="sidebar-nav-item ${pageContext.request.servletPath == '/help.jsp' ? 'active' : ''}">
                <span class="sidebar-nav-icon">❓</span>
                <span>Help & Support</span>
            </a>
        </div>
    </nav>

    <!-- Logout Button -->
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-footer-btn">
            <span>🚪</span>
            <span>Logout</span>
        </a>
    </div>
</aside>

<!-- Theme Toggle Button -->
<button class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
    <span id="themeIcon">☀️</span>
</button>

<!-- Mobile Sidebar Toggle -->
<button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

<script>
    // Theme Toggle Function
    function toggleTheme() {
        const html = document.documentElement;
        const currentTheme = html.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        const themeIcon = document.getElementById('themeIcon');
        
        html.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        
        // Update icon
        themeIcon.textContent = newTheme === 'light' ? '🌙' : '☀️';
    }
    
    // Load saved theme on page load
    document.addEventListener('DOMContentLoaded', function() {
        const savedTheme = localStorage.getItem('theme') || 'dark';
        const themeIcon = document.getElementById('themeIcon');
        
        document.documentElement.setAttribute('data-theme', savedTheme);
        themeIcon.textContent = savedTheme === 'light' ? '🌙' : '☀️';
    });

    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('active');
    }

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const toggle = document.querySelector('.sidebar-toggle');
        
        if (window.innerWidth <= 1024) {
            if (!sidebar.contains(event.target) && !toggle.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        }
    });
</script>
