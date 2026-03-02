<%@ page import="java.sql.*" %>
<%@ page import="com.eventsphere.util.DBConnection" %>
<%@ page import="com.eventsphere.util.PasswordUtil" %>
<%@ page import="com.eventsphere.dao.UserDAO" %>
<%@ page import="com.eventsphere.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>EventSphere Diagnostic</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        .section { margin: 20px 0; padding: 15px; border: 1px solid #ccc; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>EventSphere System Diagnostic</h1>
    
    <div class="section">
        <h2>1. Database Connection Test</h2>
        <%
            Connection conn = null;
            try {
                conn = DBConnection.getConnection();
                out.println("<p class='success'>✅ Database connection successful!</p>");
                out.println("<p>Connection: " + conn + "</p>");
            } catch (Exception e) {
                out.println("<p class='error'>❌ Database connection failed!</p>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
            } finally {
                DBConnection.closeConnection(conn);
            }
        %>
    </div>
    
    <div class="section">
        <h2>2. User Table Query Test</h2>
        <%
            try {
                conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT id, username, email, role FROM users");
                
                out.println("<p class='success'>✅ Users table accessible!</p>");
                out.println("<table border='1' cellpadding='5'>");
                out.println("<tr><th>ID</th><th>Username</th><th>Email</th><th>Role</th></tr>");
                
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getString("role") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                rs.close();
                stmt.close();
            } catch (Exception e) {
                out.println("<p class='error'>❌ Failed to query users table!</p>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
            } finally {
                DBConnection.closeConnection(conn);
            }
        %>
    </div>
    
    <div class="section">
        <h2>3. Password Hashing Test</h2>
        <%
            try {
                String testPassword = "admin123";
                String hashed = PasswordUtil.hashPassword(testPassword);
                out.println("<p class='success'>✅ Password hashing works!</p>");
                out.println("<p>Test password: " + testPassword + "</p>");
                out.println("<p>Hashed: " + hashed.substring(0, 30) + "...</p>");
                
                boolean matches = PasswordUtil.checkPassword(testPassword, hashed);
                out.println("<p>Password verification: " + (matches ? "✅ PASS" : "❌ FAIL") + "</p>");
            } catch (Exception e) {
                out.println("<p class='error'>❌ Password hashing failed!</p>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
            }
        %>
    </div>
    
    <div class="section">
        <h2>4. UserDAO Authentication Test</h2>
        <%
            try {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.authenticate("admin", "admin123");
                
                if (user != null) {
                    out.println("<p class='success'>✅ Authentication successful!</p>");
                    out.println("<p>User ID: " + user.getId() + "</p>");
                    out.println("<p>Username: " + user.getUsername() + "</p>");
                    out.println("<p>Email: " + user.getEmail() + "</p>");
                    out.println("<p>Role: " + user.getRole() + "</p>");
                } else {
                    out.println("<p class='error'>❌ Authentication failed - user is null</p>");
                    out.println("<p>This means either username not found or password doesn't match</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error'>❌ UserDAO authentication test failed!</p>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
            }
        %>
    </div>
    
    <div class="section">
        <h2>5. Test Login with Wrong Password</h2>
        <%
            try {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.authenticate("admin", "wrongpassword");
                
                if (user == null) {
                    out.println("<p class='success'>✅ Correctly rejected wrong password!</p>");
                } else {
                    out.println("<p class='error'>❌ Security issue - accepted wrong password!</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error'>❌ Test failed with exception!</p>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
    
    <hr>
    <p><a href="/EventSphere/login.jsp">Go to Login Page</a></p>
</body>
</html>
