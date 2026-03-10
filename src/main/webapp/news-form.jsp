<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty news ? 'Post News' : 'Edit News'} - EventSphere</title>
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
                    src="https://assets2.lottiefiles.com/packages/lf20_w51pcehl.json" 
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
                    <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle; margin-right: 12px; color: var(--primary);">${empty news ? 'add_circle' : 'edit'}</span>
                    ${empty news ? 'Post New News' : 'Edit News'}
                </h1>
                <p style="color: var(--text-secondary);">Share important updates and announcements with students</p>
            </div>

            <!-- Form -->
            <div class="card animate-fade-in">
                <form action="${pageContext.request.contextPath}/news" method="post">
                    <input type="hidden" name="action" value="${empty news ? 'create' : 'update'}">
                    <c:if test="${not empty news}">
                        <input type="hidden" name="id" value="${news.id}">
                    </c:if>

                    <div class="form-group">
                        <label for="title" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">title</span>
                            Title *
                        </label>
                        <input type="text" id="title" name="title" class="form-control" 
                               value="${news.title}" placeholder="Enter news title" required>
                    </div>

                    <div class="form-group">
                        <label for="category" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">category</span>
                            Category *
                        </label>
                        <select id="category" name="category" class="form-control" required>
                            <option value="">Select Category</option>
                            <option value="Announcement" ${news.category == 'Announcement' ? 'selected' : ''}>
                                📢 Announcement
                            </option>
                            <option value="Event" ${news.category == 'Event' ? 'selected' : ''}>
                                🎉 Event
                            </option>
                            <option value="News" ${news.category == 'News' ? 'selected' : ''}>
                                📰 News
                            </option>
                            <option value="Workshop" ${news.category == 'Workshop' ? 'selected' : ''}>
                                🎓 Workshop
                            </option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="content" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">article</span>
                            Content *
                        </label>
                        <textarea id="content" name="content" class="form-control" rows="12" 
                                  placeholder="Write your news content here..." required>${news.content}</textarea>
                        <small style="color: var(--text-muted); display: flex; align-items: center; gap: 4px; margin-top: 8px;">
                            <span class="material-icons" style="font-size: 1rem;">info</span>
                            Tip: Write clear and engaging content. Use line breaks for better readability.
                        </small>
                    </div>

                    <div class="form-group">
                        <label for="imageUrl" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">image</span>
                            Image URL (Optional)
                        </label>
                        <input type="url" id="imageUrl" name="imageUrl" class="form-control" 
                               value="${news.imageUrl}" placeholder="https://example.com/image.jpg">
                        <small style="color: var(--text-muted); display: flex; align-items: center; gap: 4px; margin-top: 8px;">
                            <span class="material-icons" style="font-size: 1rem;">info</span>
                            Add an image URL to make your news more attractive
                        </small>
                    </div>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; color: var(--text-primary); font-weight: 600;">
                            <input type="checkbox" name="isFeatured" ${news.featured ? 'checked' : ''} 
                                   style="width: auto; height: auto; margin: 0;">
                            <span class="material-icons" style="color: var(--warning);">star</span>
                            <span>Mark as Featured (appears at the top)</span>
                        </label>
                    </div>

                    <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
                        <button type="submit" class="btn btn-primary">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">${empty news ? 'publish' : 'save'}</span>
                            ${empty news ? 'Publish News' : 'Update News'}
                        </button>
                        <a href="${pageContext.request.contextPath}/news?action=list" class="btn btn-secondary">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">cancel</span>
                            Cancel
                        </a>
                    </div>
                </form>
            </div>

            <!-- Preview Section -->
            <div class="card animate-fade-in">
                <h3 style="margin-bottom: 1rem; color: var(--text-primary);">
                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">preview</span>
                    Preview
                </h3>
                <div id="preview" style="padding: 1.5rem; background: var(--bg-tertiary); border: 2px solid var(--border-color); min-height: 200px;">
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
                    <span class="badge" style="background: var(--gradient-accent); color: white; padding: 8px 16px; font-weight: 600;">
                        <span class="material-icons" style="font-size: 1rem; vertical-align: middle; margin-right: 4px;">category</span>
                        ${category}
                    </span>
                </div>
                <h2 style="margin-bottom: 1rem; background: var(--gradient-primary); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">${title}</h2>
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
