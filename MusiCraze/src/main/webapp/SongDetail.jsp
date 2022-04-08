<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Song Detail</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<h1>Song Detail</h1>
	<table class="table">
		<thead>
		<tr>
			<th scope="col">Song Title</th>
			<th scope="col">Artist Name</th>
			<th scope="col">Artist Country</th>
			<th scope="col">Album</th>
			<th scope="col">Year</th>
			<th scope="col">Release Date</th>
		</tr>
		</thead>
		<tbody>
			<tr>
				<td>${songInfo.getSongName()}</td>
				<td>${songInfo.getArtist().getArtistName()}</td>
				<td>${songInfo.getArtist().getArtistCountry()}</td>
				<td>${songInfo.getAlbum().getName()}</td>
				<td>${songInfo.getAlbum().getYear()}</td>
				<td>${songInfo.getAlbum().getReleaseDate()}</td>
			</tr>
		</tbody>
	</table>
	<br/>
	<!--  
	<div id="userCreate"><a href="usercreate">Create User</a></div>
	<br/>
	<h1>Matching Users</h1>
        <table border="1">
            <tr>
                <th>UserName</th>
                <th>FirstName</th>
                <th>LastName</th>
                <th>BornDate</th>
             
            </tr>
            <c:forEach items="${users}" var="user" >
                <tr>
                    <td><c:out value="${user.getUserName()}" /></td>
                    <td><c:out value="${user.getFirstName()}" /></td>
                    <td><c:out value="${user.getLastName()}" /></td>
                    <td><fmt:formatDate value="${user.getBornDate()}" pattern="yyyy-MM-dd"/></td>
           
                </tr>
            </c:forEach>
       </table>
       -->
</body>
</html>