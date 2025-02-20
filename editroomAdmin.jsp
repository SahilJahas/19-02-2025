<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, java.util.*" %>
<%
    String roomId = request.getParameter("room_id");
    Map<String, Object> roomDetails = new HashMap<>();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Get the connection to your database
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/apartment");
        conn = ds.getConnection();

        // Get the room details for editing
        String query = "SELECT * FROM rooms WHERE room_id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, roomId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            roomDetails.put("room_id", rs.getString("room_id"));
            roomDetails.put("room_name", rs.getString("room_name"));
            roomDetails.put("room_type", rs.getString("room_type"));
            roomDetails.put("price", rs.getDouble("price"));
            roomDetails.put("size", rs.getInt("size"));
            roomDetails.put("bed_type", rs.getString("bed_type"));
            roomDetails.put("image_url", rs.getString("image_url"));
            roomDetails.put("description", rs.getString("description"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Room Details</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="container">
    <h2>Edit Room Details</h2>

    <form action="updateRoom.jsp" method="post">
        <input type="hidden" name="room_id" value="<%= roomDetails.get("room_id") %>">
        
        <div class="form-group">
            <label for="room_name">Room Name</label>
            <input type="text" class="form-control" id="room_name" name="room_name" value="<%= roomDetails.get("room_name") %>" required>
        </div>
        
        <div class="form-group">
            <label for="room_type">Room Type</label>
            <input type="text" class="form-control" id="room_type" name="room_type" value="<%= roomDetails.get("room_type") %>" required>
        </div>
        
        <div class="form-group">
            <label for="price">Price</label>
            <input type="number" class="form-control" id="price" name="price" value="<%= roomDetails.get("price") %>" required>
        </div>
        
        <div class="form-group">
            <label for="size">Size</label>
            <input type="number" class="form-control" id="size" name="size" value="<%= roomDetails.get("size") %>" required>
        </div>
        
        <div class="form-group">
            <label for="bed_type">Bed Type</label>
            <input type="text" class="form-control" id="bed_type" name="bed_type" value="<%= roomDetails.get("bed_type") %>" required>
        </div>
        
        <div class="form-group">
            <label for="image_url">Image URL</label>
            <input type="text" class="form-control" id="image_url" name="image_url" value="<%= roomDetails.get("image_url") %>" required>
        </div>
        
        <div class="form-group">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" name="description" required><%= roomDetails.get("description") %></textarea>
        </div>
        
        

        <button type="submit" class="btn btn-primary">Update Room</button>
    </form>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

</body>
</html>
