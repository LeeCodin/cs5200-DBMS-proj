<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ page import="musicraze.model.*"%>

<%-- <%@ page import="musicraze.dal.PlaylistsDao"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	<title>Playlist Songs Display</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>

<body>
	
	<div class="card " style="height: 30%; width: 70%; margin-left:15%; border: 0px; margin-bottom: 2%">
		<!-- <img src="https://cdn.pixabay.com/photo/2017/08/06/12/08/headphones-2591890_1280.jpg" class="card-img"  > -->
		<img src="https://thumbs.dreamstime.com/b/pink-headphones-banner-minimal-music-concept-flat-lay-copy-space-monochrome-colors-215293223.jpg" 
			class="card-img" style="height:45vh; opacity: 0.5"  >
		<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 text-center card-img-overlay" style="margin-left: 20%; margin-right:20%; margin-top:1%; margin-bottom: 3%;">
		  <% Guests guest = (Guests) request.getAttribute("guest"); %>
	      <h2 class="display-5 text-center">
			Playlist: ${playlistName}	
	      </h2>
	      <% if (guest !=null) {%>
	      	<p class="lead text-center">
	      		<span style="background-color:var(--info); margin-right: 5px">
	      			<i class="bi bi-person-circle" fill="currentColor"></i>
	      		</span>
	      		<strong>Creator: </strong> 
	      		<a href="UserProfile?username=${guest.getUserName()}"><em>${guest.getUserName()}</em></a>
	      	</p>
	      <%}%>
	      <p class="lead text-center">
	      	${description}
	      </p>
	      <a href="PlaylistUpdateInfo?playlistId=<c:out value="${playlistId}"/>"
	       class="btn btn-primary" role="button" aria-pressed="true" <c:if test="${guest!=null}">style="display:none"</c:if>
	      >Update Info</a>
	     
	      <% if (guest !=null) {%>
	       	<a href="UserProfile?username=${guest.getUserName()}"
	       		class="btn btn-outline-secondary" role="button" aria-pressed="true">
	      		Back To See All of <em>${guest.getUserName()}</em>'s Playlists
	      	</a>
	      <%} else {%>
    	    <a href="UserProfile"
	       		class="btn btn-outline-secondary" role="button" aria-pressed="true">
	      	Back to See All My Playlists
	      	</a>
	      <%} %>
	      
	    </div>
	    

    </div>
    
    

    
    
    
	<div style="width: 80%; margin-left: 10%;">

    <div 
		<c:if test="${messages.disableMessage}">style="display:none"</c:if>
		<c:if test="${messages.isSuccessful}">class="alert alert-success"</c:if>
		<c:if test="${!(messages.isSuccessful)}">class="alert alert-danger"</c:if>
		style="margin-top: 1%"
		>
 	  ${messages.title} 
   	</div> 
	
	<table class="table table-striped table-hover" >
	  <thead class="thead-light">
	    <tr>
	      <!-- <th scope="col">Song ID</th> -->
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
	          <%-- <th scope="row"><c:out value="${contain.getSong().getSongId()}" /></th> --%>
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
	    		  <input class="delete" type="submit" value="Remove from this playlist" <c:if test="${guest!=null}">style="display:none"</c:if>/>
	    		</form> 
		      </td>
		      
		    </tr>
	     </c:forEach>
	  </tbody>
	</table>
	</div>
		

</body>
</html>