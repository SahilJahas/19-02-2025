<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>LOFT CITY | Responsive Travel & Tourism Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicons -->
        <link href="img/favicon.ico" rel="icon">
        <link href="img/apple-favicon.png" rel="apple-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,700|Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet">

        <!-- Vendor CSS File -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="vendor/slick/slick.css" rel="stylesheet">
        <link href="vendor/slick/slick-theme.css" rel="stylesheet">
        <link href="vendor/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Main Stylesheet File -->
        <link href="css/hover-style.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <!-- Header Section Start -->
        <header id="header">
            <a href="index.html" class="logo"><img src="img/logo.png" alt="logo"></a>
            <div class="phone"><i class="fa fa-phone"></i>+1 234 567 8900</div>
            <div class="mobile-menu-btn"><i class="fa fa-bars"></i></div>
            <nav class="main-menu top-menu">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="about.html">About Us</a></li>
                    <li class="active"><a href="room.html">Apartments</a></li>
                    <li><a href="amenities.html">Amenities</a></li>
                    <li><a href="booking.jsp">Booking</a></li>
                    <li><a href="login.html">Login</a></li>
                    <li><a href="contact.html">Contact Us</a></li>
                </ul>
            </nav>
        </header>
        <!-- Header Section End -->

        <!-- Search Section Start -->
        <div id="search" style="background: #f2f2f2;">
            <div class="container">
                <div class="form-row">
                    <div class="control-group col-md-3">
                        <label>Check-In</label>
                        <div class="form-group">
                            <div class="input-group date" id="date-3" data-target-input="nearest">
                                <input type="text" class="form-control datetimepicker-input" data-target="#date-3"/>
                                <div class="input-group-append" data-target="#date-3" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="control-group col-md-3">
                        <label>Check-Out</label>
                        <div class="form-group">
                            <div class="input-group date" id="date-4" data-target-input="nearest">
                                <input type="text" class="form-control datetimepicker-input" data-target="#date-4"/>
                                <div class="input-group-append" data-target="#date-4" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="control-group col-md-3">
                        <div class="form-row">
                            <div class="control-group col-md-6">
                                <label>Adult</label>
                                <select class="custom-select">
                                    <option selected>0</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </div>
                            <div class="control-group col-md-6 control-group-kid">
                                <label>Kid</label>
                                <select class="custom-select">
                                    <option selected>0</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="control-group col-md-3">
                        <button class="btn btn-block">Search</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Search Section End -->

        <!-- Room Section Start -->
        <div id="rooms">
            <div class="container">
                <div class="section-header">
                    <h2>Apartments & Suites</h2>
                    <p>
                        We offer the perfect blend of comfort and style, providing a relaxing space for both short and extended stays...
                    </p>
                </div>

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

                            // Query to fetch all rooms
                            String sql = "SELECT * FROM rooms";
                            stmt = conn.prepareStatement(sql);
                            rs = stmt.executeQuery();

                            // Loop through the result set and display rooms
                            int count = 0; // Counter to alternate the order
                            while (rs.next()) {
                                String roomName = rs.getString("room_name");
                                double price = rs.getDouble("price");
                                int size = rs.getInt("size");
                                String bedType = rs.getString("bed_type");
                                String imageUrl = rs.getString("image_url");
                                String description = rs.getString("description");
                                String bookingLink = rs.getString("bookinglink");

                                // Alternate the room layout direction (left or right)
                                String layoutClass = (count % 2 == 0) ? "room-left" : "room-right";
                    %>

                    <% 
                        // Define the fallback image URL
                        String imgSrc = (imageUrl != null && !imageUrl.isEmpty()) ? imageUrl : "default-image.jpg";
                    %>

                    <div class="col-md-12 room">
                        <div class="row room-content <%= layoutClass %>">
                            <!-- If count is even, place image on the left -->
                            <div class="col-md-6 <%= (count % 2 == 0) ? "" : "order-md-2" %>">
                                <div class="room-img">
                                    <img src="<%= imgSrc %>" alt="<%= roomName %>" class="img-fluid" style="object-fit: cover; height: 250px; width: 100%;">
                                </div>
                            </div>
                            <!-- Room details on the other side -->
                            <div class="col-md-6">
                                <div class="room-des">
                                    <h3><%= roomName %></h3>
                                    <h1>&#8377;<%= price %><span>/ Night</span></h1>
                                    <ul class="room-size">
                                        <li><i class="fa fa-arrow-right"></i>Size: <%= size %> sq ft</li>
                                        <li><i class="fa fa-arrow-right"></i>Beds: <%= bedType %></li>
                                    </ul>
                                    <div class="room-link">
                                        <a href="#" data-toggle="modal" data-target="#modal-<%= roomName.replace(" ", "-").toLowerCase() %>">Read More</a>
                                        <a href="<%= bookingLink != null ? bookingLink : '#' %>">Book Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal for each room -->
                    <div class="modal fade" id="modal-<%= roomName.replace(" ", "-").toLowerCase() %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel"><%= roomName %></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <%= description %>  <!-- Full description shown here -->
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <% 
                            count++; // Increment the counter to alternate
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                    %>
                </div>
            </div>
        </div>
        <!-- Room Section End -->

        <!-- Footer Section Start -->
        <div id="footer">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="social">
                            <a href=""><li class="fa fa-instagram"></li></a>
                            <a href=""><li class="fa fa-twitter"></li></a>
                            <a href=""><li class="fa fa-facebook-f"></li></a>
                        </div>
                    </div>
                    <div class="col-12">
                        <ul>
                            <li><a href="">Home</a></li>
                            <li><a href="">About</a></li>
                            <li><a href="">Terms</a></li>
                            <li><a href="">Contact</a></li>
                        </ul>
                    </div>
                    <div class="col-12">
                        <p>Copyright &#169; <a href="https://htmlcodex.com">HTML Codex</a> All Rights Reserved.</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer Section End -->
        
        <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

        <!-- Vendor JavaScript File -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
