<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${news.title} - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="app-layout">
        <!-- Include Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <!-- Back Button -->
            <div style="margin-bottom: 1.5rem;">
                <a href="${pageContext.request.contextPath}/news?action=list" class="btn btn-secondary" style="width: auto;">
                    ← Back to News
                </a>
            </div>

            <!-- News Article -->
            <div class="card">
                <!-- Header -->
                <div style="margin-bottom: 2rem;">
                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem;">
                        <span class="badge badge-info">${news.category}</span>
                        <c:if test="${news.featured}">
                            <span class="badge badge-warning">⭐ Featured</span>
                        </c:if>
                    </div>
                    <h1 style="font-size: 2.5rem; margin-bottom: 1rem; color: var(--text-primary);">${news.title}</h1>
                    <div style="display: flex; gap: 2rem; font-size: 0.875rem; color: var(--text-muted); padding-bottom: 1.5rem; border-bottom: 2px solid var(--border);">
                        <span>✍️ By ${news.authorName}</span>
                        <span>📅 <fmt:formatDate value="${news.createdAt}" pattern="MMMM dd, yyyy 'at' HH:mm"/></span>
                        <span>👁️ ${news.views} views</span>
                    </div>
                </div>

                <!-- Image (if exists) -->
                <c:if test="${not empty news.imageUrl}">
                    <div style="margin-bottom: 2rem;">
                        <img src="${news.imageUrl}" alt="${news.title}" 
                             style="width: 100%; max-height: 400px; object-fit: cover; border-radius: 12px;">
                    </div>
                </c:if>

                <!-- Content -->
                <div style="font-size: 1.125rem; line-height: 1.8; color: var(--text-secondary); white-space: pre-wrap;">
                    ${news.content}
                </div>

                <!-- Footer -->
                <div style="margin-top: 3rem; padding-top: 2rem; border-top: 2px solid var(--border);">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div style="font-size: 0.875rem; color: var(--text-muted);">
                            Last updated: <fmt:formatDate value="${news.updatedAt}" pattern="MMM dd, yyyy"/>
                        </div>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <div style="display: flex; gap: 0.5rem;">
                                <a href="${pageContext.request.contextPath}/news?action=edit&id=${news.id}" 
                                   class="btn btn-secondary">✏️ Edit</a>
                                <form action="${pageContext.request.contextPath}/news" method="get" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${news.id}">
                                    <button type="submit" class="btn btn-danger" 
                                            onclick="return confirm('Delete this news?')">🗑️ Delete</button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Share Section -->
            <div class="card">
                <h3 style="margin-bottom: 1rem;">📤 Share this news</h3>
                <div style="display: flex; gap: 0.5rem;">
                    <button class="btn btn-secondary" onclick="copyLink()" style="width: auto;">
                        🔗 Copy Link
                    </button>
                    <button class="btn btn-secondary" onclick="shareNews()" style="width: auto;">
                        📱 Share
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
