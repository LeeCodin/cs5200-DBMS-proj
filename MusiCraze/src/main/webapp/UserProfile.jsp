<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="musicraze.model.Users"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.min.css" rel="stylesheet">
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
	    <% response.setHeader("Cache-Control","no-cache"); %>
	    <% response.setHeader("Cache-Control","no-store"); %>
	    <% response.setHeader("Pragma","no-cache"); %>
	    <% response.setDateHeader ("Expires", 0); %>
		<% Users user = (Users) (session.getAttribute("user")); %>
		<% request.setAttribute("user", user); %>
		<% if (user == null) { %>
			<script>
			    function() {
					window.location.href = "/UserLogin.jsp"
			    }
		    </script>
		<% } else { %>
		<ul class="list-group">
			<li class="list-group-item row col-6">User Name: ${user.getUserName()}</li>
			<li class="list-group-item row col-6">First Name: ${user.getFirstName()}</li>
		    <li class="list-group-item row col-6">Last Name: ${user.getLastName()}</li>
		    <li class="list-group-item row col-6">Email: ${user.getEmail()}</li>
		    <li class="list-group-item row col-6">Avatar: <br /><img src="<%=user.getAvatar() %>" style="max-width:50%"></li>
		    <li class="list-group-item row col-6">Bio: ${user.getBio()}</li>
		    <li class="list-group-item row col-6">Born Date: ${user.getBornDateStr()}</li>
		    <li class="list-group-item row col-6">Join Date: ${user.getJoinDateStr()}</li>
		    <li class="list-group-item row col-6"><a href="http://localhost:8080/MusiCraze/EditProfile">Edit Profile</a></li>
		    <li class="list-group-item row col-6"><a href="http://localhost:8080/MusiCraze/ChangePassword">Change Password</a></li>
		    <li class="list-group-item row col-6"><a href="http://localhost:8080/MusiCraze/UserLogout">Logout</a></li>	    
		</ul>
		
		<h1>${messages.title}</h1>
		<table class="table table-striped">
		  <thead class="thead-dark">
		    <tr>
		      <th scope="col">Playlist Id</th>
		      <th scope="col">Playlist Name</th>
		      <th scope="col">Description </th>
		      <th scope="col">Create Date</th>
		      <th scope="col">Latest Update Date</th>
		      <th scope="col"></th>
		      <th scope="col"></th>
		      
		    </tr>
		  </thead>
		  <tbody>
		    <c:forEach items="${playlists}" var="playlist">
		      <tr>
		        <!-- <th scope="row">2</th> -->
		        <th scope="row"><c:out value="${playlist.getPlaylistId()}" /></th>
		    	<%-- <td><c:out value="${playlist.getPlaylistId()}" /></td> --%>
		    	<td><c:out value="${playlist.getPlaylistName()}" /></td>
		    	<td><c:out value="${playlist.getDescription()}" /></td>
		    	<td><c:out value="${playlist.getCreatedAt()}" /></td>
		    	<td><c:out value="${playlist.getUpdatedAt()}" /></td>
		    	
		    	<td><a href="playlistupdate?playlistid=<c:out value="${playlist.getPlaylistId()}"/>">Update</a></td>
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
		
		<% } %>
	</div>
</body>

</html> 