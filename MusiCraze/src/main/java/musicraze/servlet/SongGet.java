package musicraze.servlet;

import musicraze.dal.*;
import musicraze.model.*;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.annotation.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * FindUsers is the primary entry point into the application.
 */
@WebServlet("/SongDetail")
public class SongGet extends HttpServlet {
	
	protected SongsDao songsDao;
	protected CommentsDao commentsDao;
	protected LikesDao likesDao;
	protected PlaylistsDao playlistsDao;
	protected PlaylistSongContainsDao playlistSongContainsDao;
	protected Users user;
    protected Songs song;
    protected List<Comments> comments;
    protected List<Comments> usersComments;
    protected List<Likes> likes;
    protected List<Playlists> playlists;
    private boolean liked = false;

	@Override
	public void init() throws ServletException {
		songsDao = SongsDao.getInstance();
		commentsDao = CommentsDao.getInstance();
		likesDao = LikesDao.getInstance();
		playlistsDao = PlaylistsDao.getInstance();
		playlistSongContainsDao = PlaylistSongContainsDao.getInstance();
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		user = (Users) req.getSession().getAttribute("user");
        if (user == null) {
          resp.sendRedirect("UserLogin");
          return;
        }
		
		// Set empty Map for messages.
        Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        
        getRenderInfo(req, resp, messages);
        
        req.getRequestDispatcher("/SongDetail.jsp").forward(req, resp);
	}
	
	
	public void getRenderInfo(HttpServletRequest req, HttpServletResponse resp, Map<String, String> messages) throws IOException {
        song = null;
        comments = new ArrayList<>();
        usersComments = new ArrayList<>();
        likes = new ArrayList<>();
        playlists = new ArrayList<Playlists>();
        
        
        // Retrieve and validate name.
        // firstname is retrieved from the URL query string.
        String songId = req.getParameter("songId");
        System.out.println("songId: " + songId);
        if (songId == null || songId.trim().isEmpty()) {
            messages.put("success", "Song Id does not exist.");
        } else {
        	// Retrieve users, and store as a message.
        	try {
            	song = songsDao.getSongById(Integer.valueOf(songId));
             	comments = commentsDao.getCommentsBySongId(Integer.valueOf(songId));
             	likes = likesDao.getLikesBySongId(Integer.valueOf(songId));
             	playlists = playlistsDao.getPlaylistsForUser(user);
                 // Sort comments by their dates.
                Collections.sort(comments, new Comparator<Comments>() {
                    @Override
                    public int compare(Comments o1, Comments o2) {
                        return o2.getCreatedAt().compareTo(o1.getCreatedAt());
                    }
                });

                 // Check and add this user's comments
                 for(Comments comment: comments) {
                    if(comment.getUser().getUserName().equals(user.getUserName())) {
                        usersComments.add(comment);
                    }
                }

                 // Check whether the user likes this song or not
                boolean flag = false;
                for(Likes like: likes) {
                    if(like.getUser().getUserName().equals(user.getUserName())) {
                        flag = true;
                        break;
                    }
                }
                liked = flag;
                
            } catch (SQLException e) {
    			e.printStackTrace();
    			throw new IOException(e);
            }
        	messages.put("success", "Displaying results for " + songId);
        	// Save the previous search term, so it can be used as the default
        	// in the input box when rendering FindUsers.jsp.
        	//messages.put("previousFirstName", firstName);
        }
        req.setAttribute("songInfo", song);
        req.setAttribute("commentsInfo", comments);
        req.setAttribute("usersComments", usersComments);
        req.setAttribute("likesCounts", likes.size());
        req.setAttribute("liked", liked);
        req.setAttribute("playlists", playlists);
		
	}
	
	@Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
		user = (Users) req.getSession().getAttribute("user");
        if (user == null) {
          resp.sendRedirect("UserLogin");
          return;
        }
		
		
        // Map for storing messages.
        Map<String, String> messages = new HashMap<String, String>();
        String songId = req.getParameter("songId");
        req.setAttribute("messages", messages);
        
        // Create New Comment.
        String comment = req.getParameter("add-comment");
        if(comment != null && comment.length() > 0) {
        	  System.out.println("new comment: " + comment);
              String content = comment;
              Date createdAt = new Date();
            try {
                Comments newComment = commentsDao.create(new Comments(user, song, content, createdAt));
            } catch (SQLException e) {
                e.printStackTrace();
                throw new IOException(e);
            }
        }
        
        // Update Comment
        String commentId = req.getParameter("comment-id");
        String updateComment = req.getParameter("update-comment");
        if(updateComment != null && updateComment.length() > 0) {
        	 System.out.println("updated comment: " + updateComment);
        	 try {
 				Comments updatedComment = commentsDao.updateContentByCommentId(Integer.valueOf(commentId), updateComment);
 			} catch (NumberFormatException | SQLException e) {
 				e.printStackTrace();
 				throw new IOException(e);
 			}
        }
        
        // Delete Comment.
        String deleteComment = req.getParameter("deleteComment");
        if(deleteComment != null && deleteComment.length() > 0) {
        	  System.out.println("deleted comment: " + deleteComment);
        	  try {
				commentsDao.deleteByCommentId(Integer.valueOf(deleteComment));
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
				throw new IOException(e);
			}
        }

