<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat Database Test</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #0f172a; color: #e2e8f0; }
        .success { color: #4ade80; }
        .error { color: #f87171; }
        .warning { color: #fbbf24; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; background: #1e293b; }
        th, td { border: 1px solid #334155; padding: 10px; text-align: left; }
        th { background: #334155; }
        .btn { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin: 5px; }
        .btn:hover { opacity: 0.9; }
    </style>
</head>
<body>
    <h1>💬 Chat Database Test</h1>
    
    <%
        String action = request.getParameter("action");
        Connection conn = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eventsphere", "root", "");
            
            out.println("<p class='success'>✅ Database connection successful!</p>");
            
            // Check if message_type column exists
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet columns = metaData.getColumns(null, null, "chat_messages", "message_type");
            
            if (columns.next()) {
                out.println("<p class='success'>✅ message_type column exists</p>");
            } else {
                out.println("<p class='error'>❌ message_type column MISSING - Run the SQL update script!</p>");
                out.println("<button class='btn' onclick='runUpdate()'>Run Update Script</button>");
            }
            columns.close();
            
            // Show table structure
            out.println("<h2>Table Structure:</h2>");
            out.println("<table>");
            out.println("<tr><th>Column</th><th>Type</th><th>Null</th><th>Default</th></tr>");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("DESCRIBE chat_messages");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("Field") + "</td>");
                out.println("<td>" + rs.getString("Type") + "</td>");
                out.println("<td>" + rs.getString("Null") + "</td>");
                out.println("<td>" + rs.getString("Default") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            rs.close();
            
            // Show recent messages
            out.println("<h2>Recent Messages:</h2>");
            out.println("<table>");
            out.println("<tr><th>ID</th><th>Sender</th><th>Receiver</th><th>Message</th><th>Type</th><th>Time</th></tr>");
            
            rs = stmt.executeQuery(
                "SELECT cm.*, u1.username as sender_name, u2.username as receiver_name " +
                "FROM chat_messages cm " +
                "JOIN users u1 ON cm.sender_id = u1.id " +
                "LEFT JOIN users u2 ON cm.receiver_id = u2.id " +
                "ORDER BY cm.sent_at DESC LIMIT 20"
            );
            
            int count = 0;
            while (rs.next()) {
                count++;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("sender_name") + "</td>");
                out.println("<td>" + (rs.getString("receiver_name") != null ? rs.getString("receiver_name") : "<span class='warning'>BROADCAST</span>") + "</td>");
                out.println("<td>" + rs.getString("message").substring(0, Math.min(50, rs.getString("message").length())) + "</td>");
                
                String msgType = "DIRECT";
                try {
                    msgType = rs.getString("message_type");
                } catch (Exception e) {
                    msgType = "N/A";
                }
                out.println("<td>" + msgType + "</td>");
                out.println("<td>" + rs.getTimestamp("sent_at") + "</td>");
                out.println("</tr>");
            }
            
            if (count == 0) {
                out.println("<tr><td colspan='6' style='text-align:center;'>No messages yet</td></tr>");
            }
            
            out.println("</table>");
            rs.close();
            stmt.close();
            
            // Add test broadcast button
            if ("addTest".equals(action)) {
                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO chat_messages (sender_id, receiver_id, message, message_type) VALUES (1, NULL, ?, 'BROADCAST')"
                );
                pstmt.setString(1, "🎉 TEST BROADCAST: This is a test announcement sent at " + new java.util.Date());
                pstmt.executeUpdate();
                pstmt.close();
                out.println("<p class='success'>✅ Test broadcast message added! Refresh to see it.</p>");
            }
            
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    %>
    
    <h2>Actions:</h2>
    <button class='btn' onclick="location.href='test-chat-db.jsp?action=addTest'">Send Test Broadcast</button>
    <button class='btn' onclick="location.href='test-chat-db.jsp'">Refresh</button>
    <button class='btn' onclick="location.href='chat'">Go to Chat</button>
    
    <h2>SQL Update Script:</h2>
    <p>If message_type column is missing, run this in MySQL:</p>
    <pre style="background: #1e293b; padding: 15px; border-radius: 5px; overflow-x: auto;">
USE eventsphere;

ALTER TABLE chat_messages 
ADD COLUMN message_type ENUM('DIRECT', 'BROADCAST') DEFAULT 'DIRECT' AFTER message;

ALTER TABLE chat_messages 
MODIFY receiver_id INT NULL;

UPDATE chat_messages SET message_type = 'DIRECT' WHERE message_type IS NULL;
    </pre>
</body>
</html>
