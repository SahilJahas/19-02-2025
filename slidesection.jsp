<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<html>
<head>
    <title>Manage Slide View</title>
    <link rel="stylesheet" href="css/styles.css">
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Style for container to center content */
        .container {
            margin-top: 50px;
        }

        /* Slide content styling */
        .slide {
            margin-bottom: 30px;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        /* Image container styling */
        .slide-img {
            max-width: 100%;
            height: auto;
            overflow: hidden;
            border-radius: 5px;
        }

        /* Ensure images inside the container are responsive */
        .slide-img img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }

        /* Slide description container styling */
        .slide-des {
            padding-left: 15px;
        }

        /* Styling for the Delete Button */
        .slide-link {
            margin-top: 10px;
        }

        .slide-link input[type="submit"] {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        
        
       

        <h1>Existing Slides</h1>
        <div class="row">
            <%
                // Database connection details
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                String url = "jdbc:mysql://localhost:3306/apartment?useUnicode=true&characterEncoding=UTF-8";
                String dbUser = "root";
                String dbPassword = "";

                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    // Query to fetch all slides ordered by their ID or any other column
                    String sql = "SELECT * FROM imageslide WHERE is_active = 1 ORDER BY id";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();

                    // Loop through the result set and display slides
                    int count = 0; // Counter to alternate the layout direction
                    while (rs.next()) {
                        String imageUrl = rs.getString("image_url");
                        String altText = rs.getString("alt_text");
                        String slideId = rs.getString("id"); // Slide ID for potential deletion or editing

                        // Alternate the layout direction (left or right)
                        String layoutClass = (count % 2 == 0) ? "slide-left" : "slide-right";

                        // Define the fallback image URL in case the image URL is null or empty
                        String imgSrc = (imageUrl != null && !imageUrl.isEmpty()) ? imageUrl : "default-image.jpg";
            %>

            <div class="col-md-12 slide">
                <div class="row slide-content <%= layoutClass %>">
                    <!-- If count is even, place image on the left -->
                    <div class="col-md-6 <%= (count % 2 == 0) ? "" : "order-md-2" %>">
                        <div class="slide-img">
                            <img src="<%= imgSrc %>" alt="<%= altText %>">
                        </div>
                    </div>
                    <!-- Slide description on the other side -->
                    <div class="col-md-6">
                        <div class="slide-des">
                            <h3><%= altText %></h3>
                            <div class="slide-link">
                                <!-- Delete Slide Button -->
                                <form action="removeSlide.jsp" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this slide?');">
                                    <input type="hidden" name="slide_id" value="<%= slideId %>">
                                    <input type="submit" value="Delete" class="btn btn-danger">
                                    <input type="hidden" name="action" value="delete">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%
                        count++; // Increment counter for alternating layout direction
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                // Insert new slide when form is submitted
                String imageUrl = request.getParameter("imageUrl");
                String altText = request.getParameter("altText");
                String bookingLink = request.getParameter("bookingLink");

                if (imageUrl != null && altText != null) {
                    try {
                        // Insert the slide into the database
                        String insertSql = "INSERT INTO imageslide (image_url, alt_text, booking_link, is_active) VALUES (?, ?, ?, ?)";
                        stmt = conn.prepareStatement(insertSql);
                        stmt.setString(1, imageUrl);
                        stmt.setString(2, altText);
                        stmt.setString(3, bookingLink);
                        stmt.setInt(4, 1); // Mark the slide as active

                        int rowsAffected = stmt.executeUpdate();
                        if (rowsAffected > 0) {
                            out.println("<script>alert('New slide added successfully.'); window.location='slidesection.jsp';</script>");
                        } else {
                            out.println("<script>alert('Failed to add the slide.'); window.location='slidesection.jsp';</script>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='slidesection.jsp';</script>");
                    }
                }
            %>
        </div>
    </div>

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>

    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
</body>
</html>
