<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    <%
        String url = "jdbc:mysql://localhost:3306/eventsphere?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String username = "root";
        String password = "NewStrongPassword";
        
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            out.println("<p style='color: green;'>✅ Database connection successful!</p>");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM users");
            if (rs.next()) {
                out.println("<p>Users in database: " + rs.getInt("count") + "</p>");
            }
            
            rs = stmt.executeQuery("SELECT id, username, role FROM users LIMIT 5");
            out.println("<h3>Sample Users:</h3><ul>");
            while (rs.next()) {
                out.println("<li>ID: " + rs.getInt("id") + ", Username: " + rs.getString("username") + ", Role: " + rs.getString("role") + "</li>");
            }
            out.println("</ul>");
            
            rs.close();
            stmt.close();
        } catch (ClassNotFoundException e) {
            out.println("<p style='color: red;'>❌ MySQL Driver not found: " + e.getMessage() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        } catch (SQLException e) {
            out.println("<p style='color: red;'>❌ Database connection failed: " + e.getMessage() + "</p>");
            out.println("<p>Error Code: " + e.getErrorCode() + "</p>");
            out.println("<p>SQL State: " + e.getSQLState() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    out.println("<p>Connection closed.</p>");
                } catch (SQLException e) {
                    e.printStackTrace(new java.io.PrintWriter(out));
                }
            }
        }
    %>
</body>
</html>
