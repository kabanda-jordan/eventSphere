<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Two-Factor Authentication - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/new-design.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-toggle.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <script src="${pageContext.request.contextPath}/js/theme-toggle.js"></script>
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
        
        .verify-container {
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
        
        .otp-container {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin: 2rem 0;
            flex-wrap: wrap;
        }
        
        .otp-input {
            width: 60px;
            height: 60px;
            font-size: 2rem;
            text-align: center;
            border: 2px solid var(--border-color);
            border-radius: 0 !important;
            background: var(--bg-tertiary);
            color: var(--text-primary);
            font-weight: 700;
            transition: all 0.3s ease;
        }
        
        .otp-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            background: var(--bg-card);
        }
        
        .otp-input.filled {
            border-color: var(--success);
            background: rgba(16, 185, 129, 0.1);
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
            border-radius: 0 !important;
            margin-top: 1rem;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(99, 102, 241, 0.5);
        }
        
        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .info-message {
            background: rgba(59, 130, 246, 0.1);
            border-left: 4px solid var(--accent);
            padding: 16px;
            margin-bottom: 20px;
            color: var(--accent-light);
            border-radius: 0 !important;
        }
        
        .warning-message {
            background: rgba(245, 158, 11, 0.1);
            border-left: 4px solid var(--warning);
            padding: 16px;
            margin-top: 20px;
            color: var(--warning-light);
            border-radius: 0 !important;
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            padding: 12px;
            margin-bottom: 20px;
            color: var(--danger-light);
            border-radius: 0 !important;
        }
        
        .back-link {
            text-align: center;
            margin-top: 25px;
        }
        
        .back-link a {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        
        .back-link a:hover {
            color: var(--primary);
        }
        
        .countdown {
            text-align: center;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--warning);
            margin-top: 15px;
        }
        
        @media (max-width: 480px) {
            .otp-input {
                width: 45px;
                height: 45px;
                font-size: 1.5rem;
            }
            
            .verify-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="verify-container animate-fade-in">
        <!-- Lottie Animation -->
        <div class="lottie-container lottie-medium" style="margin: 0 auto 20px;">
            <lottie-player 
                src="https://assets9.lottiefiles.com/packages/lf20_xyadoh9h.json" 
                background="transparent" 
                speed="1" 
                style="width: 120px; height: 120px; margin: 0 auto;" 
                loop 
                autoplay>
            </lottie-player>
        </div>
        
        <div class="logo-section">
            <h1>
                <span class="material-icons" style="font-size: 2.5rem; vertical-align: middle;">security</span>
                Two-Factor Authentication
            </h1>
            <p style="color: var(--text-secondary);">Enter the 6-digit code sent to your email</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">error</span>
                ${error}
            </div>
        </c:if>

        <div class="info-message">
            <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 8px;">
                <span class="material-icons">email</span>
                <strong>Verification Code Sent</strong>
            </div>
            <p>A 6-digit verification code has been sent to your email address.</p>
            <small style="opacity: 0.8;">Check your inbox or console/logs for the code.</small>
        </div>

        <form action="${pageContext.request.contextPath}/login" method="post" id="otpForm">
            <input type="hidden" name="action" value="verify2fa">
            
            <div class="otp-container">
                <input type="text" class="otp-input" maxlength="1" id="otp1" autocomplete="off" autofocus>
                <input type="text" class="otp-input" maxlength="1" id="otp2" autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" id="otp3" autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" id="otp4" autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" id="otp5" autocomplete="off">
                <input type="text" class="otp-input" maxlength="1" id="otp6" autocomplete="off">
            </div>
            
            <input type="hidden" name="otp" id="otpValue">

            <button type="submit" class="btn-submit" id="submitBtn">
                <span class="material-icons" style="vertical-align: middle; margin-right: 8px;">verified_user</span>
                Verify Code
            </button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login.jsp">
                <span class="material-icons" style="vertical-align: middle; font-size: 1.2rem;">arrow_back</span>
                Back to Login
            </a>
        </div>

        <div class="warning-message">
            <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 8px;">
                <span class="material-icons">schedule</span>
                <strong>Code Expires in <span id="countdown">5:00</span></strong>
            </div>
            <p>Didn't receive the code? Go back and try logging in again.</p>
        </div>
    </div>

    <!-- Theme Toggle Button -->
    <button class="theme-toggle auth-page" id="themeToggle" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
        <span class="material-icons" id="themeIcon">light_mode</span>
    </button>

    <script>
        const inputs = document.querySelectorAll('.otp-input');
        const form = document.getElementById('otpForm');
        const otpValue = document.getElementById('otpValue');

        // Auto-focus next input
        inputs.forEach((input, index) => {
            input.addEventListener('input', (e) => {
                if (e.target.value.length === 1) {
                    if (index < inputs.length - 1) {
                        inputs[index + 1].focus();
                    } else {
                        // All inputs filled, combine and submit
                        combineOTP();
                    }
                }
            });

            // Handle backspace
            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && e.target.value === '' && index > 0) {
                    inputs[index - 1].focus();
                }
            });

            // Only allow numbers
            input.addEventListener('keypress', (e) => {
                if (!/[0-9]/.test(e.key)) {
                    e.preventDefault();
                }
            });
        });

        // Combine OTP values
        function combineOTP() {
            let otp = '';
            inputs.forEach(input => {
                otp += input.value;
            });
            otpValue.value = otp;
        }

        // Submit form
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            combineOTP();
            
            if (otpValue.value.length === 6) {
                form.submit();
            } else {
                alert('Please enter all 6 digits');
            }
        });

        // Paste support
        inputs[0].addEventListener('paste', (e) => {
            e.preventDefault();
            const pastedData = e.clipboardData.getData('text').slice(0, 6);
            
            for (let i = 0; i < pastedData.length; i++) {
                if (inputs[i]) {
                    inputs[i].value = pastedData[i];
                }
            }
            
            if (pastedData.length === 6) {
                combineOTP();
            }
        });

        // Countdown Timer (5 minutes)
        let timeLeft = 300; // 5 minutes in seconds
        const countdownElement = document.getElementById('countdown');
        
        function updateCountdown() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            countdownElement.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                countdownElement.textContent = 'EXPIRED';
                countdownElement.style.color = 'var(--danger)';
                document.getElementById('submitBtn').disabled = true;
                document.getElementById('submitBtn').textContent = 'Code Expired';
                inputs.forEach(input => input.disabled = true);
            } else {
                timeLeft--;
            }
        }
        
        // Start countdown
        updateCountdown();
        const countdownInterval = setInterval(updateCountdown, 1000);
        
        // Visual feedback for filled inputs
        inputs.forEach(input => {
            input.addEventListener('input', () => {
                if (input.value.length === 1) {
                    input.classList.add('filled');
                } else {
                    input.classList.remove('filled');
                }
            });
        });
    </script>
</body>
</html>
