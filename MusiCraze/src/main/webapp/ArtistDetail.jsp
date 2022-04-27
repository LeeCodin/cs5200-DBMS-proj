<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ page language="java"
contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>Album Detail</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
</head>
<body style="background-color: #fffcfc;">
  	<div class="mt-2 container">
		<div class="navbar navbar-expand navbar-dark bg-dark">
			<div class="navbar-brand">MusiCraze</div>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			    	<li class="nav-item">
			        	<a class="nav-link" href="FindMusic">Search</a>
			      	</li>
			      	<li class="nav-item active">
			        	<a class="nav-link" href="UserProfile">Profile</a>
			      	</li>
			      	<li class="nav-item dropdown">
			        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Settings</a>
			        	<div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          		<a class="dropdown-item" href="EditProfile">Edit Profile</a>
			          		<a class="dropdown-item" href="ChangePassword">Change Password</a>
			        	</div>
			      	</li>
			      	<li class="nav-item">
			        	<a class="nav-link" href="UserLogout">Logout</a>
			      	</li>
			    </ul>
		  	</div>
		</div>
	</div>


	<div style="margin-left: 8%; margin-right:8%; margin-top:1%; margin-bottom: 3%;">
		<h1>Artist: ${artistInfo.getArtistName()}'s top 10 liked songs</h1>
		<table class="table">
			<thead>
				<tr>
		            <th scope="col">Song Title</th>
		            <th scope="col">Artist Name</th>
		            <th scope="col">Album</th>
		            <th scope="col">Year</th>
		            <th scope="col" style="width:8rem;">Likes</th>
		            <!-- <th>Add To Playlist</th>			 -->	
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${songsInfo}" var="songInfo">
					<tr>
						<td><a href="SongDetail?songId=<c:out value="${songInfo.getSongId()}"/>"><c:out value="${songInfo.getSongName()}" /></a></td>
            			<td>${songInfo.getArtist().getArtistName()}</td>
            			<td><a href="AlbumDetail?albumId=<c:out value="${songInfo.getAlbum().getAlbumId()}"/>"><c:out value="${songInfo.getAlbum().getName()}" /></a></td>
            			<td>${songInfo.getAlbum().getYear()}</td>
            			<td>${songInfo.getLikesCount()} </td>
            			<!-- <td>/</td> -->
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>