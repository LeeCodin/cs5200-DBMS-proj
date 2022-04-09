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
    <script src="js/bootstrap.min.js"></script>
  </head>
  <body>
    <div style="margin: 1% 3% 3% 3%">
      <h1>Song Detail</h1>
      <table class="table">
        <thead>
          <tr>
            <th scope="col">Song Title</th>
            <th scope="col">Artist Name</th>
            <th scope="col">Artist Country</th>
            <th scope="col">Album</th>
            <th scope="col">Year</th>
            <th scope="col">Release Date</th>
            <th scope="col" style="width:8rem;">Likes</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>${songInfo.getSongName()}</td>
            <td>${songInfo.getArtist().getArtistName()}</td>
            <td>${songInfo.getArtist().getArtistCountry()}</td>
            <td>${songInfo.getAlbum().getName()}</td>
            <td>${songInfo.getAlbum().getYear()}</td>
            <td>${songInfo.getAlbum().getReleaseDate()}</td>
            <td>
            	<div class="d-flex">
            		<div style="margin-right:1rem;">
            		  	${likesCounts}
            		</div>
	            	<form method="post" id="like-song">
	           			<input type="hidden" name="like-song" value="true"/>
	            		 <a href="javascript:{}" onclick="document.getElementById('like-song').submit();">
	            		 	<%boolean liked = (boolean)request.getAttribute("liked"); %>
	            		 	<c:choose>
	            		 		<c:when test="${not liked}">
	            		 		like
	            		 	</c:when>
	            		 	<c:otherwise>
	            		 		unlike
	            		 	</c:otherwise>
	            		 	</c:choose>
	            		 
						</a>
	            	</form>
            	</div>       
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Comments -->
      <h1>Comments</h1>
      <h3>You can create a comment for this song:</h3>
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
              <div class="card-header">${comment.getCreatedAt()}</div>
              <div class="card-body">
                <p class="card-text">${comment.getContent()}</p>

                <div class="d-flex justify-content-between">
                  <!-- Button trigger modal -->
                  <button
                    type="button"
                    class="btn btn-warning"
                    data-bs-toggle="modal"
                    data-bs-target="#exampleModal"
                    data-bs-content="${comment.getContent()}"
										data-bs-commentId="${comment.getCommentId()}"
                  >
                    Update
                  </button>
                  <div style="right: 1rem">
                    <form method="post">
                      <input
                        type="hidden"
                        name="deleteComment"
                        value="${comment.getCommentId()}"
                      />
                      <button class="btn btn-danger">Delete</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:if>

      <br />
      <h3>All Comments:</h3>
      <div class="d-flex flex-wrap">
        <c:forEach items="${commentsInfo}" var="comment">
          <div
            class="card bg-light"
            style="width: 18rem; margin: 0 1rem 1rem 0.5rem"
          >
            <div class="card-header">${comment.getCreatedAt()}</div>
            <div class="card-body">
              <h6 class="card-subtitle" style="margin-bottom: 1rem">
                ${comment.getUser().getUserName()} said:
              </h6>
              <p class="card-text">${comment.getContent()}</p>
              <!--  <a href="#" class="card-link">Card link</a>
					    <a href="#" class="card-link">Another link</a> -->
            </div>
          </div>
        </c:forEach>
      </div>
    </div>

    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <form method="post">
        <div class="modal-content">
        
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Update</h5>
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
                  >Your comment:</label
                >
								<input type="hidden" name="comment-id"/>
                <textarea
                  class="form-control"
                  id="message-text"
                  name="update-comment"
                ></textarea>
              </div>
        
          </div>
          
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Close
            </button>
            <button type="submit" class="btn btn-primary">Update</button>
          </div>
  
        </div>
        
         <form method="post">
      </div>
    </div>

    <script type="text/javascript">
      var exampleModal = document.getElementById('exampleModal');
      exampleModal.addEventListener('show.bs.modal', function (event) {
        // Button that triggered the modal
        var button = event.relatedTarget;
        // Extract info from data-bs-* attributes
        var comment = button.getAttribute('data-bs-content');
				var commentId = button.getAttribute('data-bs-commentId')
        // If necessary, you could initiate an AJAX request here
        // and then do the updating in a callback.
        var textarea = exampleModal.querySelector('.modal-body textarea');
				var input = exampleModal.querySelector('.modal-body input')
        textarea.value = comment;
				input.value = commentId;
      });
    </script>

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
