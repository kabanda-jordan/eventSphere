<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Announcements - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="app-layout">
        <!-- Include Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <div class="main-header">
                <h1>📢 School Announcements</h1>
                <p>Important updates and official announcements from the administration</p>
            </div>

            <!-- Admin Actions -->
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <div class="card">
                    <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/news?action=new" class="btn btn-success" style="width: auto;">
                            ➕ Post Announcement
                        </a>
                        <a href="${pageContext.request.contextPath}/news?action=list" class="btn btn-secondary" style="width: auto;">
                            📰 View All News
                        </a>
                    </div>
                </div>
            </c:if>

            <!-- Featured Announcements -->
            <c:if test="${not empty featuredAnnouncements}">
                <div class="card">
                    <div class="card-header">
                        <h2>⭐ Important Announcements</h2>
                    </div>
                    <div style="display: grid; gap: 1rem; margin-top: 1rem;">
                        <c:forEach var="announcement" items="${featuredAnnouncements}">
                            <div class="card" style="background: var(--gradient-danger); color: white; cursor: pointer;" 
                                 onclick="window.location.href='${pageContext.request.contextPath}/news?action=view&id=${announcement.id}'">
                                <div style="display: flex; align-items: start; gap: 1rem;">
                                    <div style="font-size: 3rem;">📢</div>
                                    <div style="flex: 1;">
                                        <h3 style="color: white; margin-bottom: 0.5rem; font-size: 1.5rem;">${announcement.title}</h3>
                                        <p style="opacity: 0.95; margin-bottom: 0.75rem;">${announcement.preview}</p>
                                        <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.875rem; opacity: 0.9;">
                                            <span>📅 <fmt:formatDate value="${announcement.createdAt}" pattern="MMM dd, yyyy"/></span>
                                            <span>👁️ ${announcement.views} views</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- All Announcements -->
            <div class="card">
                <div class="card-header">
                    <h2>📋 All Announcements</h2>
                </div>

                <c:if test="${empty announcements}">
                    <div class="empty-state">
                        <p>📭 No announcements yet</p>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/news?action=new" class="btn btn-primary" style="margin-top: 1rem;">
                                Post First Announcement
                            </a>
                        </c:if>
                    </div>
                </c:if>

                <div style="display: grid; gap: 1.5rem; margin-top: 1.5rem;">
                    <c:forEach var="announcement" items="${announcements}">
                        <div class="card" style="border-left: 4px solid var(--danger); cursor: pointer; transition: all 0.3s ease;" 
                             onclick="window.location.href='${pageContext.request.contextPath}/news?action=view&id=${announcement.id}'"
                             onmouseover="this.style.transform='translateX(8px)'" 
                             onmouseout="this.style.transform='translateX(0)'">
                            <div style="display: flex; gap: 1.5rem; align-items: start;">
                                <div style="font-size: 2.5rem; flex-shrink: 0;">📢</div>
                                <div style="flex: 1;">
                                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem;">
                                        <span class="badge badge-danger">Announcement</span>
                                        <c:if test="${announcement.featured}">
                                            <span class="badge badge-warning">⭐ Important</span>
                                        </c:if>
                                    </div>
                                    <h3 style="margin-bottom: 0.75rem; color: var(--text-primary); font-size: 1.25rem;">${announcement.title}</h3>
                                    <p style="color: var(--text-secondary); margin-bottom: 1rem; line-height: 1.6;">${announcement.preview}</p>
                                    <div style="display: flex; gap: 1.5rem; font-size: 0.875rem; color: var(--text-muted);">
                                        <span>✍️ ${announcement.authorName}</span>
                                        <span>📅 <fmt:formatDate value="${announcement.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm"/></span>
                                        <span>👁️ ${announcement.views} views</span>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <div style="display: flex; gap: 0.5rem; flex-shrink: 0;" onclick="event.stopPropagation();">
                                        <a href="${pageContext.request.contextPath}/news?action=edit&id=${announcement.id}" 
                                           class="btn btn-sm btn-secondary">✏️</a>
                                        <form action="${pageContext.request.contextPath}/news" method="get" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${announcement.id}">
                                            <button type="submit" class="btn btn-sm btn-danger" 
                                                    onclick="return confirm('Delete this announcement?')">🗑️</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Info Card -->
            <div class="card" style="background: rgba(59, 130, 246, 0.1); border-left: 4px solid var(--info);">
                <h3 style="margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                    <span>ℹ️</span>
                    <span>About Announcements</span>
                </h3>
                <p style="color: var(--text-secondary); line-height: 1.6;">
                    This page shows official school announcements from the administration. 
                    Check here regularly for important updates about:
                </p>
                <ul style="color: var(--text-secondary); margin-top: 0.75rem; margin-left: 1.5rem; line-height: 1.8;">
                    <li>📚 Academic schedules and deadlines</li>
                    <li>🎓 Exam dates and results</li>
                    <li>🏫 School policies and regulations</li>
                    <li>🎉 Upcoming events and activities</li>
                    <li>⚠️ Emergency notifications</li>
                    <li>📅 Holiday schedules</li>
                    <li>🏆 Awards and achievements</li>
                </ul>
            </div>
        </main>
    </div>
</body>
</html>
