<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Movie Details</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        
        th, td {
            text-align: left;
            padding: 8px;
        }
        
        th {
            background-color: red;
        }
    </style>
</head>
<body>
    <h1>Movie Details</h1>
    
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Duration</th>
            <th>Release Date</th>
            <th>Director</th>
            <th>Actors</th>
            <th>Action</th>
        </tr>
        
        <%
            // Step 1: Establish the database connection
            Connection conn = null;
            try {
                Class.forName("oracle.jdbc.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "suman", "tiger");
                
                // Step 2: Execute the SQL query
                Statement stmt = conn.createStatement();
                String sql = "SELECT * FROM movies ORDER BY MovieId";
                ResultSet rs = stmt.executeQuery(sql);
                
                // Step 3: Process and display the movie details
                while (rs.next()) {
                    int id = rs.getInt("MovieId");
                    String title = rs.getString("MovieTitle");
                    String genre = rs.getString("MovieGenere");
                    String duration = rs.getString("MovieDuration");
                    String releaseDate = rs.getString("ReleaseDate");
                    String director = rs.getString("Director");
                    String actors = rs.getString("Actors");
                    
                    // Display the movie details in table rows
                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + title + "</td>");
                    out.println("<td>" + genre + "</td>");
                    out.println("<td>" + duration + " minutes</td>");
                    out.println("<td>" + releaseDate + "</td>");
                    out.println("<td>" + director + "</td>");
                    out.println("<td>" + actors + "</td>");
                    out.println("<td><form method='post' action='book.jsp'>" +
                                    "<input type='hidden' name='movieId' value='" + id + "'>" +
                                    "<input type='submit' value='Book'>" +
                                "</form></td>");
                    out.println("</tr>");
                }
                
                // Close the ResultSet, statement, and connection
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
    <div>
            <center><a href="" class="btn btn-primary"><button>Next</button></a></center>
        </div>
</body>
</html>
