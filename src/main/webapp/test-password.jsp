<%@ page import="com.eventsphere.util.DBConnection" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Password Test</title></head>
<body>
<h1>DBConnection Password Check</h1>
<%
    try {
        Class<?> clazz = DBConnection.class;
        Field passwordField = clazz.getDeclaredField("PASSWORD");
        passwordField.setAccessible(true);
        String password = (String) passwordField.get(null);
        
        out.println("<p>Current PASSWORD value: '" + password + "'</p>");
        out.println("<p>Password length: " + password.length() + "</p>");
        out.println("<p>Is empty: " + password.isEmpty() + "</p>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
</body>
</html>
