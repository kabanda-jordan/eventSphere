<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - EventSphere</title>
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
                    src="https://assets5.lottiefiles.com/packages/lf20_DMgKk1.json" 
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
                    <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle; margin-right: 12px; color: var(--primary);">settings</span>
                    Account Settings
                </h1>
                <p style="color: var(--text-secondary);">Manage your account preferences and security</p>
            </div>

            <!-- Profile Settings -->
            <div class="card animate-fade-in">
                <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--text-primary);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">person</span>
                        Profile Information
                    </h2>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">account_circle</span>
                            Username
                        </label>
                        <input type="text" class="form-control" value="${sessionScope.username}" disabled>
                        <small style="color: var(--text-muted);">Username cannot be changed</small>
                    </div>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">admin_panel_settings</span>
                            Role
                        </label>
                        <input type="text" class="form-control" value="${sessionScope.role}" disabled>
                        <small style="color: var(--text-muted);">Role is assigned by administrators</small>
                    </div>

                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 8px; color: var(--text-primary); font-weight: 600;">
                            <span class="material-icons">badge</span>
                            User ID
                        </label>
                        <input type="text" class="form-control" value="${sessionScope.userId}" disabled>
                    </div>
                </div>
            </div>

            <!-- Security Settings -->
            <div class="card animate-fade-in">
                <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--text-primary);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">security</span>
                        Security Settings
                    </h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">verified_user</span>
                                Two-Factor Authentication
                            </h3>
                            <p>Add an extra layer of security to your account</p>
                        </div>
                        <div class="setting-action">
                            <c:choose>
                                <c:when test="${sessionScope.role == 'ADMIN'}">
                                    <span class="badge" style="background: var(--gradient-success); color: white; padding: 8px 16px;">Enabled</span>
                                    <a href="${pageContext.request.contextPath}/enable-2fa-now.jsp" class="btn btn-secondary btn-sm" style="margin-left: 1rem;">Manage 2FA</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge" style="background: var(--bg-tertiary); color: var(--text-muted); padding: 8px 16px;">Not Available</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">lock</span>
                                Change Password
                            </h3>
                            <p>Update your password regularly for better security</p>
                        </div>
                        <div class="setting-action">
                            <button class="btn btn-primary btn-sm" onclick="alert('Password change feature coming soon!')">Change Password</button>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">schedule</span>
                                Session Timeout
                            </h3>
                            <p>Automatically logout after 30 minutes of inactivity</p>
                        </div>
                        <div class="setting-action">
                            <span class="badge" style="background: var(--gradient-accent); color: white; padding: 8px 16px;">30 minutes</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notification Settings -->
            <div class="card animate-fade-in">
                <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--text-primary);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">notifications</span>
                        Notification Preferences
                    </h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">email</span>
                                Email Notifications
                            </h3>
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
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">event</span>
                                Event Reminders
                            </h3>
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
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">chat</span>
                                Chat Messages
                            </h3>
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
            <div class="card animate-fade-in">
                <div class="card-header" style="border-bottom: 2px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--text-primary);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">palette</span>
                        Appearance
                    </h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">dark_mode</span>
                                Dark Mode
                            </h3>
                            <p>Currently using dark theme</p>
                        </div>
                        <div class="setting-action">
                            <span class="badge" style="background: var(--gradient-success); color: white; padding: 8px 16px;">Active</span>
                        </div>
                    </div>

                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px;">
                                <span class="material-icons">view_compact</span>
                                Compact View
                            </h3>
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
            <div class="card animate-fade-in" style="border: 2px solid var(--danger);">
                <div class="card-header" style="background: rgba(239, 68, 68, 0.1); border-bottom: 2px solid var(--danger); padding-bottom: 1rem; margin-bottom: 2rem;">
                    <h2 style="color: var(--danger);">
                        <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">warning</span>
                        Danger Zone
                    </h2>
                </div>
                <div class="card-body">
                    <div class="setting-item">
                        <div class="setting-info">
                            <h3 style="display: flex; align-items: center; gap: 8px; color: var(--danger);">
                                <span class="material-icons">delete_forever</span>
                                Delete Account
                            </h3>
                            <p>Permanently delete your account and all associated data</p>
                        </div>
                        <div class="setting-action">
                            <button class="btn btn-danger btn-sm" onclick="alert('Please contact an administrator to delete your account.')">
                                <span class="material-icons" style="vertical-align: middle; margin-right: 4px; font-size: 1rem;">delete</span>
                                Delete Account
                            </button>
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
