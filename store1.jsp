<%@ page import="java.sql.*" %>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "suman", "tiger")) {
    PreparedStatement ps = conn.prepareStatement("SELECT UserPassword FROM Users WHERE UserEmail = ?");
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        String storedPassword = rs.getString("UserPassword");
        
        if (password.equals(storedPassword)) {
            
            response.sendRedirect("movies.jsp"); 
        } else {
            out.print("Invalid password");
        }
    } else {
        out.print("User not found");
    }
} catch (Exception e) {
    out.print(e);
}
%>
