<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EventSphere</title>
    <link rel="stylesheet" href="css/new-design.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/theme-toggle.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <script src="js/theme-toggle.js"></script>
    <style>
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
        
        .login-container {
            background: var(--bg-card);
            border: 2px solid var(--border-color);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: var(--shadow-xl);
            border-radius: 20px;
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
            margin-bottom: 24px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-secondary);
            font-weight: 600;
        }
        
        .captcha-container {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .captcha-image {
            border: 2px solid var(--border-color);
            border-radius: 8px;
        }
        
        .captcha-input {
            flex: 1;
        }
        
        .btn-submit {
            width: 100%;
            padding: 16px;
            background: var(--gradient-primary);
            color: white;
            border: none;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-primary);
            border-radius: 12px;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(99, 102, 241, 0.5);
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
        }
        
        .links-section a:hover {
            color: var(--primary-light);
        }
        
        .forgot-password {
            color: var(--secondary) !important;
        }
        
        .forgot-password:hover {
            color: var(--secondary-light) !important;
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--danger-light);
            border-radius: 8px;
        }
        
        .success-message {
            background: rgba(16, 185, 129, 0.1);
            border-left: 4px solid var(--success);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--success-light);
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="login-container animate-fade-in">
        <!-- Lottie Animation -->
        <div class="lottie-container lottie-medium" style="margin: 0 auto 20px;">
            <lottie-player 
                src="https://assets2.lottiefiles.com/packages/lf20_uu0x8lqv.json" 
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
            <p style="color: var(--text-secondary);">Welcome back! Please sign in to your account</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">error</span>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">check_circle</span>
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label for="username">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">person</span>
                    Username
                </label>
                <input 
                    type="text" 
                    id="username" 
                    name="username" 
                    placeholder="Enter your username" 
                    required
                    autocomplete="username">
            </div>
            
            <div class="form-group">
                <label for="password">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">lock</span>
                    Password
                </label>
                <input 
                    type="password" 
                    id="password" 
                    name="password" 
                    placeholder="Enter your password" 
                    required
                    autocomplete="current-password">
            </div>
            
            <div class="captcha-container">
                <img src="<%= request.getContextPath() %>/captcha" 
                     alt="CAPTCHA" 
                     class="captcha-image"
                     onclick="this.src='<%= request.getContextPath() %>/captcha?' + Math.random()">
                <input 
                    type="text" 
                    name="captcha" 
                    placeholder="Enter CAPTCHA" 
                    class="captcha-input"
                    required
                    autocomplete="off">
            </div>
            
            <button type="submit" class="btn-submit">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">login</span>
                Sign In
            </button>
        </form>
        
        <div class="links-section">
            <a href="<%= request.getContextPath() %>/forgot-password" class="forgot-password">
                <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">lock_reset</span>
                Forgot Password?
            </a>
            <br><br>
            <a href="<%= request.getContextPath() %>/register.jsp">
                <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">person_add</span>
                Create Account
            </a>
            |
            <a href="<%= request.getContextPath() %>/">
                <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">home</span>
                Back to Home
            </a>
        </div>
    </div>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle auth-page" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>
</body>
</html>