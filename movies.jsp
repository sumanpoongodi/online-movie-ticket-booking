<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Add Movie</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 50px;
        }
        .card {
            width: 500px;
            margin: 0 auto;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1>Add Movie</h1>
        <form action="Newmovie.jsp" method="post">
            <!-- Movie form fields here -->
            <div>
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div>
                <label for="genere">Genre:</label>
                <input type="text" id="genere" name="genere" required>
            </div>
            <div>
                <label for="duration">Duration:</label>
                <input type="text" id="duration" name="duration" required>
            </div>
            <div>
                <label for="director">Director:</label>
                <input type="text" id="director" name="director" required>
            </div>
            <div>
                <label for="ReleaseDate">Release Date:</label>
                <input type="text" id="ReleaseDate" name="ReleaseDate" required>
            </div>
            <div>
                <label for="actors">Actors:</label>
                <input type="text" id="actors" name="actors" required>
            </div>
            <div>
                <button type="submit">Add Movie</button>
            </div>
        </form>

        <%-- Retrieve the form data and save it to the database --%>
        <% if (request.getMethod().equalsIgnoreCase("POST")) {
            // Check if the form was submitted
            // Retrieve the form data
            String title = request.getParameter("title");
            String genere = request.getParameter("genere");
            String duration = request.getParameter("duration");
            String releaseDate = request.getParameter("ReleaseDate");
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
                connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XE","suman","tiger");

                // Prepare the SQL statement
                String sql = "INSERT INTO movies (MovieTitle, MovieGenere, MovieDuration, ReleaseDate, Director, Actors) VALUES (?, ?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(sql);
                statement.setString(1, title);
                statement.setString(2, genere);
                statement.setString(3, duration);
                statement.setString(4, releaseDate);
                statement.setString(5, director);
                statement.setString(6, actors);

                // Execute the SQL statement
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>Movie added successfully.</p>");
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
        } %>

        <%-- Retrieve movies from the database --%>
        <% 
        Connection retrieveConnection = null;
        Statement retrieveStatement = null;
        ResultSet resultSet = null;
        try {
            // Establish the database connection
            Class.forName("oracle.jdbc.OracleDriver");
            retrieveConnection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XE","suman","tiger");

            // Create the SQL query
            String retrieveSql = "SELECT * FROM movies";

            // Create a statement and execute the query
            retrieveStatement = retrieveConnection.createStatement();
            resultSet = retrieveStatement.executeQuery(retrieveSql);

            // Display the retrieved movies
            out.println("<h2>Movie Details</h2>");
            if (resultSet.next()) {
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Title</th><th>Genre</th><th>Duration</th><th>Release Date</th><th>Director</th><th>Actors</th><th>Actions</th></tr>");
                do {
                    String movieId = resultSet.getString("MovieID");
                    String movieTitle = resultSet.getString("MovieTitle");
                    String movieGenere = resultSet.getString("MovieGenere");
                    String movieDuration = resultSet.getString("MovieDuration");
                    String movieReleaseDate = resultSet.getString("ReleaseDate");
                    String movieDirector = resultSet.getString("Director");
                    String movieActors = resultSet.getString("Actors");
                    out.println("<tr>");
                    out.println("<td>" + movieId + "</td>");
                    out.println("<td>" + movieTitle + "</td>");
                    out.println("<td>" + movieGenere + "</td>");
                    out.println("<td>" + movieDuration + "</td>");
                    out.println("<td>" + movieReleaseDate + "</td>");
                    out.println("<td>" + movieDirector + "</td>");
                    out.println("<td>" + movieActors + "</td>");
                    out.println("<td><a href=\"edit_movie.jsp?id=" + movieId + "\">Edit</a> | <a href=\"delete_movie.jsp?id=" + movieId + "\">Delete</a></td>");
                    out.println("</tr>");
                } while (resultSet.next());
                out.println("</table>");
            } else {
                out.println("<p>No movies found.</p>");
            }

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            // Close the database resources
            if (resultSet != null) {
                resultSet.close();
            }
            if (retrieveStatement != null) {
                retrieveStatement.close();
            }
            if (retrieveConnection != null) {
                retrieveConnection.close();
            }
        }
        %>
        
        <div>
            <center><a href="Moviedisplay.jsp" class="btn btn-primary"><button>Next</button></a></center>
        </div>
    </div>
</div>
</body>
</html>
