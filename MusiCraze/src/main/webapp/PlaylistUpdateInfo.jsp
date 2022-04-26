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
	<title>Playlist Update</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>

<body>
	<h1 class="display-5">Update Playlist Info:</h1>
	
	<div class="alert alert-success" <c:if test="${messages.disableSuccess}">style="display:none"</c:if>> 
	  <h5 class="alert-heading"> Playlist Info updated successfully! </h5>
	 </div>
	  
	  
	<!-- Warning Message if the entered playlist name already exists -->
	<div class="alert alert-warning" <c:if test="${messages.disableSameNameWarning}">style="display:none"</c:if>> 
		
		<h5 class="alert-heading">Duplicate playlist name: </h5>
			<p>You already have a playlist named: "${duplicatePlaylistName}".
		   <strong>Please enter a different playlist name.</strong>  </p>
	</div>
	  
	
	
	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
	  
	  	<h2 class="display-5">Playlist Name: ${playlistName}</h2>
	  	
      
      <p class="lead"><strong>Description: </strong><br/>${description}</p>
	</div>
	
	
	<form action="PlaylistUpdateInfo" method="post" class="text-center">
		
		<div class="input-group mb-3 w-25 mx-auto">
	      <div class="input-group-prepend">
   			<span class="input-group-text">Enter New Name:</span>
 		  </div>
		  <input name="newPlaylistName" type="text" class="form-control" placeholder="Name" value="${playlistName}" />
		  
		  <span style="display: none">
	    	<input name="playlistId" value="${playlistId}"/>
   		  </span>

		</div>
		
		<div class="input-group w-50 mx-auto">
		  <div class="input-group-prepend">
   			<span class="input-group-text">Enter New Description:</span>
 		  </div>
		  <textarea name="newDescription" class="form-control" placeholder="Description">${description}</textarea>
		</div>
		
	  	<br/>
	  	<div>
	    	<input class="btn btn-primary" type="submit" value="Update"/>
	    	<a href="PlaylistSongsDisplay?playlistId=<c:out value="${playlistId}"/>"
       			class="btn btn-outline-secondary" role="button" aria-pressed="true">
       			Back to Playlist
       		</a>
	    </div>
	</form>
	


</body>
</html>