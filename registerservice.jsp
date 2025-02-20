<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%
    // Get form parameters
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Hash the password using BCrypt (ensure password is not null)
    String hashedPassword = null;
    if (password != null && !password.isEmpty()) {
        hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    } else {
        // Handle the case where password is invalid (you might want to show an error message)
    }

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

        // Check if the email already exists
        String checkEmailSQL = "SELECT COUNT(*) FROM register WHERE email = ?";
        stmt = conn.prepareStatement(checkEmailSQL);
        stmt.setString(1, email);
        rs = stmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        if (count > 0) {
            // Email already exists
%>
            <script type="text/javascript">
                alert("Email already exists. Please login.");
                window.location.href = "login.jsp";
            </script>
<%
        } else {
            // Insert the new user
            String insertUserSQL = "INSERT INTO register (first_name, last_name, email, password) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertUserSQL);
            stmt.setString(1, first_name);
            stmt.setString(2, last_name);
            stmt.setString(3, email);
            stmt.setString(4, hashedPassword);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
%>
                <script type="text/javascript">
                    alert("Registration successful. Please login.");
                    window.location.href = "login.jsp";
                </script>
<%
            } else {
%>
                <script type="text/javascript">
                    alert("Registration failed. Please try again later.");
                    window.location.href = "register.jsp";
                </script>
<%
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
%>
        <script type="text/javascript">
            alert("An error occurred: <%= e.getMessage() %>. Please try again later.");
            window.location.href = "register.jsp";
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
