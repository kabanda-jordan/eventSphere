<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - EventSphere</title>
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
                <h1>✏️ Edit Student</h1>
                <p>Update student information</p>
            </div>

            <!-- Form Card -->
            <div class="card" style="max-width: 800px; margin: 0 auto;">
                <div class="card-header">
                    <h2>Student Details</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/students" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${student.id}">

                        <!-- User Info (Read-only) -->
                        <div class="form-group">
                            <label>👤 Username</label>
                            <input type="text" class="form-control" value="${student.username}" disabled>
                            <small class="text-muted">Username cannot be changed</small>
                        </div>

                        <div class="form-group">
                            <label>📧 Email</label>
                            <input type="email" class="form-control" value="${student.email}" disabled>
                            <small class="text-muted">Email cannot be changed</small>
                        </div>

                        <!-- Editable Fields -->
                        <div class="form-group">
                            <label for="fullName">📝 Full Name</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" 
                                   value="${student.fullName}" placeholder="Enter full name" required>
                        </div>

                        <div class="form-group">
                            <label for="department">🏫 Department</label>
                            <select id="department" name="department" class="form-control" required>
                                <option value="">Select Department</option>
                                <option value="Computer Science" ${student.department == 'Computer Science' ? 'selected' : ''}>💻 Computer Science</option>
                                <option value="Engineering" ${student.department == 'Engineering' ? 'selected' : ''}>⚙️ Engineering</option>
                                <option value="Business" ${student.department == 'Business' ? 'selected' : ''}>💼 Business</option>
                                <option value="Arts" ${student.department == 'Arts' ? 'selected' : ''}>🎨 Arts</option>
                                <option value="Science" ${student.department == 'Science' ? 'selected' : ''}>🔬 Science</option>
                                <option value="Medicine" ${student.department == 'Medicine' ? 'selected' : ''}>⚕️ Medicine</option>
                                <option value="Law" ${student.department == 'Law' ? 'selected' : ''}>⚖️ Law</option>
                                <option value="Education" ${student.department == 'Education' ? 'selected' : ''}>📚 Education</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="year">📅 Year Level</label>
                            <select id="year" name="year" class="form-control" required>
                                <option value="">Select Year</option>
                                <option value="1" ${student.year == 1 ? 'selected' : ''}>1️⃣ 1st Year (Freshman)</option>
                                <option value="2" ${student.year == 2 ? 'selected' : ''}>2️⃣ 2nd Year (Sophomore)</option>
                                <option value="3" ${student.year == 3 ? 'selected' : ''}>3️⃣ 3rd Year (Junior)</option>
                                <option value="4" ${student.year == 4 ? 'selected' : ''}>4️⃣ 4th Year (Senior)</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="phone">📱 Phone Number</label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   value="${student.phone}" placeholder="e.g., +1 234 567 8900">
                            <small class="text-muted">Optional - Include country code if international</small>
                        </div>

                        <div class="flex gap-2" style="margin-top: 2rem;">
                            <button type="submit" class="btn btn-primary">💾 Update Student</button>
                            <a href="${pageContext.request.contextPath}/students?action=list" class="btn btn-secondary">❌ Cancel</a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Student Info Card -->
            <div class="card" style="max-width: 800px; margin: 2rem auto;">
                <div class="card-header">
                    <h2>📊 Student Statistics</h2>
                </div>
                <div class="card-body">
                    <div class="mini-stats">
                        <div class="mini-stat-card">
                            <div class="mini-stat-icon">🎉</div>
                            <div class="mini-stat-value">0</div>
                            <div class="mini-stat-label">Events Attended</div>
                        </div>
                        <div class="mini-stat-card">
                            <div class="mini-stat-icon">📝</div>
                            <div class="mini-stat-value">0</div>
                            <div class="mini-stat-label">Registrations</div>
                        </div>
                        <div class="mini-stat-card">
                            <div class="mini-stat-icon">💬</div>
                            <div class="mini-stat-value">0</div>
                            <div class="mini-stat-label">Messages</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
