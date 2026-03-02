<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty event ? 'Create' : 'Edit'} Event - EventSphere</title>
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
                <h1>${empty event ? '➕ Create New Event' : '✏️ Edit Event'}</h1>
                <p>${empty event ? 'Fill in the details to create a new event' : 'Update event information'}</p>
            </div>

            <!-- Form Card -->
            <div class="card" style="max-width: 800px; margin: 0 auto;">
                <div class="card-header">
                    <h2>${empty event ? 'Event Details' : 'Update Event'}</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/events" method="post">
                        <input type="hidden" name="action" value="${empty event ? 'create' : 'update'}">
                        <c:if test="${not empty event}">
                            <input type="hidden" name="id" value="${event.id}">
                        </c:if>

                        <div class="form-group">
                            <label for="title">📝 Event Title</label>
                            <input type="text" id="title" name="title" class="form-control" 
                                   value="${event.title}" placeholder="e.g., Tech Conference 2026" required>
                        </div>

                        <div class="form-group">
                            <label for="description">📄 Description</label>
                            <textarea id="description" name="description" class="form-control" 
                                      placeholder="Describe what this event is about..." required>${event.description}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="eventDate">📅 Event Date & Time</label>
                            <input type="datetime-local" id="eventDate" name="eventDate" class="form-control" 
                                   value="<fmt:formatDate value='${event.eventDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/>" required>
                        </div>

                        <div class="form-group">
                            <label for="location">📍 Location</label>
                            <input type="text" id="location" name="location" class="form-control" 
                                   value="${event.location}" placeholder="e.g., Main Auditorium, Building A" required>
                        </div>

                        <div class="form-group">
                            <label for="capacity">👥 Capacity</label>
                            <input type="number" id="capacity" name="capacity" class="form-control" 
                                   value="${event.capacity}" placeholder="Maximum number of attendees" min="1" required>
                            <small class="text-muted">How many people can attend this event?</small>
                        </div>

                        <c:if test="${not empty event}">
                            <div class="form-group">
                                <label for="status">📊 Status</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="ACTIVE" ${event.status == 'ACTIVE' ? 'selected' : ''}>✅ Active</option>
                                    <option value="CANCELLED" ${event.status == 'CANCELLED' ? 'selected' : ''}>❌ Cancelled</option>
                                    <option value="COMPLETED" ${event.status == 'COMPLETED' ? 'selected' : ''}>✔️ Completed</option>
                                </select>
                            </div>
                        </c:if>

                        <div class="flex gap-2" style="margin-top: 2rem;">
                            <button type="submit" class="btn btn-primary">
                                ${empty event ? '➕ Create Event' : '💾 Update Event'}
                            </button>
                            <a href="${pageContext.request.contextPath}/events?action=list" class="btn btn-secondary">❌ Cancel</a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Help Card -->
            <div class="card" style="max-width: 800px; margin: 2rem auto; background: rgba(59, 130, 246, 0.1); border-color: var(--info);">
                <div class="card-body">
                    <h3 style="color: var(--info); margin-bottom: 1rem;">💡 Tips</h3>
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
