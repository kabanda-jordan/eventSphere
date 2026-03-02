<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - EventSphere</title>
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
                <h1>⚙️ Account Settings</h1>
                <p>Manage your account preferences and security</p>
            </div>

            <!-- Profile Settings -->
            <div class="card">
                <div class="card-header">
                    <h2>👤 Profile Information</h2>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" class="form-control" value="${sessionScope.username}" disabled>
                        <small class="text-muted">Username cannot be changed</small>
                    </div>

                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" class="form-control" value="${sessionScope.role}" disabled>
                        <small class="text-muted">Role is assigned by administrators</small>
                    </div>

                    <div class="form-group">
                        <label>User ID</label>
                        <input type="text" class="form-control" value="${sessionScope.userId}" disabled>
                    </div>
                </div>
            </div>

            <!-- Security Settings -->
            <div class="card">
                <div class="card-header">
                    <h2>🔒 Security Settings</h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>🔐 Two-Factor Authentication</h3>
                            <p>Add an extra layer of security to your account</p>
                        </div>
                        <div class="setting-action">
                            <c:choose>
                                <c:when test="${sessionScope.role == 'ADMIN'}">
                                    <span class="badge badge-success">Enabled</span>
                                    <a href="${pageContext.request.contextPath}/enable-2fa-now.jsp" class="btn btn-secondary btn-sm" style="margin-left: 1rem;">Manage 2FA</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-secondary">Not Available</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>🔑 Change Password</h3>
                            <p>Update your password regularly for better security</p>
                        </div>
                        <div class="setting-action">
                            <button class="btn btn-primary btn-sm" onclick="alert('Password change feature coming soon!')">Change Password</button>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>🕐 Session Timeout</h3>
                            <p>Automatically logout after 30 minutes of inactivity</p>
                        </div>
                        <div class="setting-action">
                            <span class="badge badge-info">30 minutes</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notification Settings -->
            <div class="card">
                <div class="card-header">
                    <h2>🔔 Notification Preferences</h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>📧 Email Notifications</h3>
                            <p>Receive email updates about events and registrations</p>
                        </div>
                        <div class="setting-action">
                            <label class="switch">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>🎉 Event Reminders</h3>
                            <p>Get notified before events you're registered for</p>
                        </div>
                        <div class="setting-action">
                            <label class="switch">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>💬 Chat Messages</h3>
                            <p>Receive notifications for new chat messages</p>
                        </div>
                        <div class="setting-action">
                            <label class="switch">
                                <input type="checkbox" checked>
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Appearance Settings -->
            <div class="card">
                <div class="card-header">
                    <h2>🎨 Appearance</h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>🌙 Dark Mode</h3>
                            <p>Currently using dark theme</p>
                        </div>
                        <div class="setting-action">
                            <span class="badge badge-success">Active</span>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>📱 Compact View</h3>
                            <p>Show more content in less space</p>
                        </div>
                        <div class="setting-action">
                            <label class="switch">
                                <input type="checkbox">
                                <span class="slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Danger Zone -->
            <div class="card" style="border-color: var(--danger);">
                <div class="card-header" style="background: rgba(239, 68, 68, 0.1);">
                    <h2>⚠️ Danger Zone</h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3>🗑️ Delete Account</h3>
                            <p>Permanently delete your account and all associated data</p>
                        </div>
                        <div class="setting-action">
                            <button class="btn btn-danger btn-sm" onclick="alert('Please contact an administrator to delete your account.')">Delete Account</button>
                        </div>
                    </div>
                </div>
            </div>

            <style>
                .setting-item {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 1.5rem 0;
                    border-bottom: 1px solid var(--border);
                }
                .setting-item:last-child {
                    border-bottom: none;
                }
                .setting-info h3 {
                    margin: 0 0 0.5rem 0;
                    font-size: 1rem;
                    color: var(--text-primary);
                }
                .setting-info p {
                    margin: 0;
                    font-size: 0.875rem;
                    color: var(--text-muted);
                }
                .setting-action {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                }
                
                /* Toggle Switch */
                .switch {
                    position: relative;
                    display: inline-block;
                    width: 50px;
                    height: 24px;
                }
                .switch input {
                    opacity: 0;
                    width: 0;
                    height: 0;
                }
                .slider {
                    position: absolute;
                    cursor: pointer;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background-color: var(--bg-secondary);
                    transition: 0.3s;
                    border-radius: 24px;
                }
                .slider:before {
                    position: absolute;
                    content: "";
                    height: 18px;
                    width: 18px;
                    left: 3px;
                    bottom: 3px;
                    background-color: white;
                    transition: 0.3s;
                    border-radius: 50%;
                }
                input:checked + .slider {
                    background: var(--gradient-primary);
                }
                input:checked + .slider:before {
                    transform: translateX(26px);
                }
            </style>
        </main>
    </div>
</body>
</html>
