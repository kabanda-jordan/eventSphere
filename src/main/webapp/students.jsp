<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students - EventSphere</title>
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
                        src="https://assets10.lottiefiles.com/packages/lf20_qp1q7mct.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 60px; height: 60px;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <div>
                        <h1><span class="material-icons" style="vertical-align: middle; font-size: 2rem;">group</span> Student Management</h1>
                        <p>View and manage all students in the system</p>
                    </div>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'updated'}">
                <div class="success-message">
                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">check_circle</span>
                    Student updated successfully!
                </div>
            </c:if>
            <c:if test="${param.success == 'deleted'}">
                <div class="success-message">
                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">check_circle</span>
                    Student deleted successfully!
                </div>
            </c:if>
            <c:if test="${param.success == 'created'}">
                <div class="success-message">
                    <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">check_circle</span>
                    Student created successfully!
                </div>
            </c:if>

            <!-- Quick Stats -->
            <div class="mini-stats">
                <div class="mini-stat-card">
                    <lottie-player 
                        src="https://assets10.lottiefiles.com/packages/lf20_qp1q7mct.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 40px; height: 40px;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <div class="mini-stat-value">${students.size()}</div>
                    <div class="mini-stat-label">Total Students</div>
                </div>
                <div class="mini-stat-card">
                    <lottie-player 
                        src="https://assets5.lottiefiles.com/packages/lf20_qmfs6c3i.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 40px; height: 40px;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <div class="mini-stat-value">5</div>
                    <div class="mini-stat-label">Departments</div>
                </div>
                <div class="mini-stat-card">
                    <lottie-player 
                        src="https://assets7.lottiefiles.com/packages/lf20_8wREpI.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 40px; height: 40px;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <div class="mini-stat-value">4</div>
                    <div class="mini-stat-label">Year Levels</div>
                </div>
            </div>

            <!-- Search and Actions -->
            <div class="card">
                <div class="card-body">
                    <div class="flex justify-between align-center" style="gap: 1rem; flex-wrap: wrap;">
                        <form action="${pageContext.request.contextPath}/students" method="get" class="search-bar" style="flex: 1; min-width: 300px;">
                            <input type="hidden" name="action" value="list">
                            <input type="text" name="search" placeholder="Search students by name, email, department..." value="${param.search}">
                            <button type="submit" class="btn btn-primary">
                                <span class="material-icons" style="vertical-align: middle; margin-right: 4px;">search</span>
                                Search
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/students?action=create" class="btn btn-primary" style="white-space: nowrap;">
                            <span class="material-icons" style="vertical-align: middle; margin-right: 4px;">person_add</span>
                            Add New Student
                        </a>
                    </div>
                </div>
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
                                               class="btn btn-primary btn-sm">
                                                <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">edit</span>
                                                Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/students" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${student.id}">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('Delete this student? This will also delete their user account.')">
                                                    <span class="material-icons" style="vertical-align: middle; font-size: 1rem;">delete</span>
                                                    Delete
                                                </button>
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
                    <lottie-player 
                        src="https://assets10.lottiefiles.com/packages/lf20_qp1q7mct.json" 
                        background="transparent" 
                        speed="1" 
                        style="width: 200px; height: 200px; margin: 0 auto 1rem;" 
                        loop 
                        autoplay>
                    </lottie-player>
                    <h2>No students found</h2>
                    <p>No students match your search criteria.</p>
                </div>
            </c:if>
        </main>
    </div>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>
</body>
</html>
