<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${news.title} - EventSphere</title>
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
                    src="https://assets4.lottiefiles.com/packages/lf20_V9t630.json" 
                    background="transparent" 
                    speed="1" 
                    style="width: 100px; height: 100px; margin: 0 auto;" 
                    loop 
                    autoplay>
                </lottie-player>
            </div>

            <!-- Back Button -->
            <div style="margin-bottom: 1.5rem;">
                <a href="${pageContext.request.contextPath}/news?action=list" class="btn btn-secondary" style="width: auto;">
                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">arrow_back</span>
                    Back to News
                </a>
            </div>

            <!-- News Article -->
            <div class="card animate-fade-in">
                <!-- Header -->
                <div style="margin-bottom: 2rem;">
                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem;">
                        <span class="badge" style="background: var(--gradient-accent); color: white; padding: 8px 16px; font-weight: 600;">
                            <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">category</span>
                            ${news.category}
                        </span>
                        <c:if test="${news.featured}">
                            <span class="badge" style="background: var(--gradient-secondary); color: white; padding: 8px 16px; font-weight: 600;">
                                <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">star</span>
                                Featured
                            </span>
                        </c:if>
                    </div>
                    <h1 style="font-size: 2.5rem; margin-bottom: 1rem; background: var(--gradient-primary); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">${news.title}</h1>
                    <div style="display: flex; gap: 2rem; font-size: 0.875rem; color: var(--text-muted); padding-bottom: 1.5rem; border-bottom: 2px solid var(--border-color);">
                        <span>
                            <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">person</span>
                            By ${news.authorName}
                        </span>
                        <span>
                            <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">schedule</span>
                            <fmt:formatDate value="${news.createdAt}" pattern="MMMM dd, yyyy 'at' HH:mm"/>
                        </span>
                        <span>
                            <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">visibility</span>
                            ${news.views} views
                        </span>
                    </div>
                </div>

                <!-- Image (if exists) -->
                <c:if test="${not empty news.imageUrl}">
                    <div style="margin-bottom: 2rem;">
                        <img src="${news.imageUrl}" alt="${news.title}" 
                             style="width: 100%; max-height: 400px; object-fit: cover; border: 2px solid var(--border-color);">
                    </div>
                </c:if>

                <!-- Content -->
                <div style="font-size: 1.125rem; line-height: 1.8; color: var(--text-secondary); white-space: pre-wrap;">
                    ${news.content}
                </div>

                <!-- Footer -->
                <div style="margin-top: 3rem; padding-top: 2rem; border-top: 2px solid var(--border-color);">
                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                        <div style="font-size: 0.875rem; color: var(--text-muted);">
                            <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">update</span>
                            Last updated: <fmt:formatDate value="${news.updatedAt}" pattern="MMM dd, yyyy"/>
                        </div>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <div style="display: flex; gap: 0.5rem;">
                                <a href="${pageContext.request.contextPath}/news?action=edit&id=${news.id}" 
                                   class="btn btn-accent" style="width: auto;">
                                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">edit</span>
                                    Edit
                                </a>
                                <form action="${pageContext.request.contextPath}/news" method="get" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${news.id}">
                                    <button type="submit" class="btn btn-danger" style="width: auto;"
                                            onclick="return confirm('Delete this news?')">
                                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">delete</span>
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Share Section -->
            <div class="card animate-fade-in">
                <h3 style="margin-bottom: 1rem; color: var(--text-primary);">
                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">share</span>
                    Share this news
                </h3>
                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                    <button class="btn btn-secondary" onclick="copyLink()" style="width: auto;">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">link</span>
                        Copy Link
                    </button>
                    <button class="btn btn-accent" onclick="shareNews()" style="width: auto;">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">mobile_screen_share</span>
                        Share
                    </button>
                </div>
            </div>
        </main>
    </div>

    <script>
        function copyLink() {
            const url = window.location.href;
            navigator.clipboard.writeText(url).then(() => {
                alert('Link copied to clipboard!');
            });
        }

        function shareNews() {
            if (navigator.share) {
                navigator.share({
                    title: '${news.title}',
                    text: '${news.preview}',
                    url: window.location.href
                }).catch(err => console.log('Error sharing:', err));
            } else {
                copyLink();
            }
        }
    </script>
</body>
</html>
