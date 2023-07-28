<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Update Movie</title>
</head>
<body>
<%
    Connection connection = null;
    PreparedStatement selectStatement = null;
    PreparedStatement updateStatement = null;
    ResultSet resultSet = null;

    try {
        // Retrieve the form parameter
        String movieId = request.getParameter("id");
        String movieTitle = request.getParameter("title");
        String movieGenre = request.getParameter("genere");
        String movieDuration = request.getParameter("duration");
        String movieDirector = request.getParameter("director");
        String movieReleaseDate = request.getParameter("ReleaseDate");
        String movieActors = request.getParameter("actors");

        // Establish the database connection
        Class.forName("oracle.jdbc.OracleDriver");
        connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XE", "suman", "tiger");

        if (movieId != null) {
            // Check if the form was submitted for updating
            if (movieTitle != null && movieGenre != null && movieDuration != null && movieDirector != null && movieReleaseDate != null && movieActors != null) {
                // Create the SQL query to update the movie details
                String updateSql = "UPDATE movies SET MovieTitle = ?, MovieGenere = ?, MovieDuration = ?, Director = ?, ReleaseDate = ?, Actors = ? WHERE MovieID = ?";

                // Create a prepared statement and set the parameters
                updateStatement = connection.prepareStatement(updateSql);
                updateStatement.setString(1, movieTitle);
                updateStatement.setString(2, movieGenre);
                updateStatement.setString(3, movieDuration);
                updateStatement.setString(4, movieDirector);
                updateStatement.setString(5, movieReleaseDate);
                updateStatement.setString(6, movieActors);
                updateStatement.setString(7, movieId);

                // Execute the update statement
                int rowsAffected = updateStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<h2>Movie details updated successfully!</h2>");
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
                    movieTitle = resultSet.getString("MovieTitle");
                    movieGenre = resultSet.getString("MovieGenere");
                    movieDuration = resultSet.getString("MovieDuration");
                    movieDirector = resultSet.getString("Director");
                    movieReleaseDate = resultSet.getString("ReleaseDate");
                    movieActors = resultSet.getString("Actors");
                } else {
                    out.println("<h2>No movie found with the provided ID.</h2>");
                }
            }
        } else {
            out.println("<h2>No movie ID provided.</h2>");
        }

        // Display the form for editing with pre-populated values or empty fields
        %>
        <form method="post" action="edit_movie.jsp">
            <input type="hidden" name="id" value="<%= movieId %>">
            Movie Title: <input type="text" name="title" value="<%= movieTitle %>"><br>
            Movie Genre: <input type="text" name="genere" value="<%= movieGenre %>"><br>
            Movie Duration: <input type="text" name="duration" value="<%= movieDuration %>"><br>
            Director: <input type="text" name="director" value="<%= movieDirector %>"><br>
            Release Date: <input type="text" name="ReleaseDate" value="<%= movieReleaseDate %>"><br>
            Actors: <input type="text" name="actors" value="<%= movieActors %>"><br>
            <input type="submit" value="Update">
        </form>
        <%
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
        if (updateStatement != null) {
            updateStatement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
%>
</body>
</html>