        // Like and Unlike
        boolean likeClicked = req.getParameter("like-song") != null;
        if(likeClicked) {
            // Create or Delete the like
            if(!liked) {
                try {
                	System.out.println("create the like of username: " + user.getUserName()+ " and songId: " +  song.getSongId());
                    likesDao.create(new Likes(user, song, new Date()));
                } catch (SQLException e) {
                    e.printStackTrace();
                    throw new IOException(e);
                }
            } else {
                try {
                    System.out.println("delete the like of username: " + user.getUserName()+ " and songId: " +  song.getSongId());
                    likesDao.deleteLikeByUserNameAndSongId(user.getUserName(), song.getSongId());
                } catch (SQLException e) {
                    e.printStackTrace();
                    throw new IOException(e);
                }
            }
        }
        
        
        
        // Add the current song to Playlist
        String playlistIdStr = req.getParameter("playlistId");
        if (playlistIdStr != null && playlistIdStr.length() > 0) {
        	int playlistId = Integer.parseInt(playlistIdStr);
        	Playlists playlist = null;
        	Songs currentSong = null;
        	try {
				playlist = playlistsDao.getPlaylistById(playlistId);
				currentSong = songsDao.getSongById(Integer.parseInt(songId));
        	} catch (SQLException e) {
				e.printStackTrace();
				throw new IOException(e);
			}
        	
        	try {
        		PlaylistSongContains existContain = playlistSongContainsDao.getContainBySongIdPlaylistId(
        				currentSong.getSongId(), playlist.getPlaylistId());
        		// Check if the song is already in the playlist
        		if (existContain == null) {
        			PlaylistSongContains newContain = new PlaylistSongContains(playlist, currentSong);
        			newContain = playlistSongContainsDao.create(newContain);
        			System.out.println("Created new contain, id: " + newContain.getContainId() + " songId: " + currentSong.getSongId() + " playlistId: " + playlist.getPlaylistId());
        			messages.put("addToPlaylistSucceed", "true");
        			messages.put("addToPlaylistMsg", "Successfully Added " + "\"" + currentSong.getSongName() + "\" to playlist: \"" + playlist.getPlaylistName() + "\"");
        		} else {
        			System.out.println("Failed to Created new contain, songId: " + currentSong.getSongId() + " playlistId: " + playlist.getPlaylistId() + ". The song is already in the playlist");
        			messages.put("addToPlaylistSucceed", "false");
        			messages.put("addToPlaylistMsg", "\"" + currentSong.getSongName() + "\" is already in playlist: " + playlist.getPlaylistName());
        		} 
        	} catch (SQLException e) {
				e.printStackTrace();
				throw new IOException(e);
			}
			
        }
        
        
        // Create New Playlist (and Add the current song?)
        String newPlaylistName = req.getParameter("newPlaylistName");
        String newDescription = req.getParameter("newDescription");
        System.out.println("newPlaylistName: "+ newPlaylistName);
        
        if (newPlaylistName == null || newPlaylistName.length() == 0) {
        	
        	System.out.println("SuccessMsg" + messages.get("createPlaylistSucceed"));
        	System.out.println("WarnMsg" + messages.get("disableNameWarning"));
//        } else if (newPlaylistName.length() == 0){
//        	messages.put("disableNameWarning", "false");
//        	messages.put("nameWarningType", "empty");        	
        } else {
        	// Check if the user already has an existing playlist with the same name.
            Playlists sameNamePlaylist = null;
            
            try {
    			sameNamePlaylist = playlistsDao.getPlaylistByNameForUser(newPlaylistName, user);
    		} catch (SQLException e1) {
    			e1.printStackTrace();
    			throw new IOException(e1);
    		}
            
    		if (sameNamePlaylist == null) {
    			Playlists playlist = new Playlists(user, newPlaylistName, newDescription);
    			try {
    				playlist = playlistsDao.create(playlist);
    			} catch (SQLException e) {
    				e.printStackTrace();
    				throw new IOException(e);
    			}
    		        
//    	        req.setAttribute("createdPlaylistId", playlist.getPlaylistId());
    			req.setAttribute("createdPlaylistName", newPlaylistName);
//    	        req.setAttribute("createdDescription", newDescription);
    			System.out.println("Successfully created playlist!");
    	        
//    	        messages.put("disableDisplayInfo", "false");
//    	        messages.put("disableInput", "true");
    	        messages.put("disableNameWarning", "true");
    			messages.put("createPlaylistSucceed", "true");
    			
    		} else {
    			req.setAttribute("duplicatePlaylistName", newPlaylistName);
//    			messages.put("disableDisplayInfo", "true");
//    			messages.put("disableInput", "false");
    			messages.put("disableNameWarning", "false");
    			messages.put("nameWarningType", "duplicate");
    		}
        }
        
        System.out.println("After route: messages:"+ messages);
        
        
        

        //List<Users> users = new ArrayList<Users>();
        Songs song = null;
        // Retrieve and validate name.
        // firstname is retrieved from the form POST submission. By default, it
        // is populated by the URL query string (in FindUsers.jsp).
        String songTitle = req.getParameter("songTitle");
        if (songTitle == null || songTitle.trim().isEmpty()) {
            messages.put("success", "Please enter a valid song Title.");
        } else {
        	// Retrieve users, and store as a message.
        	try {
            	song = songsDao.getSongById(Integer.valueOf(songTitle)); //TODO);
            } catch (SQLException e) {
    			e.printStackTrace();
    			throw new IOException(e);
            }
        	messages.put("success", "Displaying songs with title " + songTitle);
        }
       
        // req.setAttribute("users", song); //??
       
        // Redirect to the same page
        // resp.sendRedirect(req.getContextPath() + "/SongDetail?songId=" + songId);
        
        
        getRenderInfo(req, resp, messages);
        req.getRequestDispatcher("/SongDetail.jsp").forward(req, resp);
 
    }
}
