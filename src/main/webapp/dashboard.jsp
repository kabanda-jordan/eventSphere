<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="app-layout">
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
                    <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-nav-item active">
                        <span class="sidebar-nav-icon">📊</span>
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/events?action=list" class="sidebar-nav-item">
                        <span class="sidebar-nav-icon">🎉</span>
                        <span>Events</span>
                        <span class="sidebar-nav-badge">${events.size()}</span>
                    </a>
                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/students?action=list" class="sidebar-nav-item">
                            <span class="sidebar-nav-icon">👥</span>
                            <span>Students</span>
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/chat?action=page" class="sidebar-nav-item">
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
                        <a href="${pageContext.request.contextPath}/students?action=create" class="sidebar-nav-item">
                            <span class="sidebar-nav-icon">👤</span>
                            <span>Add Student</span>
                        </a>
                    </div>
                </c:if>

                <div class="sidebar-nav-section">
                    <div class="sidebar-nav-title">Account</div>
                    <a href="${pageContext.request.contextPath}/settings.jsp" class="sidebar-nav-item">
                        <span class="sidebar-nav-icon">⚙️</span>
                        <span>Settings</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/help.jsp" class="sidebar-nav-item">
                        <span class="sidebar-nav-icon">❓</span>
                        <span>Help & Support</span>
                    </a>
                </div>
            </nav>

            <!-- Quick Stats -->
            <div class="sidebar-stats">
                <div class="sidebar-stat-item">
                    <span class="sidebar-stat-label">Active Events</span>
                    <span class="sidebar-stat-value">${events.size()}</span>
                </div>
                <c:if test="${sessionScope.role == 'STUDENT'}">
                    <div class="sidebar-stat-item">
                        <span class="sidebar-stat-label">My Events</span>
                        <span class="sidebar-stat-value">${registrations.size()}</span>
                    </div>
                </c:if>
            </div>

            <!-- Logout Button -->
            <div class="sidebar-footer">
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-footer-btn">
                    <span>🚪</span>
                    <span>Logout</span>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <div class="main-header">
                <h1>Welcome back, ${sessionScope.username}! 👋</h1>
                <p>Here's what's happening with your events today.</p>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/events?action=list" class="quick-action-card">
                    <div class="quick-action-icon">🎉</div>
                    <div class="quick-action-title">Browse Events</div>
                    <div class="quick-action-desc">${events.size()} available</div>
                </a>
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/events?action=new" class="quick-action-card">
                        <div class="quick-action-icon">➕</div>
                        <div class="quick-action-title">Create Event</div>
                        <div class="quick-action-desc">Add new event</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/students?action=create" class="quick-action-card">
                        <div class="quick-action-icon">👤</div>
                        <div class="quick-action-title">Add Student</div>
                        <div class="quick-action-desc">Create new student</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/students?action=list" class="quick-action-card">
                        <div class="quick-action-icon">👥</div>
                        <div class="quick-action-title">Manage Students</div>
                        <div class="quick-action-desc">View all students</div>
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/chat?action=page" class="quick-action-card">
                    <div class="quick-action-icon">💬</div>
                    <div class="quick-action-title">Messages</div>
                    <div class="quick-action-desc">Chat with users</div>
                </a>
            </div>

            <!-- Stats Grid -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <h3>${events.size()}</h3>
                    <p>📅 Active Events</p>
                </div>
                
                <c:if test="${sessionScope.role == 'STUDENT'}">
                    <div class="stat-card" style="background: var(--gradient-success);">
                        <h3>${registrations.size()}</h3>
                        <p>✅ My Registrations</p>
                    </div>
                </c:if>

                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <div class="stat-card" style="background: var(--gradient-secondary);">
                        <h3>24</h3>
                        <p>👥 Total Students</p>
                    </div>
                    <div class="stat-card" style="background: var(--gradient-success);">
                        <h3>156</h3>
                        <p>📝 Total Registrations</p>
                    </div>
                </c:if>
            </div>

            <!-- Student Registrations Table -->
            <c:if test="${sessionScope.role == 'STUDENT' && not empty registrations}">
                <div class="card" style="margin-top: 2rem;">
                    <div class="card-header">
                        <h2>My Registered Events</h2>
                    </div>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Event</th>
                                    <th>Registered Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="reg" items="${registrations}">
                                    <tr>
                                        <td>${reg.eventTitle}</td>
                                        <td><fmt:formatDate value="${reg.registeredAt}" pattern="MMM dd, yyyy HH:mm"/></td>
                                        <td><span class="badge badge-success">${reg.status}</span></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/events" method="get" style="display: inline;">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="eventId" value="${reg.eventId}">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('Cancel registration?')">Cancel</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

            <!-- Recent Activity Feed -->
            <div class="activity-feed">
                <div class="activity-feed-header">
                    <h3 class="activity-feed-title">Recent Activity</h3>
                </div>
                <div class="activity-item">
                    <div class="activity-icon">🎉</div>
                    <div class="activity-content">
                        <div class="activity-text">New event "Tech Conference 2026" was created</div>
                        <div class="activity-time">2 hours ago</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon" style="background: var(--gradient-success);">✅</div>
                    <div class="activity-content">
                        <div class="activity-text">5 new students registered for events</div>
                        <div class="activity-time">5 hours ago</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon" style="background: var(--gradient-secondary);">💬</div>
                    <div class="activity-content">
                        <div class="activity-text">New message received</div>
                        <div class="activity-time">1 day ago</div>
                    </div>
                </div>
            </div>

            <!-- Upcoming Events -->
            <div class="card">
                <div class="card-header">
                    <h2>Upcoming Events</h2>
                    <a href="${pageContext.request.contextPath}/events?action=list" class="btn btn-primary btn-sm">View All</a>
                </div>
                <div class="event-grid">
                    <c:forEach var="event" items="${events}" begin="0" end="5">
                        <div class="event-card">
                            <div class="event-header">
                                <h3>${event.title}</h3>
                                <div class="event-date">
                                    📅 <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy HH:mm"/>
                                </div>
                            </div>
                            <div class="event-body">
                                <div class="event-info">
                                    <div class="event-info-item">📍 ${event.location}</div>
                                    <div class="event-info-item">👥 ${event.registeredCount}/${event.capacity} registered</div>
                                </div>
                                <p class="text-muted">${event.description}</p>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: ${(event.registeredCount * 100) / event.capacity}%"></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </div>

    <!-- Mobile Sidebar Toggle -->
    <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

    <script>
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

        // Update active nav item based on current page
        document.addEventListener('DOMContentLoaded', function() {
            const currentPath = window.location.pathname;
            const navItems = document.querySelectorAll('.sidebar-nav-item');
            
            navItems.forEach(item => {
                if (item.getAttribute('href').includes(currentPath.split('/').pop())) {
                    navItems.forEach(i => i.classList.remove('active'));
                    item.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
