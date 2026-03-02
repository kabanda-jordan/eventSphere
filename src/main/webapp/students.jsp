<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students - EventSphere</title>
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
                <h1>👥 Student Management</h1>
                <p>View and manage all students in the system</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'updated'}">
                <div class="alert alert-success">✅ Student updated successfully!</div>
            </c:if>
            <c:if test="${param.success == 'deleted'}">
                <div class="alert alert-success">✅ Student deleted successfully!</div>
            </c:if>

            <!-- Quick Stats -->
            <div class="mini-stats">
                <div class="mini-stat-card">
                    <div class="mini-stat-icon">👥</div>
                    <div class="mini-stat-value">${students.size()}</div>
                    <div class="mini-stat-label">Total Students</div>
                </div>
                <div class="mini-stat-card">
                    <div class="mini-stat-icon">💻</div>
                    <div class="mini-stat-value">5</div>
                    <div class="mini-stat-label">Departments</div>
                </div>
                <div class="mini-stat-card">
                    <div class="mini-stat-icon">📚</div>
                    <div class="mini-stat-value">4</div>
                    <div class="mini-stat-label">Year Levels</div>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="card">
                <form action="${pageContext.request.contextPath}/students" method="get" class="search-bar">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" class="form-control" placeholder="🔍 Search students by name, email, department..." value="${param.search}">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>

            <!-- Students Table -->
            <div class="card">
                <div class="card-header">
                    <h2>All Students</h2>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Department</th>
                                <th>Year</th>
                                <th>Phone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td>${student.id}</td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                                            <div class="chat-avatar" style="width: 32px; height: 32px; font-size: 0.875rem;">
                                                ${student.fullName.substring(0, 1).toUpperCase()}
                                            </div>
                                            ${student.fullName}
                                        </div>
                                    </td>
                                    <td>${student.username}</td>
                                    <td>${student.email}</td>
                                    <td><span class="badge badge-info">${student.department}</span></td>
                                    <td>Year ${student.year}</td>
                                    <td>${student.phone}</td>
                                    <td>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <a href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}" 
                                               class="btn btn-primary btn-sm">✏️ Edit</a>
                                            <form action="${pageContext.request.contextPath}/students" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${student.id}">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('Delete this student? This will also delete their user account.')">🗑️ Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Empty State -->
            <c:if test="${empty students}">
                <div class="empty-state">
                    <div style="font-size: 4rem; margin-bottom: 1rem;">👥</div>
                    <h2>No students found</h2>
                    <p>No students match your search criteria.</p>
                </div>
            </c:if>
        </main>
    </div>
</body>
</html>
