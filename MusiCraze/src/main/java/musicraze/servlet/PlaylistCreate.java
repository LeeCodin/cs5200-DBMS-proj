package musicraze.servlet;

import musicraze.model.*;
import musicraze.dal.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PlaylistCreate")
public class PlaylistCreate extends HttpServlet{
	protected PlaylistsDao playlistsDao;
	
    @Override
    public void init() throws ServletException {
    	playlistsDao = PlaylistsDao.getInstance();
    }
	
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) 
    	throws ServletException, IOException {
    	
    	Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        messages.put("disableDisplayInfo", "true");
        messages.put("disableInput", "false");
        messages.put("disableSameNameWarning", "true");

    	req.getRequestDispatcher("/PlaylistCreate.jsp").forward(req, res);
    }
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) 
    	throws ServletException, IOException {
    	
    	Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        
        Users user = (Users) (req.getSession().getAttribute("user"));
        if (user == null) {
          res.sendRedirect("UserLogin");
          return;
        }
    	
        String playlistName = req.getParameter("newPlaylistName");
        System.out.println("playlistName: "+ playlistName);
        String description = req.getParameter("newDescription");
        
        // Check if the user already has an existing playlist with the same name.
        Playlists sameNamePlaylist = null;
        
        try {
			sameNamePlaylist = playlistsDao.getPlaylistByNameForUser(playlistName, user);
		} catch (SQLException e1) {
			e1.printStackTrace();
			throw new IOException(e1);
		}
        
		if (sameNamePlaylist == null) {
			Playlists playlist = new Playlists(user, playlistName, description);
			try {
				playlist = playlistsDao.create(playlist);
			} catch (SQLException e) {
				e.printStackTrace();
				throw new IOException(e);
			}
		        
	        req.setAttribute("createdPlaylistName", playlistName);
	        req.setAttribute("createdDescription", description);
	        
	        messages.put("disableDisplayInfo", "false");
	        messages.put("disableInput", "true");
	        messages.put("disableSameNameWarning", "true");
			
		} else {
			req.setAttribute("duplicatePlaylistName", playlistName);
			messages.put("disableDisplayInfo", "true");
			messages.put("disableInput", "false");
			messages.put("disableSameNameWarning", "false");
		}
        
//        Playlists playlist = new Playlists(user, playlistName, description);
//        try {
//			playlist = playlistsDao.create(playlist);
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw new IOException(e);
//		}
//        
//        req.setAttribute("createdPlaylistName", playlistName);
//        req.setAttribute("createdDescription", description);
//        
//        messages.put("disableDisplayInfo", "false");
//        messages.put("disableInput", "true");
        
        req.getRequestDispatcher("/PlaylistCreate.jsp").forward(req, res);
    }
}
