<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ page language="java"
contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>Song Detail</title>
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
    <div style="margin-left: 8%; margin-right:8%; margin-top:1%; margin-bottom: 3%;">
      <h1>Song Detail</h1>
      <table class="table">
        <thead>
          <tr>
            <th scope="col">Song Title</th>
            <th scope="col">Artist Name</th>
            <!-- <th scope="col">Artist Country</th> -->
            <th scope="col">Album</th>
            <th scope="col">Year</th>
            <!-- <th scope="col">Release Date</th> -->
            <th scope="col" style="width:8rem;">Likes</th>
            <th>Add To Playlist</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>${songInfo.getSongName()}</td>
            <td><a href="ArtistDetail?artistId=<c:out value="${songInfo.getArtist().getArtistId()}"/>"><c:out value="${songInfo.getArtist().getArtistName()}" /></a></td>
            <td><a href="AlbumDetail?albumId=<c:out value="${songInfo.getAlbum().getAlbumId()}"/>"><c:out value="${songInfo.getAlbum().getName()}" /></a></td>
            <td>${songInfo.getAlbum().getYear()}</td>
            <%-- <td>${songInfo.getAlbum().getReleaseDate()}</td> --%>
            <td>
            	<div class="d-flex align-items-center">
            		<div style="margin-right:1rem;">
            		  	${likesCounts}
            		</div>
	            	<form method="post" id="like-song">
	           			<input type="hidden" name="like-song" value="true"/>
	            		 <a href="javascript:{}" onclick="document.getElementById('like-song').submit();">
	            		 	<%boolean liked = (boolean)request.getAttribute("liked"); %>
	            		 	<c:choose>
	            		 		<c:when test="${not liked}">
                       <i class="bi bi-heart"></i>
	            		  	</c:when>
                      <c:otherwise>
                        <i class="bi bi-heart-fill"></i>
                      </c:otherwise>
	            		 	</c:choose>
	            		 
						</a>
	            	</form>
            	</div>       
            </td>
            <!-- Add To Playlist Dropdown list -->
            <td>
	          	<div class="dropdown">
				  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-bs-toggle="dropdown" aria-expanded="false">
				    Choose Playlist:
				  </button>
				  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2" id="playlist-ul" playlists="${playlists}">
				    <!-- <li onclick="$('#playlist-form').submit()">
				    	Each <li> should have access to a playlistId and playlistName
				    	<a class="dropdown-item" 
				    		data-bs-toggle="modal" data-bs-target="#playlistModal" id="dropdown-playlist">
				    		Playlist33: Crazy Moments
				    	</a>
				    	
				    	<form method="post" id="playlist-form">
				    		<input type="hidden" name="playlistId" value="33"/>
				    	</form>
				    	
				    </li> -->
            
				    <c:forEach items="${playlists}" var="playlist">
				    	<li>
				    		<form method="post">
					    		<input type="hidden" name="playlistId" value="${playlist.getPlaylistId()}"/>
					    		<button class="dropdown-item" type="submit">
					    			 Playlist#${playlist.getPlaylistId()}: ${playlist.getPlaylistName()} 
					    		</button>
				    		</form>
				    	</li>
				    </c:forEach>
				    
				   <!--  <li><button class="dropdown-item" type="button">Another action</button></li>
				    <li><button class="dropdown-item" type="button">Something else here</button></li> -->
				  </ul>
				</div>
	           
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Comments -->
      <h1>Comments</h1>
      <h3>Create a comment for this song:</h3>
      <form method="post">
        <div class="mb-3">
          <textarea
            type="text"
            name="add-comment"
            class="form-control w-25"
            id="exampleInputPassword1"
          ></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>

      <br />
      <c:if test="${usersComments.size() != 0}">
        <h3>You have some comments on this song:</h3>
        <div class="d-flex flex-wrap">
          <c:forEach items="${usersComments}" var="comment">
            <div
              class="card text-white bg-success"
              style="width: 18rem; margin: 0 1rem 1rem 0.5rem"
            >
            <div class="card-header d-flex justify-content-between">
              <div>
                <fmt:formatDate value="${comment.getCreatedAt()}" pattern="yyyy-MM-dd" /> 
              </div>
              <div>
                <fmt:formatDate value="${comment.getCreatedAt()}" pattern="hh:mm" />
              </div>
            </div>
              <div class="card-body">
                <p class="card-text">${comment.getContent()}</p>

                <div class="d-flex justify-content-end">
                  <!-- Button trigger modal -->

                  <button
                    type="button"
                    class="btn btn-danger"
                    data-bs-toggle="modal"
                    data-bs-target="#delete-modal"
                    data-bs-content="${comment.getContent()}"
                    data-bs-commentId="${comment.getCommentId()}"
                  >
                  Delete
                  </button>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:if>

      <br />
      <c:if test="${commentsInfo.size() != 0}">
	      <h3>All Comments:</h3>
	      <div class="d-flex flex-wrap">
	        <c:forEach items="${commentsInfo}" var="comment">
	          <div
	            class="card bg-light"
	            style="width: 18rem; margin: 0 1rem 1rem 0.5rem"
	          >
	            <div class="card-header d-flex justify-content-between">
	              <div>
	                <fmt:formatDate value="${comment.getCreatedAt()}" pattern="yyyy-MM-dd" /> 
	              </div>
	              <div>
	                <fmt:formatDate value="${comment.getCreatedAt()}" pattern="hh:mm" />
	              </div>
	            </div>
	            <div class="card-body">
	              <h6 class="card-subtitle" style="margin-bottom: 1rem">
	                 <a href="UserProfile?username=${comment.getUser().getUserName()}" class="text-decoration-none">${comment.getUser().getUserName()}</a> said:
	              </h6>
	              <p class="card-text">${comment.getContent()}</p>
	              <!--  <a href="#" class="card-link">Card link</a>
						    <a href="#" class="card-link">Another link</a> -->
	            </div>
	          </div>
	        </c:forEach>
	      </div>
	   </c:if>
	   <c:if test="${commentsInfo.size() == 0}">
	   		<h3 style="color:#74ae14"><i>No comments on this song yet, you can be the first one!</i></h3>
	   </c:if>
    </div>


    <div
      class="modal fade"
      id="delete-modal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <form method="post">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Delete</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
              <div class="mb-3">
                <label for="message-text" class="col-form-label"
                  >Are you gonna delete this comment?</label
                >
                <input
                type="hidden"
                name="deleteComment"
              />
                <h4 id="comment-content"></h4>
              </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Cancel
            </button>
            <button type="submit" class="btn btn-primary">Delete</button>
          </div>
        </div>
         <form method="post">
      </div>
    </div>
    
    
    <!-- Modal for "Add to playlist" -->
<!-- 	<div class="modal fade" id="playlistModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="playlistModalLabel">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div> -->

    

    <script type="text/javascript">
      const deleteModal = document.getElementById('delete-modal');
      deleteModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const comment = button.getAttribute('data-bs-content');
				const commentId = button.getAttribute('data-bs-commentId')
     
        const h4 = deleteModal.querySelector('.modal-body h4');
				const input = deleteModal.querySelector('.modal-body input')
				input.value = commentId;
        h4.textContent = comment;
      });


    </script>
    
    
    
<!--     <script type="text/javascript">
    	/* Add to playlist*/
    	const dropdownPlaylist = document.getElementById('dropdown-playlist');
    	dropdownPlaylist.addEventListener('click', function (event) {
        	document.getElementById('playlist-form').submit();
    	});
    </script>  -->

    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
      integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
      integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
      crossorigin="anonymous"
    ></script>
  </body>
</html>





