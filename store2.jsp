<%@ page import="java.sql.*" %>
<%
String title = request.getParameter("title");
String releaseDate = request.getParameter("releaseDate");
String genre = request.getParameter("genre");
String director = request.getParameter("director");
String starring = request.getParameter("starring");

try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "suman", "tiger")) {
    PreparedStatement ps = conn.prepareStatement("INSERT INTO Movies VALUES (?, ?, ?, ?, ?)");
    ps.setString(1, title);
    ps.setString(2, releaseDate);
    ps.setString(3, genre);
    ps.setString(4, director);
    ps.setString(5, starring);
    int rowsInserted = ps.executeUpdate();
    
    if (rowsInserted > 0) {
        out.print("Movie added successfully");
    } else {
        out.print("Failed to add movie");
    }
} catch (Exception e) {
    out.print(e);
}
%>
