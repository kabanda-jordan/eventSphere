<%@ page import="java.sql.*" %>
<%@ page import="com.eventsphere.util.DBConnection" %>
<%@ page import="com.eventsphere.util.PasswordUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Check Passwords</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .success { color: green; }
        .error { color: red; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <h1>Password Check & Update</h1>
    
    <h2>Current Passwords in Database:</h2>
    <%
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, username, password FROM users");
            
            out.println("<table>");
            out.println("<tr><th>ID</th><th>Username</th><th>Password Hash (first 50 chars)</th></tr>");
            
            while (rs.next()) {
                String hash = rs.getString("password");
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + (hash.length() > 50 ? hash.substring(0, 50) + "..." : hash) + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        } finally {
            DBConnection.closeConnection(conn);
        }
    %>
    
    <h2>Test Password Matching:</h2>
    <%
        try {
            conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT username, password FROM users WHERE username = 'admin'");
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String username = rs.getString("username");
                String storedHash = rs.getString("password");
                
                out.println("<p><strong>Testing admin account:</strong></p>");
                out.println("<p>Stored hash: " + storedHash.substring(0, 30) + "...</p>");
                
                boolean matches = PasswordUtil.checkPassword("admin123", storedHash);
                out.println("<p>Does 'admin123' match? " + (matches ? "<span class='success'>✅ YES</span>" : "<span class='error'>❌ NO</span>") + "</p>");
                
                if (!matches) {
                    out.println("<p class='error'>Password doesn't match! Need to update.</p>");
                }
            }
            
            rs.close();
            stmt.close();
        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        } finally {
            DBConnection.closeConnection(conn);
        }
    %>
    
    <hr>
    <h2>Update Passwords Now:</h2>
    <form method="post">
        <button type="submit" name="action" value="update" style="padding: 10px 20px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;">
            Update All Passwords
        </button>
    </form>
    
    <%
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            try {
                conn = DBConnection.getConnection();
                
                // Generate new hashes
                String adminHash = PasswordUtil.hashPassword("admin123");
                String studentHash = PasswordUtil.hashPassword("student123");
                
                // Update admin
                PreparedStatement stmt1 = conn.prepareStatement("UPDATE users SET password = ? WHERE username = 'admin'");
                stmt1.setString(1, adminHash);
                int adminUpdated = stmt1.executeUpdate();
                stmt1.close();
                
                // Update students
                PreparedStatement stmt2 = conn.prepareStatement("UPDATE users SET password = ? WHERE role = 'STUDENT'");
                stmt2.setString(1, studentHash);
                int studentsUpdated = stmt2.executeUpdate();
                stmt2.close();
                
                out.println("<p class='success'>✅ Passwords updated successfully!</p>");
                out.println("<p>Admin accounts updated: " + adminUpdated + "</p>");
                out.println("<p>Student accounts updated: " + studentsUpdated + "</p>");
                out.println("<p><strong>You can now login with:</strong></p>");
                out.println("<p>Admin: username=<strong>admin</strong>, password=<strong>admin123</strong></p>");
                out.println("<p>Student: username=<strong>john_doe</strong>, password=<strong>student123</strong></p>");
                out.println("<p><a href='/EventSphere/diagnostic.jsp'>Test Diagnostic</a> | <a href='/EventSphere/login.jsp'>Go to Login</a></p>");
                
            } catch (Exception e) {
                out.println("<p class='error'>Error updating passwords: " + e.getMessage() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
            } finally {
                DBConnection.closeConnection(conn);
            }
        }
    %>
</body>
</html>
