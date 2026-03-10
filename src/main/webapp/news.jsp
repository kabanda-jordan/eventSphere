<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School News - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/new-design.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-toggle.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <script src="${pageContext.request.contextPath}/js/theme-toggle.js"></script>
</head>
<body>
    <div class="app-layout">
        <!-- Include Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header with Lottie Animation -->
            <div class="main-header">
                <div style="display: flex; align-items: center; gap: 1rem;">
                    <lottie-player 
                        src="https://assets8.lottiefiles.com/packages/lf20_jtbfg2nb.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 60px; height: 60px;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <div>
                        <h1><span class="material-icons" style="vertical-align: middle; font-size: 2rem;">article</span> School News & Updates</h1>
                        <p>Stay informed about events, announcements, and interesting happenings</p>
                    </div>
                </div>
            </div>

            <!-- Search and Filter -->
            <div class="card">
                <div class="search-bar">
                    <form action="${pageContext.request.contextPath}/news" method="get" style="display: flex; gap: 0.5rem; flex: 1;">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword" placeholder="Search news..." 
                               value="${searchKeyword}" style="flex: 1;">
                        <button type="submit" class="btn btn-primary" style="width: auto;">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 4px;">search</span>
                            Search
                        </button>
                    </form>
                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/news?action=new" class="btn btn-success" style="width: auto;">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 4px;">add</span>
                            Post News
                        </a>
                    </c:if>
                </div>

                <!-- Category Filter -->
                <div style="display: flex; gap: 0.5rem; margin-top: 1rem; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/news?action=list" 
                       class="btn btn-sm ${empty param.category ? 'btn-primary' : 'btn-secondary'}">
                        All News
                    </a>
                    <a href="${pageContext.request.contextPath}/news?action=list&category=Announcement" 
                       class="btn btn-sm ${param.category == 'Announcement' ? 'btn-primary' : 'btn-secondary'}">
                        <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">campaign</span> Announcements
                    </a>
                    <a href="${pageContext.request.contextPath}/news?action=list&category=Event" 
                       class="btn btn-sm ${param.category == 'Event' ? 'btn-primary' : 'btn-secondary'}">
                        <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">event</span> Events
                    </a>
                    <a href="${pageContext.request.contextPath}/news?action=list&category=News" 
                       class="btn btn-sm ${param.category == 'News' ? 'btn-primary' : 'btn-secondary'}">
                        <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">article</span> News
                    </a>
                    <a href="${pageContext.request.contextPath}/news?action=list&category=Workshop" 
                       class="btn btn-sm ${param.category == 'Workshop' ? 'btn-primary' : 'btn-secondary'}">
                        <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">school</span> Workshops
                    </a>
                </div>
            </div>

            <!-- Featured News -->
            <c:if test="${not empty featuredNews && empty searchKeyword}">
                <div class="card">
                    <div class="card-header">
                        <h2>
                            <lottie-player 
                                src="https://assets4.lottiefiles.com/packages/lf20_jbrw3hcz.json" 
                                background="transparent" 
                                speed="1" 
                                style="width: 30px; height: 30px; display: inline-block; vertical-align: middle; margin-right: 8px;" 
                                loop 
                                autoplay>
                            </lottie-player>
                            Featured News
                        </h2>
                    </div>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; margin-top: 1rem;">
                        <c:forEach var="news" items="${featuredNews}">
                            <div class="card" style="background: var(--gradient-primary); color: white; cursor: pointer;" 
                                 onclick="window.location.href='${pageContext.request.contextPath}/news?action=view&id=${news.id}'">
                                <h3 style="color: white; margin-bottom: 0.5rem;">${news.title}</h3>
                                <p style="opacity: 0.9; font-size: 0.875rem; margin-bottom: 0.5rem;">${news.preview}</p>
                                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.75rem; opacity: 0.8;">
                                    <span><span class="material-icons" style="vertical-align: middle; font-size: 1rem;">event</span> <fmt:formatDate value="${news.createdAt}" pattern="MMM dd, yyyy"/></span>
                                    <span><span class="material-icons" style="vertical-align: middle; font-size: 1rem;">visibility</span> ${news.views} views</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- News List -->
            <div class="card">
                <div class="card-header">
                    <h2>
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                Search Results for "${searchKeyword}"
                            </c:when>
                            <c:when test="${not empty param.category}">
                                ${param.category}
                            </c:when>
                            <c:otherwise>
                                All News
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </div>

                <c:if test="${empty newsList}">
                    <div class="empty-state">
                        <lottie-player 
                            src="https://assets8.lottiefiles.com/packages/lf20_jtbfg2nb.json" 
                            background="transparent" 
                            speed="1" 
                            style="width: 150px; height: 150px; margin: 0 auto 1rem;" 
                            loop 
                            autoplay>
                        </lottie-player>
                        <p>No news found</p>
                    </div>
                </c:if>

                <div style="display: grid; gap: 1.5rem; margin-top: 1.5rem;">
                    <c:forEach var="news" items="${newsList}">
                        <div class="card" style="cursor: pointer; transition: all 0.3s ease;" 
                             onclick="window.location.href='${pageContext.request.contextPath}/news?action=view&id=${news.id}'"
                             onmouseover="this.style.transform='translateX(8px)'" 
                             onmouseout="this.style.transform='translateX(0)'">
                            <div style="display: flex; gap: 1.5rem; align-items: start;">
                                <div style="flex: 1;">
                                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem;">
                                        <span class="badge badge-info">${news.category}</span>
                                        <c:if test="${news.featured}">
                                            <span class="badge badge-warning">⭐ Featured</span>
                                        </c:if>
                                    </div>
                                    <h3 style="margin-bottom: 0.75rem; color: var(--text-primary);">${news.title}</h3>
                                    <p style="color: var(--text-secondary); margin-bottom: 1rem;">${news.preview}</p>
                                    <div style="display: flex; gap: 1.5rem; font-size: 0.875rem; color: var(--text-muted);">
                                        <span><span class="material-icons" style="vertical-align: middle; font-size: 1rem;">person</span> ${news.authorName}</span>
                                        <span><span class="material-icons" style="vertical-align: middle; font-size: 1rem;">event</span> <fmt:formatDate value="${news.createdAt}" pattern="MMM dd, yyyy"/></span>
                                        <span><span class="material-icons" style="vertical-align: middle; font-size: 1rem;">visibility</span> ${news.views} views</span>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <div style="display: flex; gap: 0.5rem;" onclick="event.stopPropagation();">
                                        <a href="${pageContext.request.contextPath}/news?action=edit&id=${news.id}" 
                                           class="btn btn-sm btn-secondary">
                                            <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">edit</span>
                                            Edit
                                        </a>
                                        <form action="${pageContext.request.contextPath}/news" method="get" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${news.id}">
                                            <button type="submit" class="btn btn-sm btn-danger" 
                                                    onclick="return confirm('Delete this news?')">
                                                <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">delete</span>
                                                Delete
                                            </button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </div>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>
</body>
</html>
