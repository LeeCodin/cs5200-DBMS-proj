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
<title>User Register</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<div class="mt-2 container">
		<% response.setHeader("Cache-Control","no-cache"); %>
	    <% response.setHeader("Cache-Control","no-store"); %>
	    <% response.setHeader("Pragma","no-cache"); %>
	    <% response.setDateHeader ("Expires", 0); %>
		<% if (session != null && session.getAttribute("user") != null) { %>
			<script>
			    function() {
					window.location.href = "/FindMusic.jsp"
			    }
		    </script>
		<% } else { %>
			<% String[] inputs = (String[]) request.getAttribute("inputs"); %>
			<form action="UserRegister" method="post">
				<div class="form-group">
					<label for="userName" class="row">User Name:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="userName" class="row col-6" name="userName" value="${inputs[0]}" />
					<div class="row" id="alertUserName" style="color: red">${alerts.userName}</div>
				</div>
				<div class="form-group">
					<label for="password" class="row">Password:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="password" class="row col-6" type="password" name="password" value="${inputs[1]}" />
					<div class="row" id="alertPassword" style="color: red">${alerts.password}</div>
				</div>
				<div class="form-group">
					<label for="firstName" class="row">First Name:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="firstName" class="row col-6" name="firstName" value="${inputs[2]}" />
					<div class="row" id="alertFirstName" style="color: red">${alerts.firstName}</div>
				</div>
				<div class="form-group">
					<label for="lastName" class="row">Last Name:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="lastName" class="row col-6" name="lastName" value="${inputs[3]}" />
					<div class="row" id="alertLastName" style="color: red">${alerts.lastName}</div>
				</div>
				<div class="form-group">
					<label for="email" class="row">Email:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="email" class="row col-6" name="email" value="${inputs[4]}" />
					<div class="row" id="alertEmail" style="color: red">${alerts.email}</div>
				</div>
				<div class="form-group">
					<label for="avatar" class="row">Avatar:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="avatar" class="row col-6" name="avatar" value="${inputs[5]}" />
					<div class="row" id="alertAvatar" style="color: red">${alerts.avatar}</div>
				</div>
				<div class="form-group">
					<label for="bio" class="row">Bio:</label>
					<input id="bio" class="row col-6" name="bio" value="${inputs[6]}" />
				</div>
				<div class="form-group">
					<label for="bornDate" class="row">Born Date:<span class="ml-2 text-danger">&#42;</span></label>
					<input id="bornDate" class="row col-6" name="bornDate" value="${inputs[7]}" />
					<div class="row" id="alertBornDate" style="color: red">${alerts.bornDate}</div>
				</div>
				<div class="form-group">
					<div class="row text-secondary">Fields marked with an <span class="ml-2 mr-2 text-danger">&#42;</span> are required.</div>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-primary row col-6">Register</button>
				</div>
			</form>
			<div class="row col-6 justify-content-center">Already have an account?<a class="ml-2" href="UserLogin">Login here</a></div>
		<% } %>
	</div>
</body>
</html>