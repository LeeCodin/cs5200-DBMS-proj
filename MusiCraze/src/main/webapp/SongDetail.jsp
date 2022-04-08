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
<div style="margin: 1% 3% 3% 3%">
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
	
	<!-- Comments -->
	<h1>Comments</h1>
	<h3>You can create a comment for this song:</h3>
		<form method="post" >
		  <div class="mb-3">
		    <textarea type="text" name="add-comment" class="form-control w-25" id="exampleInputPassword1"></textarea>
		  </div>
		  <button type="submit"  class="btn btn-primary">Submit</button>
		</form>
	
	<br />
	<c:if test="${usersComments.size() != 0}"> 
		<h3>You Got Some Comments on this song:</h3>
		<c:forEach items="${usersComments}" var="comment">
				<div class="card text-white bg-success" style="width: 18rem; margin-right:1rem; margin-left:1rem;">
					 <div class="card-header">
					  	${comment.getCreatedAt()}
					 </div>
				 	<div class="card-body">
					    <p class="card-text">${comment.getContent()}</p>		
				  	</div>
				</div>
		</c:forEach>
	</c:if> 
	
	<br />
	
	
	<h3>All Comments:</h3>
	<div class="d-flex flex-wrap">
		<c:forEach items="${commentsInfo}" var="comment">
				<div class="card bg-light" style="width: 18rem; margin-right:1rem; margin-left:1rem;">
				  	<div class="card-header">
				  	${comment.getCreatedAt()}
					 </div>
				  	<div class="card-body">
						<h6 class="card-subtitle" style="margin-bottom: 1rem;">   ${comment.getUser().getUserName()} said: </h6>
					    <p class="card-text">${comment.getContent()}</p>
					   <!--  <a href="#" class="card-link">Card link</a>
					    <a href="#" class="card-link">Another link</a> -->
				  	</div>
				</div>
		</c:forEach>
	</div>
	
</div>
</body>
</html>