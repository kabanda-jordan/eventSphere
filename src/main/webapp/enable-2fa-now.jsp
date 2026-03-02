<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.eventsphere.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enable 2FA - EventSphere</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .setup-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
        }
        .status-box {
            padding: 1.5rem;
            border-radius: 12px;
            margin: 1rem 0;
            border-left: 4px solid;
        }
        .status-success {
            background: rgba(34, 197, 94, 0.1);
            border-color: #22c55e;
            color: #22c55e;
        }
        .status-error {
            background: rgba(239, 68, 68, 0.1);
            border-color: #ef4444;
            color: #ef4444;
        }
        .status-warning {
            background: rgba(245, 158, 11, 0.1);
            border-color: #f59e0b;
            color: #f59e0b;
        }
        .sql-box {
            background: #1e293b;
            padding: 1.5rem;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            color: #e2e8f0;
            overflow-x: auto;
            margin: 1rem 0;
        }
        .step {
            background: var(--bg-secondary);
            padding: 1.5rem;
            border-radius: 12px;
            margin: 1rem 0;
            border: 1px solid var(--border);
        }
        .step h3 {
            margin-top: 0;
            color: var(--primary);
        }
    </style>
</head>
<body>
    <div class="setup-container">
        <h1 style="text-align: center; margin-bottom: 2rem;">🔐 Enable Two-Factor Authentication</h1>

        <%
            boolean columnsExist = false;
            boolean adminHas2FA = false;
            String errorMessage = null;
            String action = request.getParameter("action");

            try (Connection conn = DBConnection.getConnection()) {
                // Check if 2FA columns exist
                DatabaseMetaData metaData = conn.getMetaData();
                ResultSet columns = metaData.getColumns(null, null, "users", "two_factor_enabled");
                columnsExist = columns.next();
                columns.close();

                if (columnsExist) {
                    // Check if admin has 2FA enabled
                    String checkSql = "SELECT two_factor_enabled FROM users WHERE username = 'admin'";
                    try (PreparedStatement stmt = conn.prepareStatement(checkSql);
                         ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            adminHas2FA = rs.getBoolean("two_factor_enabled");
                        }
                    }
                }

                // Handle setup action
                if ("setup".equals(action) && !columnsExist) {
                    try {
                        Statement stmt = conn.createStatement();
                        
                        // Add columns
                        stmt.executeUpdate("ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE");
                        stmt.executeUpdate("ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6)");
                        stmt.executeUpdate("ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL");
                        
                        // Set defaults
                        stmt.executeUpdate("UPDATE users SET two_factor_enabled = FALSE");
                        stmt.executeUpdate("UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin'");
                        
                        stmt.close();
                        
                        columnsExist = true;
                        adminHas2FA = true;
                        
                        out.println("<div class='status-box status-success'>");
                        out.println("<h3>✅ Success!</h3>");
                        out.println("<p>Two-Factor Authentication has been enabled successfully!</p>");
                        out.println("<p><strong>Admin account now has 2FA enabled.</strong></p>");
                        out.println("</div>");
                        
                    } catch (SQLException e) {
                        errorMessage = e.getMessage();
                    }
                }

            } catch (SQLException e) {
                errorMessage = e.getMessage();
            }

            if (errorMessage != null) {
                out.println("<div class='status-box status-error'>");
                out.println("<h3>❌ Database Error</h3>");
                out.println("<p>" + errorMessage + "</p>");
                out.println("</div>");
            }
        %>

        <% if (columnsExist && adminHas2FA) { %>
            <div class="status-box status-success">
                <h3>✅ 2FA is Already Enabled!</h3>
                <p>Your database is configured correctly and the admin account has Two-Factor Authentication enabled.</p>
            </div>

            <div class="step">
                <h3>🎉 Ready to Test!</h3>
                <p>Follow these steps to test 2FA:</p>
                <ol>
                    <li><strong>Logout</strong> from EventSphere (if logged in)</li>
                    <li>Go to the <a href="${pageContext.request.contextPath}/login.jsp">Login Page</a></li>
                    <li>Login with: <code>admin</code> / <code>admin123</code></li>
                    <li>You'll see the 2FA verification page</li>
                    <li>Check your <strong>Tomcat console</strong> for the 6-digit code</li>
                    <li>Enter the code and verify</li>
                </ol>
                
                <div style="margin-top: 1.5rem;">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout & Test 2FA</a>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn" style="margin-left: 1rem;">Go to Dashboard</a>
                </div>
            </div>

        <% } else if (columnsExist && !adminHas2FA) { %>
            <div class="status-box status-warning">
                <h3>⚠️ 2FA Columns Exist but Admin Not Enabled</h3>
                <p>The database columns are there, but admin doesn't have 2FA enabled.</p>
            </div>

            <div class="step">
                <h3>Enable 2FA for Admin</h3>
                <p>Run this SQL command in XAMPP MySQL:</p>
                <div class="sql-box">UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';</div>
                
                <p style="margin-top: 1rem;">Or click the button below:</p>
                <form method="post" action="?action=enable">
                    <button type="submit" class="btn btn-primary">Enable 2FA for Admin</button>
                </form>
            </div>

        <% } else { %>
            <div class="status-box status-warning">
                <h3>⚠️ 2FA Not Set Up Yet</h3>
                <p>The database columns for Two-Factor Authentication don't exist yet.</p>
            </div>

            <div class="step">
                <h3>🚀 Quick Setup (Automatic)</h3>
                <p>Click the button below to automatically add 2FA columns and enable it for the admin account:</p>
                
                <form method="post" action="?action=setup">
                    <button type="submit" class="btn btn-primary" style="font-size: 1.1rem; padding: 1rem 2rem;">
                        ✨ Enable 2FA Now
                    </button>
                </form>
            </div>

            <div class="step">
                <h3>📝 Manual Setup (Alternative)</h3>
                <p>If you prefer to run SQL commands manually:</p>
                
                <ol>
                    <li>Open <strong>XAMPP Control Panel</strong></li>
                    <li>Click the <strong>"Shell"</strong> button</li>
                    <li>Type: <code>mysql -u root</code> and press Enter</li>
                    <li>Copy and paste these commands:</li>
                </ol>

                <div class="sql-box">USE eventsphere;

ALTER TABLE users ADD COLUMN two_factor_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN two_factor_code VARCHAR(6);
ALTER TABLE users ADD COLUMN two_factor_expiry TIMESTAMP NULL;

UPDATE users SET two_factor_enabled = FALSE;
UPDATE users SET two_factor_enabled = TRUE WHERE username = 'admin';

SELECT username, email, two_factor_enabled FROM users;</div>
            </div>
        <% } %>

        <div class="step">
            <h3>📚 How 2FA Works</h3>
            <ul>
                <li>When enabled users login, they enter username/password first</li>
                <li>A 6-digit code is generated and "sent" to their email (simulated in console)</li>
                <li>User must enter the code within 5 minutes</li>
                <li>After verification, they're logged in</li>
                <li>Currently enabled for: <strong>admin</strong> account only</li>
            </ul>
        </div>

        <div class="step">
            <h3>🔧 Enable 2FA for Other Users</h3>
            <p>To enable 2FA for other users, run this SQL:</p>
            <div class="sql-box">UPDATE users SET two_factor_enabled = TRUE WHERE username = 'john_doe';</div>
            
            <p style="margin-top: 1rem;">To disable 2FA:</p>
            <div class="sql-box">UPDATE users SET two_factor_enabled = FALSE WHERE username = 'admin';</div>
        </div>

        <div style="text-align: center; margin-top: 2rem;">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
