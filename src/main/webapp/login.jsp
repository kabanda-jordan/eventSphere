<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>Welcome Back</h1>
                <p>Sign in to your EventSphere account</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" 
                           placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Enter your password" required>
                </div>

                <!-- CAPTCHA Section -->
                <div class="form-group">
                    <label for="captcha">Verification Code</label>
                    <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.5rem;">
                        <img id="captchaImage" src="" alt="CAPTCHA" 
                             style="border: 2px solid var(--border); border-radius: 8px; height: 60px; width: 200px; background: var(--bg-secondary);">
                        <button type="button" onclick="refreshCaptcha()" class="btn btn-secondary btn-sm" 
                                style="width: auto; padding: 0.5rem 1rem;" title="Refresh CAPTCHA">
                            🔄
                        </button>
                    </div>
                    <input type="text" id="captcha" name="captcha" class="form-control" 
                           placeholder="Enter the letters you see above" required maxlength="6"
                           style="text-transform: uppercase;">
                    <small style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.25rem; display: block;">
                        Enter the 6 characters shown in the image above
                    </small>
                </div>

                <button type="submit" class="btn btn-primary">Sign In</button>
            </form>

            <p class="text-center mt-3">
                Don't have an account? 
                <a href="${pageContext.request.contextPath}/register.jsp" style="color: var(--primary); font-weight: 600;">Sign Up</a>
            </p>
        </div>
    </div>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span id="themeIcon">☀️</span>
    </button>

    <script>
        // Initialize theme IMMEDIATELY (before page load)
        (function() {
            const savedTheme = localStorage.getItem('theme') || 'dark';
            document.documentElement.setAttribute('data-theme', savedTheme);
        })();
        
        // Theme Toggle Function
        function toggleTheme() {
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme');
            const newTheme = currentTheme === 'light' ? 'dark' : 'light';
            const themeIcon = document.getElementById('themeIcon');
            
            html.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            
            // Update icon
            themeIcon.textContent = newTheme === 'light' ? '🌙' : '☀️';
        }
        
        // CAPTCHA Functions
        function loadCaptcha() {
            fetch('${pageContext.request.contextPath}/captcha')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('captchaImage').src = data.image;
                })
                .catch(error => {
                    console.error('Error loading CAPTCHA:', error);
                });
        }
        
        function refreshCaptcha() {
            loadCaptcha();
            document.getElementById('captcha').value = '';
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set theme icon based on current theme
            const savedTheme = localStorage.getItem('theme') || 'dark';
            const themeIcon = document.getElementById('themeIcon');
            if (themeIcon) {
                themeIcon.textContent = savedTheme === 'light' ? '🌙' : '☀️';
            }
            
            // Load CAPTCHA
            loadCaptcha();
        });
    </script>
</body>
</html>
