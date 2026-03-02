<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Two-Factor Authentication - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .otp-input {
            width: 60px;
            height: 60px;
            font-size: 2rem;
            text-align: center;
            margin: 0 0.5rem;
            border: 2px solid var(--border);
            border-radius: 12px;
            background: var(--bg-secondary);
            color: var(--text-primary);
            font-weight: 700;
        }
        .otp-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }
        .otp-container {
            display: flex;
            justify-content: center;
            margin: 2rem 0;
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>🔐 Two-Factor Authentication</h1>
                <p>Enter the 6-digit code sent to your email</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="alert alert-info">
                📧 A verification code has been sent to your email address.
                <br>
                <small>Check your console/logs for the simulated email.</small>
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

                <button type="submit" class="btn btn-primary">Verify Code</button>
            </form>

            <p class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/login.jsp" style="color: var(--text-muted);">← Back to Login</a>
            </p>

            <div class="mt-3" style="padding: 1rem; background: rgba(245, 158, 11, 0.1); border-radius: 10px; font-size: 0.875rem; border-left: 4px solid var(--warning);">
                <strong>⏱️ Code expires in 5 minutes</strong><br>
                <small>Didn't receive the code? Go back and try logging in again.</small>
            </div>
        </div>
    </div>

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
    </script>
</body>
</html>
