<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/new-design.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-toggle.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <script src="${pageContext.request.contextPath}/js/theme-toggle.js"></script>
    <style>
        /* Light Mode Variables */
        [data-theme="light"] {
            --bg-primary: #F8FAFC;
            --bg-secondary: #FFFFFF;
            --bg-tertiary: #F1F5F9;
            --bg-card: #FFFFFF;
            --bg-hover: #F1F5F9;
            --bg-active: #E2E8F0;
            
            --text-primary: #0F172A;
            --text-secondary: #334155;
            --text-muted: #64748B;
            --text-disabled: #94A3B8;
            
            --border-color: #E2E8F0;
            --border-light: #CBD5E1;
            --border-dark: #94A3B8;
            
            --shadow-primary: 0 4px 20px rgba(99, 102, 241, 0.2);
            --shadow-secondary: 0 4px 20px rgba(249, 115, 22, 0.2);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 0 40px rgba(99, 102, 241, 0.1);
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: var(--gradient-bg);
            padding: 20px;
            transition: all 0.3s ease;
        }
        
        [data-theme="light"] body {
            background: linear-gradient(135deg, #F8FAFC 0%, #E0E7FF 50%, #F1F5F9 100%);
        }
        
        .register-container {
            background: var(--bg-card);
            border: 2px solid var(--border-color);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            box-shadow: var(--shadow-xl);
            border-radius: 0 !important;
            transition: all 0.3s ease;
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo-section h1 {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-secondary);
            font-weight: 600;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        .btn-submit {
            width: 100%;
            padding: 16px;
            background: var(--gradient-secondary);
            color: white;
            border: none;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-secondary);
            border-radius: 0 !important;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(249, 115, 22, 0.5);
        }
        
        .links-section {
            text-align: center;
            margin-top: 25px;
        }
        
        .links-section a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            margin: 0 10px;
            transition: color 0.3s ease;
        }
        
        .links-section a:hover {
            color: var(--primary-light);
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--danger-light);
            border-radius: 0 !important;
        }
        
        .success-message {
            background: rgba(16, 185, 129, 0.1);
            border-left: 4px solid var(--success);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--success-light);
            border-radius: 0 !important;
        }
        
        /* Theme Toggle Button */
        .theme-toggle {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: var(--gradient-primary);
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            box-shadow: var(--shadow-lg);
            transition: all 0.3s ease;
            z-index: 1000;
            border-radius: 0 !important;
        }
        
        .theme-toggle:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }
        
        .theme-toggle .material-icons {
            font-size: 1.8rem;
        }
    </style>
</head>
<body>
    <div class="register-container animate-fade-in">
        <!-- Lottie Animation -->
        <div class="lottie-container lottie-medium" style="margin: 0 auto 20px;">
            <lottie-player 
                src="https://assets3.lottiefiles.com/packages/lf20_touohxv0.json" 
                background="transparent" 
                speed="1" 
                style="width: 120px; height: 120px; margin: 0 auto;" 
                loop 
                autoplay>
            </lottie-player>
        </div>
        
        <div class="logo-section">
            <h1>
                <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle;">event_available</span>
                EventSphere
            </h1>
            <p style="color: var(--text-secondary);">Create your account and join the community</p>
        </div>

        
        <c:if test="${not empty error}">
            <div class="error-message">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">error</span>
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="success-message">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">check_circle</span>
                ${success}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="username">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">person</span>
                    Username
                </label>
                <input type="text" id="username" name="username" 
                       placeholder="Choose a username" required>
            </div>

            <div class="form-group">
                <label for="email">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">email</span>
                    Email
                </label>
                <input type="email" id="email" name="email" 
                       placeholder="your.email@example.com" required>
            </div>

            <div class="form-group">
                <label for="fullName">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">badge</span>
                    Full Name
                </label>
                <input type="text" id="fullName" name="fullName" 
                       placeholder="Your full name" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="department">
                        <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">school</span>
                        Department
                    </label>
                    <select id="department" name="department" required>
                        <option value="">Select Department</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Engineering">Engineering</option>
                        <option value="Business">Business</option>
                        <option value="Arts">Arts</option>
                        <option value="Science">Science</option>
                        <option value="Medicine">Medicine</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="year">
                        <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">grade</span>
                        Year
                    </label>
                    <select id="year" name="year" required>
                        <option value="">Select Year</option>
                        <option value="1">1st Year</option>
                        <option value="2">2nd Year</option>
                        <option value="3">3rd Year</option>
                        <option value="4">4th Year</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="phone">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">phone</span>
                    Phone Number
                </label>
                <input type="tel" id="phone" name="phone" 
                       placeholder="555-0123">
            </div>

            <div class="form-group">
                <label for="password">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">lock</span>
                    Password
                </label>
                <input type="password" id="password" name="password" 
                       placeholder="Create a password" required minlength="6">
            </div>

            <div class="form-group">
                <label for="confirmPassword">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">lock_outline</span>
                    Confirm Password
                </label>
                <input type="password" id="confirmPassword" name="confirmPassword" 
                       placeholder="Confirm your password" required minlength="6">
            </div>

            <button type="submit" class="btn-submit">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">person_add</span>
                Create Account
            </button>
        </form>

        <div class="links-section">
            <a href="${pageContext.request.contextPath}/login.jsp">
                <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">login</span>
                Already have an account? Sign In
            </a>
            <br><br>
            <a href="${pageContext.request.contextPath}/">
                <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">home</span>
                Back to Home
            </a>
        </div>
    </div>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle auth-page" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }
        });
    </script>
</body>
</html>
