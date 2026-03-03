<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty news ? 'Post News' : 'Edit News'} - EventSphere</title>
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
                <h1>${empty news ? '➕ Post New News' : '✏️ Edit News'}</h1>
                <p>Share important updates and announcements with students</p>
            </div>

            <!-- Form -->
            <div class="card">
                <form action="${pageContext.request.contextPath}/news" method="post">
                    <input type="hidden" name="action" value="${empty news ? 'create' : 'update'}">
                    <c:if test="${not empty news}">
                        <input type="hidden" name="id" value="${news.id}">
                    </c:if>

                    <div class="form-group">
                        <label for="title">Title *</label>
                        <input type="text" id="title" name="title" class="form-control" 
                               value="${news.title}" placeholder="Enter news title" required>
                    </div>

                    <div class="form-group">
                        <label for="category">Category *</label>
                        <select id="category" name="category" class="form-control" required>
                            <option value="">Select Category</option>
                            <option value="Announcement" ${news.category == 'Announcement' ? 'selected' : ''}>📢 Announcement</option>
                            <option value="Event" ${news.category == 'Event' ? 'selected' : ''}>🎉 Event</option>
                            <option value="News" ${news.category == 'News' ? 'selected' : ''}>📰 News</option>
                            <option value="Workshop" ${news.category == 'Workshop' ? 'selected' : ''}>🎓 Workshop</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="content">Content *</label>
                        <textarea id="content" name="content" class="form-control" rows="12" 
                                  placeholder="Write your news content here..." required>${news.content}</textarea>
                        <small style="color: var(--text-muted);">Tip: Write clear and engaging content. Use line breaks for better readability.</small>
                    </div>

                    <div class="form-group">
                        <label for="imageUrl">Image URL (Optional)</label>
                        <input type="url" id="imageUrl" name="imageUrl" class="form-control" 
                               value="${news.imageUrl}" placeholder="https://example.com/image.jpg">
                        <small style="color: var(--text-muted);">Add an image URL to make your news more attractive</small>
                    </div>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" name="isFeatured" ${news.featured ? 'checked' : ''} 
                                   style="width: auto; height: auto;">
                            <span>⭐ Mark as Featured (appears at the top)</span>
                        </label>
                    </div>

                    <div style="display: flex; gap: 0.5rem;">
                        <button type="submit" class="btn btn-primary">
                            ${empty news ? '📤 Publish News' : '💾 Update News'}
                        </button>
                        <a href="${pageContext.request.contextPath}/news?action=list" class="btn btn-secondary">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>

            <!-- Preview Section -->
            <div class="card">
                <h3 style="margin-bottom: 1rem;">👁️ Preview</h3>
                <div id="preview" style="padding: 1.5rem; background: var(--bg-secondary); border-radius: 12px; min-height: 200px;">
                    <p style="color: var(--text-muted);">Preview will appear here as you type...</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Live preview
        const titleInput = document.getElementById('title');
        const contentInput = document.getElementById('content');
        const categorySelect = document.getElementById('category');
        const preview = document.getElementById('preview');

        function updatePreview() {
            const title = titleInput.value || 'Untitled';
            const content = contentInput.value || 'No content yet...';
            const category = categorySelect.value || 'Uncategorized';

            preview.innerHTML = `
                <div style="margin-bottom: 0.5rem;">
                    <span class="badge badge-info">${category}</span>
                </div>
                <h2 style="margin-bottom: 1rem; color: var(--text-primary);">${title}</h2>
                <p style="color: var(--text-secondary); white-space: pre-wrap;">${content}</p>
            `;
        }

        titleInput.addEventListener('input', updatePreview);
        contentInput.addEventListener('input', updatePreview);
        categorySelect.addEventListener('change', updatePreview);

        // Initial preview
        updatePreview();
    </script>
</body>
</html>
