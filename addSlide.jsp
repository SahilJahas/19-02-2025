<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Slide</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJ03Ruq7l6p1JIH4I6EIZT5T0htn4w0wEx8c24VJgS1IHVdBoPXAYWVh9v5p" crossorigin="anonymous">
    
    <style>
        body {
            background-color: #f8f9fa; 
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; 
        }
        .container {
            max-width: 1200px;
            margin-top: 30px;
        }
        h2 {
            color: #4b0082; 
            font-size: 2.5rem; 
            font-weight: 600; 
            text-align: center;
            margin-bottom: 30px;
        }
        .card {
            background-color: #ffffff;
            border-radius: 15px; 
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); 
            padding: 25px;
            margin-bottom: 30px;
            border: none; 
        }
        .form-label {
            color: #4b0082; 
            font-size: 1.2rem;  
            font-weight: 500; 
        }
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #ddd; 
            font-size: 1.1rem; 
            padding: 12px 15px;
            width: 100%;
            box-sizing: border-box; 
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #4b0082; 
            box-shadow: 0 0 8px rgba(75, 0, 130, 0.4);
        }
        .btn-primary {
            background-color: #4b0082;
            border-color: #4b0082;
            font-size: 1.2rem; 
            padding: 12px 25px;
            width: 100%;
            border-radius: 8px; 
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #6a1e9c; 
            border-color: #6a1e9c;
        }
        .alert {
            border-radius: 8px;
            padding: 15px;
            font-size: 1.1rem;
            margin-top: 20px;
        }
        .alert-success {
            background-color: #28a745;
            color: white;
        }
        .alert-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-link {
            color: #4b0082;
            font-size: 1.1rem; 
            font-weight: 500; 
        }
        .btn-link:hover {
            color: #6a1e9c;
            text-decoration: underline;
        }
        .form-section {
            background-color: #f0f8ff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); 
        }
        .section-title {
            font-size: 2rem;
            font-weight: 600;
            color: #4b0082;
            text-align: center;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add New Slide</h2>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String imageUrl = request.getParameter("imageUrl");
            String altText = request.getParameter("altText");

            // Database connection details
            Connection conn = null;
            PreparedStatement stmt = null;
            String url = "jdbc:mysql://localhost:3306/apartment?useUnicode=true&characterEncoding=UTF-8";  // Change database name if needed
            String dbUser = "root";  // MySQL username
            String dbPassword = "";  // MySQL password

            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish database connection
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // SQL query to insert the new slide into the imageslide table
                String sql = "INSERT INTO imageslide (image_url, alt_text, is_active) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, imageUrl);  // Set image URL
                stmt.setString(2, altText);   // Set alt text
                stmt.setInt(3, 1);  // Set is_active to 1 (active)

                // Execute the update
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<div class='alert alert-success text-center'>New slide added successfully!</div>");
                } else {
                    out.println("<div class='alert alert-danger text-center'>Failed to add the slide.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>");
            } finally {
                // Close resources
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    %>

    <div class="form-section">
        <form action="addSlide.jsp" method="POST">
            <div class="card p-4">
                <div class="mb-4">
                    <label for="imageUrl" class="form-label">Image URL:</label>
                    <input type="text" class="form-control" id="imageUrl" name="imageUrl" required>
                </div>

                <div class="mb-4">
                    <label for="altText" class="form-label">Alt Text:</label>
                    <input type="text" class="form-control" id="altText" name="altText" required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">Add Slide</button>
                </div>
            </div>
        </form>
    </div>

    <br>
    <a href="slidesection.jsp" class="btn btn-link">View All Slides</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybT1XVdXf4f7yTOtW5e6r6EOv8hCZ1Go5lEjc3Ut98g8u7FqG" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0sy0vUqkk9BzF1Eq3nv/p6uWHEoOBXxYs7X57tH0VrlPbX3S" crossorigin="anonymous"></script>

</body>
</html>
