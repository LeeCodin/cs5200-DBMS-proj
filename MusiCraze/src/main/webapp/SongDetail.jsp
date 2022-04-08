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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
	
	
	<h1>Comments</h1>
	<div class="d-flex flex-wrap">
		<c:forEach items="${commentsInfo}" var="comment">
				<div class="card" style="width: 18rem; margin-right:1rem;">
				  	<div class="card-body">
					    <h5 class="card-title">${comment.getUser().getUserName()}</h5>
					    <h6 class="card-subtitle mb-2 text-muted">${comment.getCreatedAt()}</h6>
					    <p class="card-text">${comment.getContent()}</p>
					    <a href="#" class="card-link">Card link</a>
					    <a href="#" class="card-link">Another link</a>
				  	</div>
				</div>
		</c:forEach>
	</div>
	
	
	
	

</body>
</html>