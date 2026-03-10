<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - EventSphere</title>
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
        
        .reset-container {
            background: var(--bg-card);
            border: 2px solid var(--border-color);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            box-shadow: var(--shadow-xl);
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo-section h1 {
            background: var(--gradient-success);
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
        
        .password-input-wrapper {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--text-muted);
        }
        
        .btn-submit {
            width: 100%;
            padding: 16px;
            background: var(--gradient-success);
            color: white;
            border: none;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-success);
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(16, 185, 129, 0.5);
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--danger-light);
        }
        
        .success-message {
            background: rgba(16, 185, 129, 0.1);
            border-left: 4px solid var(--success);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--success-light);
        }
        
        .password-requirements {
            background: rgba(59, 130, 246, 0.1);
            border-left: 4px solid var(--accent);
            padding: 12px;
            margin-top: 10px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
        
        .password-requirements ul {
            margin: 8px 0 0 0;
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <div class="reset-container animate-fade-in">
        <!-- Lottie Animation -->
        <div class="lottie-container lottie-medium" style="margin: 0 auto 20px;">
            <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
            <lottie-player 
                src="https://assets9.lottiefiles.com/packages/lf20_xyadoh9h.json" 
                background="transparent" 
                speed="1" 
                style="width: 150px; height: 150px; margin: 0 auto;" 
                loop 
                autoplay>
            </lottie-player>
        </div>
        
        <div class="logo-section">
            <h1>
                <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle;">vpn_key</span>
                Reset Password
            </h1>
            <p style="color: var(--text-secondary);">Enter verification code and new password</p>
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
        
        <form action="<%= request.getContextPath() %>/reset-password" method="post">
            <div class="form-group">
                <label for="email">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">email</span>
                    Email Address
                </label>
                <input 
                    type="email" 
                    id="email" 
                    name="email" 
                    placeholder="Your email" 
                    required
                    autocomplete="email">
            </div>
            
            <div class="form-group">
                <label for="code">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">pin</span>
                    Verification Code
                </label>
                <input 
                    type="text" 
                    id="code" 
                    name="code" 
                    placeholder="Enter 6-digit code" 
                    maxlength="6"
                    pattern="[0-9]{6}"
                    required
                    autocomplete="off">
            </div>
            
            <div class="form-group">
                <label for="newPassword">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">lock</span>
                    New Password
                </label>
                <div class="password-input-wrapper">
                    <input 
                        type="password" 
                        id="newPassword" 
                        name="newPassword" 
                        placeholder="Enter new password" 
                        required
                        minlength="8"
                        autocomplete="new-password">
                    <span class="material-icons toggle-password" onclick="togglePassword('newPassword')">visibility</span>
                </div>
                <div class="password-requirements">
                    <strong>Password must contain:</strong>
                    <ul>
                        <li>At least 8 characters</li>
                        <li>Mix of letters and numbers recommended</li>
                    </ul>
                </div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">
                    <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">lock_outline</span>
                    Confirm New Password
                </label>
                <div class="password-input-wrapper">
                    <input 
                        type="password" 
                        id="confirmPassword" 
                        name="confirmPassword" 
                        placeholder="Confirm new password" 
                        required
                        minlength="8"
                        autocomplete="new-password">
                    <span class="material-icons toggle-password" onclick="togglePassword('confirmPassword')">visibility</span>
                </div>
            </div>
            
            <button type="submit" class="btn-submit">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">check_circle</span>
                Reset Password
            </button>
        </form>
    </div>
    
    <script>
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = input.nextElementSibling;
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.textContent = 'visibility_off';
            } else {
                input.type = 'password';
                icon.textContent = 'visibility';
            }
        }
        
        // Validate passwords match
        document.querySelector('form').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    </script>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle auth-page" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>
</body>
</html>
