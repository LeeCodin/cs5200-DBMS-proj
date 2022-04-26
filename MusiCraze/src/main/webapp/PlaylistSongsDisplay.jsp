<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%-- <%@ page import="musicraze.dal.PlaylistsDao"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<title>Playlist Songs Display</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>

<body>

	
	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
      <h2 class="display-5">Playlist: ${playlistName}</h2>
      <p class="lead"><strong>Description: </strong><br/>${description}</p>
      <a href="PlaylistUpdateInfo?playlistId=<c:out value="${playlistId}"/>"
       class="btn btn-primary" role="button" aria-pressed="true"
      >Update Info</a>
      <a href="UserProfile"
       class="btn btn-outline-secondary" role="button" aria-pressed="true"
      >Back To See All Playlists</a>
      
      
    </div>
    
	<div 
		<c:if test="${messages.disableMessage}">style="display:none"</c:if>
		<c:if test="${messages.isSuccessful}">class="alert alert-success"</c:if>
		<c:if test="${!(messages.isSuccessful)}">class="alert alert-danger"</c:if>
		>
 	  ${messages.title}
    </div> 
    
    
    
	
	<table class="table table-striped table-hover">
	  <thead class="thead-light">
	    <tr>
	      <th scope="col">Song ID</th>
	      <th scope="col">Song Title</th>
	      <th scope="col">Artist</th>
	      <th scope="col">Album</th>
	      <!-- <th scope="col">Like Counts</th> -->
	      <th></th>
	    </tr>
	  </thead>
	 
	  
	  <tbody>
	  	<c:forEach items="${playlistSongContains}" var="contain">
		    <tr>
	          <th scope="row"><c:out value="${contain.getSong().getSongId()}" /></th>
		      <%-- <td><c:out value="${contain.getSong().getSongName()}" /></td> --%>
 	    	  <td>
 	    	  	<a href="SongDetail?songId=<c:out value="${contain.getSong().getSongId()}"/>"><c:out value="${contain.getSong().getSongName()}" /></a>
 	    	  </td>
    	  
 			  <td><c:out value="${contain.getSong().getArtist().getArtistName()}" /></td>
			  <td><c:out value="${contain.getSong().getAlbum().getName()}" /></td>
		      <!-- <td>100-TODO!!!</td> -->
		      <td>
      		   <form action="PlaylistSongsDisplay" method="post">
	    		  <span style="display: none">
	    		  	<input name="containId" value="${contain.getContainId()}"/>
	    		  	<input name="playlistId" value="${playlistId}"/>
	    		  </span>
	    		  <input class="delete" type="submit" value="Remove from this playlist" />
	    		</form> 
		      </td>
		      
		    </tr>
	     </c:forEach>
	  </tbody>
	</table>
		

</body>
</html>