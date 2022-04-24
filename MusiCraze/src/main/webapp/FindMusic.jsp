<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <title>Find Music</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<div class="mt-2 container">
		<form action="FindMusic" method="post">
		    <h1>Search Music</h1>
		    <p>
		        <label for="searchItem">Song/Artist/Album</label>
		        <input id="searchItem" name="searchItem" value="${fn:escapeXml(param.searchItem)}">
		    </p>
		    <p>
		        <input type="submit">
		        <br/><br/><br/>
		        <span id="successMessage"><b>${messages.success}</b></span>
		    </p>
		</form>
		<br/>
		<div id="userProfile"><a href="UserProfile">${user.getUserName()}</a></div>
		<br/>
		<h1>Matching Songs</h1>
		<table border="1">
		    <tr>
		        <th>SongName</th>
		        <th>ArtistName</th>
		        <th>AlbumName</th>
		        <th>LikeCounts</th>
		
		    </tr>
		    <c:forEach items="${songs}" var="song" >
		        <tr>
		            <td><a href="SongDetail?songId=<c:out value="${song.getSongId()}"/>"><c:out value="${song.getSongName()}" /></a></td>            
		            <td><c:out value="${song.getArtist().getArtistName()}" /></td>
		            <td><c:out value="${song.getAlbum().getName()}" /></td>
		            <td><c:out value="${100}"/></td>
		
		        </tr>
		    </c:forEach>
		</table>
		<br/>
		<h1>Matching Albums</h1>
		<table border="1">
		    <tr>
		        <th>AlbumName</th>
		        <th>ReleaseDate</th>
		        <th>Duration</th>		
		    </tr>
		    <c:forEach items="${albums}" var="album" >
		        <tr>
		        	<td><c:out value="${album.getName()}" /></td>
		        	<td><fmt:formatDate value="${album.getReleaseDate()}" pattern="MM-dd-yyyy"/></td>
		        	<td><c:out value="${album.getDuration()}" /></td>
		        		    
		        </tr>
		    </c:forEach>
		</table>
		<br/>
		<h1>Matching Artists</h1>
		<table border="1">
		    <tr>
		        <th>ArtistName</th>		
		    </tr>
		    <c:forEach items="${artists}" var="artist" >
		        <tr>
		            <td><c:out value="${artist.getArtistName()}" /></td>
		        </tr>
		    </c:forEach>
		</table>
	</div>
</body>
</html>