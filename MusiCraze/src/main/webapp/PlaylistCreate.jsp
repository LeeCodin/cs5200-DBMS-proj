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
	<h1 class="display-5">Create New Playlist:</h1>
	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center"
		<c:if test="${messages.disableDisplayInfo}">style="display:none"</c:if>
	>
	  <h2 class="display-5">Playlist Name: ${createdPlaylistName}</h2>
      <p class="lead"><strong>Description: </strong><br/>${createdDescription}</p>
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
	    	<input class="btn btn-primary" type="submit" value="Update"/>
	    	<a href="UserProfile"
       			class="btn btn-outline-secondary" role="button" aria-pressed="true">
       			Back to See All Playlists
       		</a>
	    </div>
	</form>
	
	<div <c:if test="${!(messages.disableInput)}">style="display:none"</c:if> class="text-center">
    	<a href="UserProfile"
      			class="btn btn-outline-secondary" role="button" aria-pressed="true">
      			Back to See All Playlists
      		</a>
	</div>
	


</body>
</html>