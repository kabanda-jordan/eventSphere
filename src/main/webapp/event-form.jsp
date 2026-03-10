<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty event ? 'Create' : 'Edit'} Event - EventSphere</title>
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
                    src="https://assets1.lottiefiles.com/packages/lf20_jcikwtux.json" 
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
                    <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle; margin-right: 12px; color: var(--primary);">${empty event ? 'add_circle' : 'edit'}</span>
                    ${empty event ? 'Create New Event' : 'Edit Event'}
                </h1>
                <p style="color: var(--text-secondary);">${empty event ? 'Fill in the details to create a new event' : 'Update event information'}</p>
            </div>

            <!-- Form Card -->
            <div class="card animate-fade-in" style="max-width: 800px; margin: 0 auto;">
                <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--text-primary);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">event</span>
                        ${empty event ? 'Event Details' : 'Update Event'}
                    </h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/events" method="post">
                        <input type="hidden" name="action" value="${empty event ? 'create' : 'update'}">
                        <c:if test="${not empty event}">
                            <input type="hidden" name="id" value="${event.id}">
                        </c:if>

                        <div class="form-group">
                            <label for="title" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                                <span class="material-icons">title</span>
                                Event Title
                            </label>
                            <input type="text" id="title" name="title" class="form-control" 
                                   value="${event.title}" placeholder="e.g., Tech Conference 2026" required>
                        </div>

                        <div class="form-group">
                            <label for="description" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                                <span class="material-icons">description</span>
                                Description
                            </label>
                            <textarea id="description" name="description" class="form-control" rows="6"
                                      placeholder="Describe what this event is about..." required>${event.description}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="eventDate" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                                <span class="material-icons">schedule</span>
                                Event Date & Time
                            </label>
                            <input type="datetime-local" id="eventDate" name="eventDate" class="form-control" 
                                   value="<fmt:formatDate value='${event.eventDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" required>
                        </div>

                        <div class="form-group">
                            <label for="location" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                                <span class="material-icons">location_on</span>
                                Location
                            </label>
                            <input type="text" id="location" name="location" class="form-control" 
                                   value="${event.location}" placeholder="e.g., Main Auditorium, Building A" required>
                        </div>

                        <div class="form-group">
                            <label for="capacity" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                                <span class="material-icons">group</span>
                                Capacity
                            </label>
                            <input type="number" id="capacity" name="capacity" class="form-control" 
                                   value="${event.capacity}" placeholder="Maximum number of attendees" min="1" required>
                            <small style="color: var(--text-muted); display: flex; align-items: center; gap: 4px; margin-top: 8px;">
                                <span class="material-icons" style="font-size: 1rem;">info</span>
                                How many people can attend this event?
                            </small>
                        </div>

                        <c:if test="${not empty event}">
                            <div class="form-group">
                                <label for="status" style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                                    <span class="material-icons">assessment</span>
                                    Status
                                </label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="ACTIVE" ${event.status == 'ACTIVE' ? 'selected' : ''}>
                                        ✅ Active
                                    </option>
                                    <option value="CANCELLED" ${event.status == 'CANCELLED' ? 'selected' : ''}>
                                        ❌ Cancelled
                                    </option>
                                    <option value="COMPLETED" ${event.status == 'COMPLETED' ? 'selected' : ''}>
                                        ✔️ Completed
                                    </option>
                                </select>
                            </div>
                        </c:if>

                        <div style="display: flex; gap: 0.5rem; margin-top: 2rem; flex-wrap: wrap;">
                            <button type="submit" class="btn btn-primary">
                                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">${empty event ? 'add_circle' : 'save'}</span>
                                ${empty event ? 'Create Event' : 'Update Event'}
                            </button>
                            <a href="${pageContext.request.contextPath}/events?action=list" class="btn btn-secondary">
                                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">cancel</span>
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Help Card -->
            <div class="card animate-fade-in" style="max-width: 800px; margin: 2rem auto; background: rgba(59, 130, 246, 0.1); border: 2px solid var(--accent);">
                <div class="card-body">
                    <h3 style="color: var(--accent); margin-bottom: 1rem;">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">lightbulb</span>
                        Tips
                    </h3>
                    <ul style="color: var(--text-secondary); line-height: 1.8;">
                        <li>Choose a clear, descriptive title that tells people what the event is about</li>
                        <li>Include important details in the description (agenda, speakers, requirements)</li>
                        <li>Set a realistic capacity based on venue size</li>
                        <li>Double-check the date and time before creating</li>
                    </ul>
                </div>
            </div>
        </main>
    </div>
</body>
</html>