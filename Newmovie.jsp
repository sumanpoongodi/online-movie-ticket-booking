<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Retrieve the form data
    String title = request.getParameter("title");
    String genere = request.getParameter("genere");
    String duration = request.getParameter("duration");
    String Releasedate = request.getParameter("ReleaseDate");
    String director = request.getParameter("director");
    String actors = request.getParameter("actors");
    

    // Database connection variables
    String url = "jdbc:oracle:thin:@//localhost:1521/XE";
    String username = "suman";
    String password = "tiger";

    // Attempt to save the movie data in the database
    Connection connection = null;
    PreparedStatement statement = null;
    try {
        // Establish the database connection
        Class.forName("oracle.jdbc.OracleDriver");
        connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XE", "suman", "tiger");

        // Prepare the SQL statement
        String sql = "INSERT INTO movies (MovieTitle, MovieGenere, MovieDuration,ReleaseDate, Director,Actors) VALUES (?, ?, ?, ?, ?, ?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1, title);
        statement.setString(2, genere);
        statement.setString(3, duration);
        statement.setString(4, Releasedate);
        statement.setString(5, director);
        statement.setString(6, actors);

        // Execute the SQL statement
        int rowsAffected = statement.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<p>Movie added successfully.</p>");
            response.sendRedirect("movies.jsp");
        } else {
            out.println("<p>Error: Failed to add the movie.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        // Close the database resources
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>
