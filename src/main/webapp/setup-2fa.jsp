<%@ page import="java.sql.*" %>
<%@ page import="com.eventsphere.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Setup 2FA - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px; 
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #f1f5f9;
            min-height: 100vh;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            background: rgba(30, 41, 59, 0.8);
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        h1 {
            text-align: center;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 2rem;
        }
        .success { 
            color: #6ee7b7;
            padding: 0.5rem;
            margin: 0.5rem 0;
        }
        .error { 
            color: #fca5a5;
            padding: 1rem;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 8px;
            margin: 1rem 0;
        }
        .info {
            color: #93c5fd;
            padding: 0.5rem;
            margin: 0.5rem 0;
        }
        .final-message {
            background: rgba(99, 102, 241, 0.1);
            padding: 1.5rem;
            border-radius: 12px;
            border-left: 4px solid #6366f1;
            margin: 2rem 0;
        }
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin-top: 1rem;
            transition: transform 0.2s;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔐 Setup Two-Factor Authentication</h1>
    
        <%
            Connection conn = null;
            boolean success = false;
            try {
                conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                
                out.println("<div style='margin: 1rem 0;'>");
                
                // Add 2FA columns
                try {
                    stmt.execute("ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE");
                    out.println("<p class='success'>✅ Added two_factor_enabled column</p>");
                } catch (SQLException e) {
                    if (e.getMessage().contains("Duplicate column")) {
                        out.println("<p class='info'>ℹ️ two_factor_enabled column already exists</p>");
                    } else {
                        throw e;
                    }
                }
                
                try {
                    stmt.execute("ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6)");
                    out.println("<p class='success'>✅ Added two_factor_code column</p>");
                } catch (SQLException e) {
                    if (e.getMessage().contains("Duplicate column")) {
                        out.println("<p class='info'>ℹ️ two_factor_code column already exists</p>");
                    } else {
                        throw e;
                    }
                }
                
                try {
                    stmt.execute("ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL");
                    out.println("<p class='success'>✅ Added two_factor_expiry column</p>");
                } catch (SQLException e) {
                    if (e.getMessage().contains("Duplicate column")) {
                        out.println("<p class='info'>ℹ️ two_factor_expiry column already exists</p>");
                    } else {
                        throw e;
                    }
                }
                
                // Update existing users
                try {
                    int updated = stmt.executeUpdate("UPDATE users SET two_factor_enabled = FALSE WHERE two_factor_enabled IS NULL");
                    if (updated > 0) {
                        out.println("<p class='success'>✅ Updated " + updated + " users to have 2FA disabled by default</p>");
                    }
                } catch (SQLException e) {
                    // Column might not exist yet, ignore
                }
                
                // Enable 2FA for admin (for testing)
                int adminUpdated = stmt.executeUpdate("UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin'");
                out.println("<p class='success'>✅ Enabled 2FA for admin account</p>");
                
                stmt.close();
                out.println("</div>");
                
                success = true;
                
                out.println("<div class='final-message'>");
                out.println("<h2 style='margin-top: 0;'>✅ Two-Factor Authentication Setup Complete!</h2>");
                out.println("<p><strong>2FA is now enabled for the admin account.</strong></p>");
                out.println("<p>📧 When you login as admin, you'll need to enter a 6-digit code.</p>");
                out.println("<p>🖥️ <strong>Check your Tomcat console</strong> to see the simulated email with the code.</p>");
                out.println("<p style='margin-top: 1.5rem;'><strong>Next Steps:</strong></p>");
                out.println("<ol>");
                out.println("<li>Logout from EventSphere (if logged in)</li>");
                out.println("<li>Go to the login page</li>");
                out.println("<li>Login with: <code>admin</code> / <code>admin123</code></li>");
                out.println("<li>You'll see the 2FA verification page</li>");
                out.println("<li>Check Tomcat console for the 6-digit code</li>");
                out.println("<li>Enter the code and verify</li>");
                out.println("</ol>");
                out.println("</div>");
                
                out.println("<div style='text-align: center;'>");
                out.println("<a href='" + request.getContextPath() + "/logout' class='btn'>Logout & Test 2FA</a>");
                out.println("<a href='" + request.getContextPath() + "/login.jsp' class='btn' style='margin-left: 1rem;'>Go to Login</a>");
                out.println("</div>");
                
            } catch (Exception e) {
                out.println("<div class='error'>");
                out.println("<h3>❌ Error Setting Up 2FA</h3>");
                out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
                out.println("<p><strong>Possible Solutions:</strong></p>");
                out.println("<ul>");
                out.println("<li>Make sure XAMPP MySQL is running</li>");
                out.println("<li>Check that the eventsphere database exists</li>");
                out.println("<li>Try running the SQL commands manually in XAMPP</li>");
                out.println("</ul>");
                out.println("</div>");
                
                out.println("<div style='margin-top: 2rem;'>");
                out.println("<h3>Manual Setup Instructions:</h3>");
                out.println("<ol>");
                out.println("<li>Open XAMPP Control Panel</li>");
                out.println("<li>Click 'Shell' button</li>");
                out.println("<li>Type: <code>mysql -u root</code></li>");
                out.println("<li>Run these commands:</li>");
                out.println("</ol>");
                out.println("<pre style='background: #1e293b; padding: 1rem; border-radius: 8px; overflow-x: auto;'>");
                out.println("USE eventsphere;\n");
                out.println("ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;\n");
                out.println("ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6);\n");
                out.println("ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL;\n");
                out.println("UPDATE users SET two_factor_enabled = FALSE;\n");
                out.println("UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';\n");
                out.println("</pre>");
                out.println("</div>");
                
                out.println("<div style='text-align: center; margin-top: 2rem;'>");
                out.println("<a href='" + request.getContextPath() + "/dashboard' class='btn'>Back to Dashboard</a>");
                out.println("</div>");
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
