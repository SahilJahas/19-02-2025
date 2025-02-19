<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<html>
<head>
    <title>Remove Slide</title>
    <link rel="stylesheet" href="css/styles.css">
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Remove Slide</h1>

        <%
            // Database connection details
            Connection conn = null;
            PreparedStatement stmt = null;
            String url = "jdbc:mysql://localhost:3306/apartment?useUnicode=true&characterEncoding=UTF-8";
            String dbUser = "root";
            String dbPassword = "";

            // Retrieve the slide ID from the request parameter
            String slideId = request.getParameter("slide_id");

            if (slideId != null && !slideId.isEmpty()) {
                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    // SQL query to delete the slide
                    String sql = "DELETE FROM imageslide WHERE id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, slideId);

                    // Execute the deletion
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<div class='alert alert-success'>Slide deleted successfully.</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Failed to delete the slide. It may not exist.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>An error occurred while deleting the slide.</div>");
                } finally {
                    // Close resources
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<div class='alert alert-warning'>No slide ID provided.</div>");
            }
        %>

        <a href="slidesection.jsp" class="btn btn-primary">View Existing Slides</a>
    </div>

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
</body>
</html>
