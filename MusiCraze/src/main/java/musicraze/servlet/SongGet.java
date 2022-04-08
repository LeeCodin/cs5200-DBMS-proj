package musicraze.servlet;

import musicraze.dal.*;
import musicraze.model.*;

import java.io.IOException;
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
	
	@Override
	public void init() throws ServletException {
		songsDao = SongsDao.getInstance();
		commentsDao = CommentsDao.getInstance();
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Map for storing messages.
        Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        Users user = (Users) req.getSession().getAttribute("user");
        Songs song = null;
        List<Comments> comments = new ArrayList<>();
        List<Comments> usersComments = new ArrayList<>();
        
        // Retrieve and validate name.
        // firstname is retrieved from the URL query string.
        String songId = req.getParameter("songId");
        System.out.println(songId + "123");
        if (songId == null || songId.trim().isEmpty()) {
            messages.put("success", "Song Id does not exist.");
        } else {
        	// Retrieve users, and store as a message.
        	try {
            	song = songsDao.getSongById(Integer.valueOf(songId));
             	comments = commentsDao.getCommentsBySongId(Integer.valueOf(songId));
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
        req.getRequestDispatcher("/SongDetail.jsp").forward(req, resp);
	}
	
	@Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
    		throws ServletException, IOException {
        // Map for storing messages.
        Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        

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
        req.setAttribute("users", song);
        
        req.getRequestDispatcher("/SongDetail.jsp").forward(req, resp);
    }
}
