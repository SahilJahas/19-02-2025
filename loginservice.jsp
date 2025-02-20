<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	boolean isValidUser = false;
	try {
		// Load MySQL driver (use new driver for MySQL 8 and above)
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// Update connection string for your 'apartment' database
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/apartment", "root", "");

		// Check if the user is admin (using email and password comparison for admin)
		if (email.equals("admin@gmail.com") && password.equals("Admin123@")) {
			// Start a session for admin
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("user", email);
			response.sendRedirect("adminpanel.jsp");
		} else {
			// Query to check the user credentials from 'users' table (change table name if needed)
			String sql = "SELECT password FROM register WHERE email=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, email);
			rs = stmt.executeQuery();

			if (rs.next()) {
				// Retrieve the hashed password stored in the database
				String storedHashedPassword = rs.getString("password");

				// Check if the entered password matches the stored hashed password
				if (BCrypt.checkpw(password, storedHashedPassword)) {
					// If valid user, start session and redirect to user page
					HttpSession httpSession = request.getSession();
					httpSession.setAttribute("user", email);
					response.sendRedirect("index.jsp");
				} else {
					// If password does not match, redirect to login page with error
					response.sendRedirect("login.jsp?error=1");
				}
			} else {
				// If email is not found, redirect to registration page
				%>
				<script type="text/javascript">
					alert("No account? Create one");
					window.location.href = "register.jsp";
				</script>
				<%
			}
		}
	} catch (Exception e) {
		// Print error if any exception occurs during the process
		e.printStackTrace(); // For debugging
		out.print("An error occurred: " + e.getMessage());
	} finally {
		// Close resources after the operation
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (con != null) con.close();
		} catch (Exception e) {
			// Handle errors during closing resources
			e.printStackTrace(); // For debugging
			out.print("Error closing resources");
		}
	}
%>
