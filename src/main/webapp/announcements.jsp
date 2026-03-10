<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Announcements - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/new-design.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-toggle.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <script src="${pageContext.request.contextPath}/js/theme-toggle.js"></script>
</head>
<body>
    <!-- Theme Toggle Button -->
    <button class="theme-toggle app-layout" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>

    <div class="app-layout">
        <!-- Include Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <!-- Lottie Animation -->
            <div class="lottie-container lottie-small" style="margin: 0 auto 20px;">
                <lottie-player 
                    src="https://assets8.lottiefiles.com/packages/lf20_jtbfg2nb.json" 
                    background="transparent" 
                    speed="1" 
                    style="width: 100px; height: 100px; margin: 0 auto;" 
                    loop 
                    autoplay>
                </lottie-player>
            </div>

            <!-- Header -->
            <div class="main-header animate-fade-in">
                <h1 style="background: var(--gradient-primary); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                    <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle; margin-right: 12px; color: var(--primary);">campaign</span>
                    School Announcements
                </h1>
                <p style="color: var(--text-secondary);">Important updates and official announcements from the administration</p>
            </div>

            <!-- Admin Actions -->
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <div class="card animate-fade-in">
                    <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/news?action=new" class="btn btn-primary" style="width: auto;">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">add_circle</span>
                            Post Announcement
                        </a>
                        <a href="${pageContext.request.contextPath}/news?action=list" class="btn btn-secondary" style="width: auto;">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">article</span>
                            View All News
                        </a>
                    </div>
                </div>
            </c:if>

            <!-- Featured Announcements -->
            <c:if test="${not empty featuredAnnouncements}">
                <div class="card animate-fade-in">
                    <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                        <h2 style="color: var(--text-primary);">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 8px; color: var(--warning);">priority_high</span>
                            Important Announcements
                        </h2>
                    </div>
                    <div style="display: grid; gap: 1rem; margin-top: 1rem;">
                        <c:forEach var="announcement" items="${featuredAnnouncements}">
                            <div class="card" style="background: rgba(249, 115, 22, 0.1); border: 2px solid var(--secondary); cursor: pointer; transition: all 0.3s ease;" 
                                 onclick="window.location.href='${pageContext.request.contextPath}/news?action=view&id=${announcement.id}'"
                                 onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='var(--shadow-secondary)'" 
                                 onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none'">
                                <div style="display: flex; align-items: start; gap: 1rem;">
                                    <span class="material-icons" style="color: var(--secondary); font-size: 2rem; flex-shrink: 0;">campaign</span>
                                    <div style="flex: 1;">
                                        <h3 style="margin-bottom: 0.5rem; font-size: 1.25rem; color: var(--text-primary);">${announcement.title}</h3>
                                        <p style="color: var(--text-secondary); margin-bottom: 0.75rem; line-height: 1.6;">${announcement.preview}</p>
                                        <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.875rem; color: var(--text-muted);">
                                            <span>
                                                <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">schedule</span>
                                                <fmt:formatDate value="${announcement.createdAt}" pattern="MMM dd, yyyy"/>
                                            </span>
                                            <span>
                                                <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">visibility</span>
                                                ${announcement.views} views
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- All Announcements -->
            <div class="card animate-fade-in">
                <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--text-primary);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">list</span>
                        All Announcements
                    </h2>
                </div>

                <c:if test="${empty announcements}">
                    <div class="empty-state" style="text-align: center; padding: 3rem 1rem;">
                        <span class="material-icons" style="font-size: 4rem; color: var(--text-muted); margin-bottom: 1rem; display: block;">campaign</span>
                        <p style="color: var(--text-muted); font-size: 1.125rem; margin-bottom: 1rem;">No announcements yet</p>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/news?action=new" class="btn btn-primary" style="margin-top: 1rem;">
                                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">add_circle</span>
                                Post First Announcement
                            </a>
                        </c:if>
                    </div>
                </c:if>

                <div style="display: grid; gap: 1.5rem; margin-top: 1.5rem;">
                    <c:forEach var="announcement" items="${announcements}">
                        <div class="card" style="border-left: 4px solid var(--border-color); cursor: pointer; transition: all 0.3s ease;" 
                             onclick="window.location.href='${pageContext.request.contextPath}/news?action=view&id=${announcement.id}'"
                             onmouseover="this.style.borderLeftColor='var(--primary)'; this.style.transform='translateX(4px)'" 
                             onmouseout="this.style.borderLeftColor='var(--border-color)'; this.style.transform='translateX(0)'">
                            <div style="display: flex; gap: 1.5rem; align-items: start;">
                                <span class="material-icons" style="color: var(--primary); font-size: 1.5rem; flex-shrink: 0; margin-top: 4px;">campaign</span>
                                <div style="flex: 1;">
                                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem;">
                                        <span class="badge" style="background: var(--gradient-accent); color: white; padding: 4px 12px; font-size: 0.75rem; font-weight: 600;">
                                            Announcement
                                        </span>
                                        <c:if test="${announcement.featured}">
                                            <span class="badge" style="background: var(--gradient-secondary); color: white; padding: 4px 12px; font-size: 0.75rem; font-weight: 600;">
                                                <span class="material-icons" style="font-size: 0.875rem; vertical-align: middle; margin-right: 2px;">star</span>
                                                Important
                                            </span>
                                        </c:if>
                                    </div>
                                    <h3 style="margin-bottom: 0.75rem; color: var(--text-primary); font-size: 1.125rem; line-height: 1.4;">${announcement.title}</h3>
                                    <p style="color: var(--text-secondary); margin-bottom: 1rem; line-height: 1.6;">${announcement.preview}</p>
                                    <div style="display: flex; gap: 1.5rem; font-size: 0.875rem; color: var(--text-muted); flex-wrap: wrap;">
                                        <span>
                                            <span class="material-icons" style="vertical-align: middle; font-size: 1rem; margin-right: 4px;">person</span>
                                            ${announcement.authorName}
                                        </span>
                                        <span>
                                            <span class="material-icons" style="vertical-align: middle; font-size: 1rem; margin-right: 4px;">schedule</span>
                                            <fmt:formatDate value="${announcement.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                                        </span>
                                        <span>
                                            <span class="material-icons" style="vertical-align: middle; font-size: 1rem; margin-right: 4px;">visibility</span>
                                            ${announcement.views} views
                                        </span>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <div style="display: flex; gap: 0.5rem; flex-shrink: 0;" onclick="event.stopPropagation();">
                                        <a href="${pageContext.request.contextPath}/news?action=edit&id=${announcement.id}" 
                                           class="btn btn-sm" style="background: var(--gradient-accent); color: white; padding: 8px; width: auto;">
                                            <span class="material-icons" style="font-size: 1rem;">edit</span>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/news" method="get" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${announcement.id}">
                                            <button type="submit" class="btn btn-sm" style="background: var(--gradient-danger); color: white; padding: 8px; width: auto;"
                                                    onclick="return confirm('Delete this announcement?')">
                                                <span class="material-icons" style="font-size: 1rem;">delete</span>
                                            </button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Info Card -->
            <div class="card animate-fade-in" style="background: rgba(59, 130, 246, 0.1); border: 2px solid var(--accent);">
                <h3 style="margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem; color: var(--accent);">
                    <span class="material-icons">info</span>
                    <span>About Announcements</span>
                </h3>
                <p style="color: var(--text-secondary); line-height: 1.6; margin: 0;">
                    This page shows official school announcements from the administration. 
                    Check here regularly for important updates about events, policies, and school news.
                </p>
            </div>
        </main>
    </div>
</body>
</html>
