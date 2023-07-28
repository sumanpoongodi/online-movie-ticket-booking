<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Delete Movie</title>
</head>
<body>
<%
    Connection connection = null;
    PreparedStatement selectStatement = null;
    PreparedStatement deleteStatement = null;
    ResultSet resultSet = null;

    try {
        // Retrieve the movie ID from the query parameter
        String movieId = request.getParameter("id");

        // Establish the database connection
        Class.forName("oracle.jdbc.OracleDriver");
        connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XE", "suman", "tiger");

        if (movieId != null) {
            // Check if the form was submitted for deletion confirmation
            if (request.getParameter("confirm") != null) {
                // Create the SQL query to delete the movie
                String deleteSql = "DELETE FROM movies WHERE MovieID = ?";

                // Create a prepared statement and set the parameter
                deleteStatement = connection.prepareStatement(deleteSql);
                deleteStatement.setString(1, movieId);

                // Execute the delete statement
                int rowsAffected = deleteStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<h2>Movie deleted successfully!</h2>");
                } else {
                    out.println("<h2>No movie found with the provided ID.</h2>");
                }
            } else {
                // Create the SQL query to select the movie details
                String selectSql = "SELECT MovieTitle, MovieGenere, MovieDuration, Director, ReleaseDate, Actors FROM movies WHERE MovieID = ?";

                // Create a prepared statement and set the parameter
                selectStatement = connection.prepareStatement(selectSql);
                selectStatement.setString(1, movieId);

                // Execute the select statement
                resultSet = selectStatement.executeQuery();

                if (resultSet.next()) {
                    // Retrieve the movie details from the result set
                    String movieTitle = resultSet.getString("MovieTitle");
                    String movieGenre = resultSet.getString("MovieGenere");
                    String movieDuration = resultSet.getString("MovieDuration");
                    String movieDirector = resultSet.getString("Director");
                    String movieReleaseDate = resultSet.getString("ReleaseDate");
                    String movieActors = resultSet.getString("Actors");

                    // Display the movie details
                    out.println("<h2>Movie Details:</h2>");
                    out.println("Movie ID: " + movieId + "<br>");
                    out.println("Movie Title: " + movieTitle + "<br>");
                    out.println("Movie Genre: " + movieGenre + "<br>");
                    out.println("Movie Duration: " + movieDuration + "<br>");
                    out.println("Director: " + movieDirector + "<br>");
                    out.println("Release Date: " + movieReleaseDate + "<br>");
                    out.println("Actors: " + movieActors + "<br>");
                    out.println("<br>");

                    // Display the confirmation form
                    out.println("<form method=\"post\" action=\"delete_movie.jsp?id=" + movieId + "&confirm=true\">");
                    out.println("<input type=\"submit\" value=\"Confirm Delete\">");
                    out.println("</form>");
                } else {
                    out.println("<h2>No movie found with the provided ID.</h2>");
                }
            }
        } else {
            out.println("<h2>No movie ID provided.</h2>");
        }
    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        // Close the database resources
        if (resultSet != null) {
            resultSet.close();
        }
        if (selectStatement != null) {
            selectStatement.close();
        }
        if (deleteStatement != null) {
            deleteStatement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>
</body>
</html>
