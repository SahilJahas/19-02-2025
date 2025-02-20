<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<%
    // Database connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/apartment";
    String dbUser = "root"; // your DB username
    String dbPassword = ""; // your DB password
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Open a connection
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // SQL query to select all registered users
        String selectUsersSQL = "SELECT first_name, last_name, email FROM register";
        stmt = conn.prepareStatement(selectUsersSQL);
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<style type="text/css">
/* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background-color: #f5f7fa;
    color: #333;
    line-height: 1.6;
}

/* Container styling */
.container {
    width: 80%;
    margin: 20px auto;
    padding: 30px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    border: 1px solid #e4e7eb;
}

/* Header styling */
h2 {
    text-align: center;
    font-size: 2.5em;
    color: #4a4a4a;
    margin-bottom: 20px;
    font-weight: 700;
    letter-spacing: 1px;
}

/* Table styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #e2e8f0;
}

th {
    background-color: #f44336; /* Red color */

    color: #ffffff;
    font-weight: bold;
    text-transform: uppercase;
}

td {
    background-color: #ffffff;
}

tr:hover td {
    background-color: #f1f8e9;
    transition: background-color 0.3s ease;
}

table tr:last-child td {
    border-bottom: none;
}

/* Adding a touch of responsiveness */
@media (max-width: 768px) {
    .container {
        width: 90%;
        padding: 20px;
    }

    table, th, td {
        font-size: 14px;
    }
}
</style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Users</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to your premium CSS file -->
</head>
<body>

    <div class="container">
        <h2>Registered Users</h2>
        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Loop through the result set and display each user's data
                    while(rs.next()) {
                        String firstName = rs.getString("first_name");
                        String lastName = rs.getString("last_name");
                        String email = rs.getString("email");
                %>
                        <tr>
                            <td><%= firstName %></td>
                            <td><%= lastName %></td>
                            <td><%= email %></td>
                        </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("An error occurred: <%= e.getMessage() %>. Please try again later.");
        </script>
<%
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
%>
