<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
    <div class="app-layout">
        <!-- Include Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <div class="main-header">
                <h1><span class="material-icons" style="vertical-align: middle; font-size: 2rem;">event</span> Events Management</h1>
                <p>Browse, create, and manage all events</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'created'}">
                <div class="alert alert-success">✅ Event created successfully!</div>
            </c:if>
            <c:if test="${param.success == 'updated'}">
                <div class="alert alert-success">✅ Event updated successfully!</div>
            </c:if>
            <c:if test="${param.success == 'deleted'}">
                <div class="alert alert-success">✅ Event deleted successfully!</div>
            </c:if>
            <c:if test="${param.success == 'registered'}">
                <div class="alert alert-success">✅ Successfully registered for event!</div>
            </c:if>
            <c:if test="${param.error == 'already_registered'}">
                <div class="alert alert-error">❌ You are already registered for this event.</div>
            </c:if>
            <c:if test="${param.error == 'event_full'}">
                <div class="alert alert-error">❌ Event is full. No more seats available.</div>
            </c:if>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/events?action=create" class="quick-action-card">
                        <div class="quick-action-icon"><span class="material-icons">add_circle</span></div>
                        <div class="quick-action-title">Create Event</div>
                        <div class="quick-action-desc">Add new event</div>
                    </a>
                </c:if>
                <div class="quick-action-card" style="cursor: default;">
                    <div class="quick-action-icon"><span class="material-icons">assessment</span></div>
                    <div class="quick-action-title">${events.size()} Events</div>
                    <div class="quick-action-desc">Total active</div>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="card">
                <form action="${pageContext.request.contextPath}/events" method="get" class="search-bar">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" class="form-control" placeholder="🔍 Search events by title, location..." value="${param.search}">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>

            <!-- Events Grid -->
            <div class="event-grid">
                <c:forEach var="event" items="${events}">
                    <div class="event-card">
                        <div class="event-header">
                            <h3>${event.title}</h3>
                            <div class="event-date">
                                <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">event</span> <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy HH:mm"/>
                            </div>
                        </div>
                        <div class="event-body">
                            <div class="event-info">
                                <div class="event-info-item"><span class="material-icons" style="vertical-align: middle; font-size: 1rem;">location_on</span> ${event.location}</div>
                                <div class="event-info-item">
                                    <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">group</span> ${event.registeredCount}/${event.capacity} registered
                                </div>
                                <div class="event-info-item">
                                    <c:if test="${event.availableSeats > 0}">
                                        <span class="badge badge-success">${event.availableSeats} seats left</span>
                                    </c:if>
                                    <c:if test="${event.availableSeats == 0}">
                                        <span class="badge badge-danger">Full</span>
                                    </c:if>
                                    <span class="badge badge-info">${event.status}</span>
                                </div>
                            </div>
                            <p class="text-muted">${event.description}</p>
                            
                            <!-- Progress Bar -->
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${(event.registeredCount * 100) / event.capacity}%"></div>
                            </div>
                            
                            <div class="event-footer">
                                <c:if test="${sessionScope.role == 'STUDENT' && !event.isFull()}">
                                    <form action="${pageContext.request.contextPath}/events" method="get" style="display: inline;">
                                        <input type="hidden" name="action" value="register">
                                        <input type="hidden" name="eventId" value="${event.id}">
                                        <button type="submit" class="btn btn-success btn-sm">✅ Register</button>
                                    </form>
                                </c:if>
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/events?action=edit&id=${event.id}" 
                                       class="btn btn-primary btn-sm">✏️ Edit</a>
                                    <form action="${pageContext.request.contextPath}/events" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${event.id}">
                                        <button type="submit" class="btn btn-danger btn-sm" 
                                                onclick="return confirm('Delete this event?')">🗑️ Delete</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Empty State -->
            <c:if test="${empty events}">
                <div class="empty-state">
                    <span class="material-icons" style="font-size: 4rem; margin-bottom: 1rem; color: var(--text-muted);">event_busy</span>
                    <h2>No events found</h2>
                    <p>Check back later for upcoming events!</p>
                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/events?action=create" class="btn btn-primary" style="margin-top: 1rem;">Create First Event</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>
</body>
</html>
