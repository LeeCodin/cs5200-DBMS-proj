<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<title>Playlist Create</title>
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

	
		<div class="pricing-header px-3 py-3 pb-md-4 mx-auto">
		  <!--  Success Message -->
		  <div class="alert alert-success" <c:if test="${messages.disableDisplayInfo}">style="display:none"</c:if>> 
		  	<h5 class="alert-heading"> Playlist created successfully! </h5>
		  </div>
		  
		  <!-- Warning Message if the entered playlist name already exists or name is empty-->
		  <div class="alert alert-warning" <c:if test="${messages.disableNameWarning}">style="display:none"</c:if>> 
			<% System.out.println(request.getAttribute("messages")); %>
			<c:choose>
				<c:when test="${messages.nameWarningType.equals(\"empty\")}">
					<h5 class="alert-heading">Failed to create playlist! </h5>
					<p style="margin-bottom: 0;">
						Please enter a <strong>non-empty</strong> name.
					</p>
				</c:when>
				<c:when test="${messages.nameWarningType.equals(\"duplicate\")}">
					<h5 class="alert-heading">Failed to create playlist! </h5>
					<p style="margin-bottom: 0;">You already have a playlist named: "${duplicatePlaylistName}".
						<strong>Please enter a different playlist name.</strong>  
					</p>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		  </div>
		  
		  
		  <h2 class="display-5 text-center">Playlist Name: ${createdPlaylistName}</h2>
	      <p class="lead text-center"><strong>Description: </strong><br/>${createdDescription}</p>
		</div> 
	
	
		<form action="PlaylistCreate" method="post" class="text-center"
			<c:if test="${messages.disableInput}">style="display:none"</c:if>
		>	
			<div class="input-group mb-3 w-25 mx-auto">
		      <div class="input-group-prepend">
	   			<span class="input-group-text">Enter Playlist Name:</span>
	 		  </div>
			  <input name="newPlaylistName" type="text" class="form-control" placeholder="Name" />
			  
	 		  <span style="display: none">
		    	<input name="user" value="${user}"/>
	   		  </span> 
	
			</div>
			
			<div class="input-group w-50 mx-auto">
			  <div class="input-group-prepend">
	   			<span class="input-group-text">Enter Description:</span>
	 		  </div>
			  <textarea name="newDescription" class="form-control" placeholder="Description"></textarea>
			</div>
			
		  	<br/>
		  	
		  
		  	<div>
		    	<input class="btn btn-primary" type="submit" value="Create New Playlist"/>
		    	<a href="UserProfile"
	       			class="btn btn-outline-secondary" role="button" aria-pressed="true">
	       			Back to See All Playlists
	       		</a>
		    </div>
		</form>
	
		<div <c:if test="${!(messages.disableInput)}">style="display:none"</c:if> class="text-center">
	    	<a href="PlaylistSongsDisplay?playlistId=<c:out value="${createdPlaylistId}"/>"
	      			class="btn btn-primary" role="button" aria-pressed="true">
	      			Go to this Playlist
	      	</a>
	    	
	    	<a href="UserProfile"
	      			class="btn btn-outline-secondary" role="button" aria-pressed="true">
	      			Back to See All Playlists
	      	</a>
		</div>
	</div>
	


</body>
</html>