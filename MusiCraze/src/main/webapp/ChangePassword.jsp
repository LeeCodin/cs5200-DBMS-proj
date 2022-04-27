<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="musicraze.model.Users"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<title>Change Password</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<div class="mt-2 container">
		<div class="navbar navbar-expand navbar-dark bg-dark">
			<div class="navbar-brand">MusiCraze</div>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			    	<li class="nav-item">
			        	<a class="nav-link" href="http://localhost:8080/MusiCraze/FindMusic">Search</a>
			      	</li>
			      	<li class="nav-item">
			        	<a class="nav-link" href="http://localhost:8080/MusiCraze/UserProfile">Profile</a>
			      	</li>
			      	<li class="nav-item dropdown">
			        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Settings</a>
			        	<div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          		<a class="dropdown-item" href="http://localhost:8080/MusiCraze/EditProfile">Edit Profile</a>
			          		<a class="dropdown-item active" href="http://localhost:8080/MusiCraze/ChangePassword">Change Password</a>
			        	</div>
			      	</li>
			      	<li class="nav-item">
			        	<a class="nav-link" href="http://localhost:8080/MusiCraze/UserLogout">Logout</a>
			      	</li>
			    </ul>
		  	</div>
		</div>
		<% response.setHeader("Cache-Control","no-cache"); %>
	    <% response.setHeader("Cache-Control","no-store"); %>
	    <% response.setHeader("Pragma","no-cache"); %>
	    <% response.setDateHeader ("Expires", 0); %>
		<% Users user = (Users) (session.getAttribute("user")); %>
		<% request.setAttribute("user", user); %>
		<% if (user == null) { %>
			<script>
			    function() {
					window.location.href = "/UserLogin.jsp"
			    }
		    </script>
		<% } else { %>
			<div class="mt-2 container">
				<form action="ChangePassword" method="post">
					<div class="form-group">
						<label for="oldPassword" class="row">Old Password:<span class="ml-2 text-danger">&#42;</span></label>
						<input id="oldPassword" type="password" class="row col-6" name="oldPassword" value="" />
						<div class="row" id="alertOldPassword" style="color: red">${alerts.oldPassword}</div>
					</div>
					<div class="form-group">
						<label for="newPassword" class="row">New Password:<span class="ml-2 text-danger">&#42;</span></label>
						<input id="newPassword" type="password" class="row col-6" name="newPassword" value="" />
						<div class="row" id="alertNewPassword" style="color: red">${alerts.newPassword}</div>
					</div>
					<div class="form-group">
						<label for="confirmPassword" class="row">Confirm Password:<span class="ml-2 text-danger">&#42;</span></label>
						<input id="confirmPassword" type="password" class="row col-6" name="confirmPassword" value="" />
						<div class="row" id="alertConfirmPassword" style="color: red">${alerts.confirmPassword}</div>
					</div>
					<div class="form-group">
						<div class="row text-secondary">Fields marked with an <span class="ml-2 mr-2 text-danger">&#42;</span> are required.</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary row col-6">Save</button>
					</div>
				</form>
			</div>
		<% } %>
	</div>
</body>
</html>