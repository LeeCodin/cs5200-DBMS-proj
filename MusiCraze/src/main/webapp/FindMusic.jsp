<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">
    <title>Find Music</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
 	<div class="mt-2 container">
		<div class="navbar navbar-expand navbar-dark bg-dark">
			<div class="navbar-brand">MusiCraze</div>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			    	<li class="nav-item active">
			        	<a class="nav-link" href="FindMusic">Search</a>
			      	</li>
			      	<li class="nav-item">
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
		<div class="mt-2 container">
			<form action="FindMusic" method="post">
				<div class="mt-5 form-group">
					<div class="row justify-content-center">
						<input id="searchItem" name="searchItem" class="col-6" placeholder="Songs, artists or albums" value="${fn:escapeXml(param.searchItem)}">
		    			<button type="submit" class="btn btn-secondary"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
		    		<div class="row justify-content-center" id="successMessage" style="color: red">${messages.success}</div>
				</div>
			</form>
			
			<div class="card mt-2">
				<div class="row no-gutters">
			    	<div class="pt-2 pl-2 col-3 align-middle">
			      		<img src="https://cdn.pixabay.com/photo/2016/05/17/13/07/piano-1398069_960_720.jpg" class="card-img" alt="...">
			      		<h5 class="card-title text-center">Matching Songs</h5>
			    	</div>
			    	<div class="col-9">
			      		<div class="card-body">
			        		<div class="card-text">
								<table class="table">
									<thead>
						    			<tr>
									        <th>SongName</th>
									        <th>ArtistName</th>
									        <th>AlbumName</th>
									        <th>LikeCounts</th>
						
						    			</tr>
						   			</thead>
						   			<tbody>
						   				<c:forEach items="${songs}" var="song" >
						        			<tr>
									            <td><a href="SongDetail?songId=<c:out value="${song.getSongId()}"/>"><c:out value="${song.getSongName()}" /></a></td>            
									            <td><c:out value="${song.getArtist().getArtistName()}" /></td>
									            <td><c:out value="${song.getAlbum().getName()}" /></td>
									            <td><c:out value="${likesDao.getLikesBySongId(song.getSongId()).size()}"/></td>
						        			</tr>
						    			</c:forEach>
						   			</tbody>
								</table>
			       			</div>
			      		</div>
			    	</div>
			  	</div>
			</div>
			
			<div class="card mt-2">
				<div class="row no-gutters">
			    	<div class="pt-2 pl-2 col-3 align-middle">
			      		<img src="https://cdn.pixabay.com/photo/2019/12/28/18/08/plate-4725349_960_720.jpg" class="card-img" alt="...">
			      		<h5 class="card-title text-center">Matching Albums</h5>
			    	</div>
			    	<div class="col-9">
			      		<div class="card-body">
			        		<div class="card-text">
								<table class="table">
									<thead>
										<tr>
									        <th>AlbumName</th>
									        <th>ReleaseDate</th>
									        <th>Duration</th>		
									    </tr>
									</thead>
									<tbody>
										<c:forEach items="${albums}" var="album" >
									        <tr>
									        	<td><a href="AlbumDetail?albumId=<c:out value="${album.getAlbumId()}"/>"><c:out value="${album.getName()}" /></a></td>
									        	<td><fmt:formatDate value="${album.getReleaseDate()}" pattern="yyyy-MM-dd"/></td>
									        	<td><c:out value="${album.getDuration()}" /></td>    
									        </tr>
									    </c:forEach>
									</tbody>
								</table>
			       			</div>
			      		</div>
			    	</div>
			  	</div>
			</div>

			<div class="card mt-2">
				<div class="row no-gutters">
			    	<div class="pt-2 pl-2 col-3 align-middle">
			      		<img src="https://cdn.pixabay.com/photo/2016/11/18/15/44/audience-1835431_960_720.jpg" class="card-img" alt="...">
			      		<h5 class="card-title text-center">Matching Artists</h5>
			    	</div>
			    	<div class="col-9">
			      		<div class="card-body">
			        		<div class="card-text">
								<table class="table">
									<thead>
										<tr>
									        <th>ArtistName</th>		
									    </tr>
									</thead>
									<tbody>
										<c:forEach items="${artists}" var="artist" >
									        <tr>
									            <td><a href="ArtistDetail?artistId=<c:out value="${artist.getArtistId()}"/>"><c:out value="${artist.getArtistName()}" /></a></td>
									        </tr>
								    	</c:forEach>
									</tbody>
								</table>
			       			</div>
			      		</div>
			    	</div>
			  	</div>
			</div>
		</div>
	</div>
</body>
</html>