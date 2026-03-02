<%@ page import="java.sql.*" %>
<%@ page import="com.eventsphere.util.DBConnection" %>
<%@ page import="com.eventsphere.util.PasswordUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fix Passwords</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Password Fix Utility</h1>
    
    <%
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            
            // Hash the passwords
            String adminHash = PasswordUtil.hashPassword("admin123");
            String studentHash = PasswordUtil.hashPassword("student123");
            
            // Update admin password
            PreparedStatement stmt1 = conn.prepareStatement("UPDATE users SET password = ? WHERE username = 'admin'");
            stmt1.setString(1, adminHash);
            int admin = stmt1.executeUpdate();
            stmt1.close();
            
            // Update student passwords
            PreparedStatement stmt2 = conn.prepareStatement("UPDATE users SET password = ? WHERE role = 'STUDENT'");
            stmt2.setString(1, studentHash);
            int students = stmt2.executeUpdate();
            stmt2.close();
            
            out.println("<p class='success'>✅ Passwords updated successfully!</p>");
            out.println("<p>Admin password updated: " + admin + " row(s)</p>");
            out.println("<p>Student passwords updated: " + students + " row(s)</p>");
            out.println("<hr>");
            out.println("<p><strong>Login Credentials:</strong></p>");
            out.println("<p>Admin: username=<strong>admin</strong>, password=<strong>admin123</strong></p>");
            out.println("<p>Students: username=<strong>john_doe</strong>, password=<strong>student123</strong></p>");
            out.println("<hr>");
            out.println("<p><a href='/EventSphere/diagnostic.jsp'>Test Diagnostic</a> | <a href='/EventSphere/login.jsp'>Go to Login</a></p>");
            
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error: " + e.getMessage() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        } finally {
            DBConnection.closeConnection(conn);
        }
    %>
</body>
</html>
