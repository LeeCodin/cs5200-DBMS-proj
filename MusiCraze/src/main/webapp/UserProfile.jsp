<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="musicraze.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">
<link href="css/user-profile.css" rel="stylesheet">
<title>User Profile</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
/** Add a confirm pop-up window after clicking delete*/
/* 	let currentForm;
	$(function() {
	    $("#dialog-confirm").dialog({
	        resizable: false,
	        height: 140,
	        modal: true,
	        autoOpen: false,
	        buttons: {
	            'Delete all items': function() {
	                $(this).dialog('close');
	                currentForm.submit();
	            },
	            'Cancel': function() {
	                $(this).dialog('close');
	            }
	        }
	    });
	    $(".delete").click(function() {
	      currentForm = $(this).closest('form');
	      $("#dialog-confirm").dialog('open');
	      return false;
	    });
	}); */
</script>
</head>
<body>
	<div class="mt-2 container">
		<div class="navbar navbar-expand navbar-light bg-light">
			<div class="navbar-brand">MusiCraze</div>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			    	<li class="nav-item">
			        	<a class="nav-link" href="http://localhost:8080/MusiCraze/FindMusic">Search</a>
			      	</li>
			      	<li class="nav-item active">
			        	<a class="nav-link" href="http://localhost:8080/MusiCraze/UserProfile">Profile</a>
			      	</li>
			      	<li class="nav-item dropdown">
			        	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Settings</a>
			        	<div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          		<a class="dropdown-item" href="http://localhost:8080/MusiCraze/EditProfile">Edit Profile</a>
			          		<a class="dropdown-item" href="http://localhost:8080/MusiCraze/ChangePassword">Change Password</a>
			        	</div>
			      	</li>
			      	<li class="nav-item">
			        	<a class="nav-link" href="http://localhost:8080/MusiCraze/UserLogout">Logout</a>
			      	</li>
			    </ul>
		  	</div>
		</div>
	    <% response.setHeader("Cache-Control","no-cache"); %>
	    <% response.setHeader("Cache-Control","no-store"); %>
	    <% response.setHeader("Pragma","no-cache"); %>
	    <% response.setDateHeader ("Expires", 0); %>
		<% Users user = (Users) session.getAttribute("user"); %>
		<% request.setAttribute("user", user); %>
		<% if (user == null) { %>
			<script>
			    function() {
					window.location.href = "/UserLogin.jsp"
			    }
		    </script>
		<% } else { %>
			<% Guests guest = (Guests) request.getAttribute("guest"); %>
			<% if (guest != null) { %>
				<% System.out.println("Render guest!"); %>
				<div class="mt-2 container">
					<div class="row mt-2">
						<div class="col-12">
							<img class="card-img-top banner" src="https://cdn.pixabay.com/photo/2015/01/14/18/40/turntable-599462_960_720.jpg">
		            	</div>
		        	</div>
		            <div class="row">
		              	<div class="col-9">
			              	<div class="card-body">
			              		<div class="card-text">
									<div class="row h2">${guest.getUserName()}</div>
								    <div class="row">
								    	<i class="fa-solid fa-calendar-days"></i><span class="ml-2 mr-2">Member since ${guest.getJoinDateStr()}</span>
								    </div>
								    <div class="row text-muted">${guest.getBio()}</div>
			              		</div>
			              	</div>            	
		              	</div>
		                <div class="col-3">
		                  	<img class="card-img-top avatar float-right" src="<%=guest.getAvatar() %>">
		                </div>
	              	</div>
					<!-- TODO: Display guest's playlist -->
					
				</div>			
			<% } else { %>
				<% System.out.println("Render user!"); %>
				<div class="mt-2 container">
					<div class="row mt-2">
		                <div class="col-12">
		                  	<img class="card-img-top banner" src="https://cdn.pixabay.com/photo/2021/08/20/22/04/flowers-6561370_960_720.jpg">
		                </div>
		            </div>
		            <div class="row">
		            	<div class="col-9">
		              		<div class="card-body">
		              			<div class="card-text">
									<div class="row h2">${user.getUserName()}<span class="ml-2 font-italic">(${user.getFirstName()} ${user.getLastName()})</span></div>
								    <div class="row">
								    	<i class="fa-solid fa-envelope"></i><a class="ml-2 mr-2" href="<%=user.getEmail() %>">${user.getEmail()}</a>
								    	<i class="fa-solid fa-cake-candles"></i><span class="ml-2 mr-2">Born on ${user.getBornDateStr()}</span>
								    	<i class="fa-solid fa-calendar-days"></i><span class="ml-2 mr-2">Member since ${user.getJoinDateStr()}</span>
								    </div>
								    <div class="row text-muted">${user.getBio()}</div>
			              		</div>
			              	</div>            	
		              	</div>
		                <div class="col-3">
		                  	<img class="card-img-top avatar float-right" src="<%=user.getAvatar() %>">
		                </div>
	              	</div>
					
					<div style="display:flex; flex-wrap: wrap;align-items:center;justify-content: space-around">
						<h1 class="text-center">My Playlists</h1>
						<a href="PlaylistCreate" class="btn btn-primary" role="button" aria-pressed="true" style="height:1.75rem;font-size:1.25rem;line-height:1rem">
							+ Add New Playlist</a>	
					</div>
					<div
						<c:if test="${messages.disableMessage==null || messages.disableMessage==true}">style="display:none"</c:if>
						<c:if test="${messages.isSuccessful}">class="alert alert-success"</c:if>
						<c:if test="${!(messages.isSuccessful)}">class="alert alert-danger"</c:if>
					>
						<c:out value="${messages.title}"/>
					</div>
					
					<table class="table table-striped table-hover">
					  <thead class="thead-dark">
					    <tr>
					      <!-- <th scope="col">Playlist Id</th> -->
					      <th scope="col">Playlist Name</th>
					      <th scope="col">Description </th>
					      <th scope="col">Create Date</th>
					      <th scope="col">Latest Update Date</th>
			<!-- 		      <th scope="col"></th>
			 -->		      <th scope="col"></th>
					      
					    </tr>
					  </thead>
					  <tbody>
					    <c:forEach items="${playlists}" var="playlist">
					      <tr>
					        <!-- <th scope="row">2</th> -->
					        <%-- <th scope="row"><c:out value="${playlist.getPlaylistId()}" /></th> --%>
					    	<%-- <td><c:out value="${playlist.getPlaylistId()}" /></td> --%>
					    	<td><a href="PlaylistSongsDisplay?playlistId=<c:out value="${playlist.getPlaylistId()}"/>"><c:out value="${playlist.getPlaylistName()}" /></a></td>
					    	<td><c:out value="${playlist.getDescription()}" /></td>
					    	<td><c:out value="${playlist.getCreatedAt()}" /></td>
					    	<td><c:out value="${playlist.getUpdatedAt()}" /></td>
					    	
			<%-- 		    	<td><a href="PlaylistUpdate?playlistId=<c:out value="${playlist.getPlaylistId()}"/>">Update</a></td>
			 --%>		    	
					    	<td>
					    		<form action="UserProfile" method="post">
					    		  <span style="display: none">
					    		  	<input name="playlistId" value="${playlist.getPlaylistId()}"/>
					    		  </span>
					    		  <input class="delete" type="submit" value="Delete" />
					    		 
					    		</form>
					    	</td>
					      </tr>
					    </c:forEach>
					    
					  </tbody>
					</table>
				</div>		
			<% } %>
		<% } %>
	</div>
</body>
</html> 