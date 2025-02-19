<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>LOFT CITY | Login</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicons -->
    <!-- Add this in the <head> section -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    
    <link href="img/favicon.ico" rel="icon">
    <link href="img/apple-favicon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,700|Raleway:100,200,300,400,500,600,700,800,900" rel="stylesheet">

    <!-- Vendor CSS File -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">

    <!-- Main Stylesheet File -->
    <link href="css/hover-style.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <style>
        /* Centering the login form */
        .signup-form {
            background: #fff;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            margin-top: 50px;
        }

        .signup-form h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 700;
        }

        .signup-form .form-group {
            margin-bottom: 15px;
        }

        .signup-form .form-control {
    height: 50px;
    font-size: 16px;
    padding-right: 40px; /* Adding space for the eye icon */
}


        .signup-form .btn {
            font-size: 16px;
            padding: 12px;
        }

        .signup-form .text-center {
            margin-top: 20px;
        }

        .signup-form .form-group.position-relative {
            position: relative;
        }

        /* Make the form more responsive */
        @media (max-width: 767px) {
            .signup-form {
                padding: 20px;
            }

            .signup-form h2 {
                font-size: 20px;
            }
        }

        /* Footer CSS */
        #footer {
            padding-top: 40px;
            padding-bottom: 40px;
        }

        #footer .container {
            padding-left: 30px;
            padding-right: 30px;
        }
    </style>

</head>

<body>

    <!-- Header Section Start -->
    <header id="header">
        <a href="index.html" class="logo"><img src="img/logo.png" alt="logo"></a>
        <div class="phone"><i class="fa fa-phone"></i>+1 234 567 8900</div>
        <div class="mobile-menu-btn"><i class="fa fa-bars"></i></div>
        <nav class="main-menu top-menu">
            <ul>
                <li class="active"><a href="index.jsp">Home</a></li>
                    <li><a href="about.html">About Us</a></li>
                    <li><a href="room.html">Apartments</a></li>
                    <li><a href="amenities.html">Amenities</a></li>
                    <li><a href="booking.jsp">Booking</a></li>
                     <li><a href="register.jsp">Register</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="contact.html">Contact Us</a></li>
            </ul>
        </nav>
    </header>
    <!-- Header Section End -->

    <!-- Main Content Start -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="signup-form">
                    <form action="loginservice.jsp" method="post" onsubmit="return validateForm()">
                        <h2>Login</h2>

                        <!-- Display Registration Status Messages -->
                        <%
                            String registered = request.getParameter("registered");
                            String error = request.getParameter("error");
                            if (registered != null && registered.equals("1")) {
                                out.println("<p style='color:green;'>Registration successful. Please login.</p>");
                            } else if (error != null && error.equals("1")) {
                                out.println("<p style='color:red;'>Registration failed. Please try again.</p>");
                            }
                        %>

                        <!-- Email Input Field -->
                        <div class="form-group position-relative">
                            <input type="email" class="form-control" name="email" id="email" placeholder="Email" required>
                        </div>

                      <!-- Password Input Field -->
<div class="form-group position-relative">
    <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
    <span class="toggle-password fas fa-eye" onclick="togglePassword('password')" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer; z-index: 10;"></span>
</div>



                        <!-- Submit Button -->
                        <div class="form-group">
                            <button type="submit" class="btn btn-dark btn-lg btn-block">Login</button>
                        </div>

                        <!-- Forgot Password Link -->
                        <div class="form-group text-center">
                            <a href="forgotPassword.jsp" class="btn btn-link">Forgot Password?</a>
                        </div>
                    </form>
                    <div class="text-center">Don't have an account? <a href="register.jsp">Register here</a></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Main Content End -->

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
                    <p>Template By <a href="https://htmlcodex.com">HTML Codex</a></p>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer Section End -->

    <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

    <!-- Vendor JavaScript File -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/jquery/jquery-migrate.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/easing/easing.min.js"></script>

    <script>
        // Form validation function
        function validateForm() {
            var email = document.getElementById('email').value;
            var password = document.getElementById('password').value;

            if (email.trim() === '') {
                alert('Email must be filled out');
                return false;
            }

            if (password.trim() === '') {
                alert('Password must be filled out');
                return false;
            }

            return true;
        }

        // Toggle password visibility
        function togglePassword(id) {
            var passwordField = document.getElementById(id);
            var toggleIcon = passwordField.nextElementSibling;

            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>

</body>

</html>
