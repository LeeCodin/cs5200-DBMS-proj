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

@WebServlet("/PlaylistSongsDisplay")
public class PlaylistSongsDisplay extends HttpServlet{
	protected PlaylistSongContainsDao playlistSongContainsDao;
	protected PlaylistsDao playlistsDao;
	protected SongsDao songsDao;
	
	
    @Override
    public void init() throws ServletException {
    	playlistSongContainsDao = PlaylistSongContainsDao.getInstance();
    	playlistsDao = PlaylistsDao.getInstance();
    	songsDao = SongsDao.getInstance();
    	
    }
    
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) 
    	throws ServletException, IOException {
    	String playlistIdStr = req.getParameter("playlistId");
    	int playlistId = Integer.parseInt(playlistIdStr);
    	
    	req = getRenderPlaylistInfo(req, playlistId); 

    	Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        messages.put("disableMessage", "true");

    	req.getRequestDispatcher("/PlaylistSongsDisplay.jsp").forward(req, res);
    }
    
    
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) 
    	throws ServletException, IOException {
    	// Delete one of playlist's song
    	
  	    Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);

        String containIdStr = req.getParameter("containId");
        int containId = Integer.parseInt(containIdStr);
        
        try {
        	PlaylistSongContains contain = playlistSongContainsDao.getContainById(containId);
            String songName = contain.getSong().getSongName();
            int songId = contain.getSong().getSongId();
            
            contain = playlistSongContainsDao.delete(contain);
            // For testing Failed to delete message rendering
//            contain = playlistSongContainsDao.getContainById(1);
//            System.out.println("contain:" + contain);
      		
	  		if (contain == null) {
	  			messages.put("title", "Successfully deleted song#" + songId + ": " + songName + " from this playlist.");
	            messages.put("isSuccessful", "true");
	  			messages.put("disableMessage", "false");

	  		} else {
	  			messages.put("title", "Failed to delete song#" + songId + ": " + songName + " from this playlist.");
	  			messages.put("isSuccessful", "false");
	  			messages.put("disableMessage", "false");

	  		}
        } catch (SQLException e) {
        	e.printStackTrace();
        	throw new IOException(e);
        }
        
  	  
        // Re-gain playlistid from jsp form.
        // Ensure the page gets rendered again after submitting form(i.e. removing song from playlist).
        String playlistIdStr = req.getParameter("playlistId");
        int playlistId = Integer.parseInt(playlistIdStr);
        
        req = getRenderPlaylistInfo(req, playlistId);
 
        req.getRequestDispatcher("/PlaylistSongsDisplay.jsp").forward(req, res);
    }
    
    
    public HttpServletRequest getRenderPlaylistInfo(HttpServletRequest req, int playlistId) throws IOException {
    	String playlistName = null;
    	String description = null;
    	List<PlaylistSongContains> playlistSongContains = new ArrayList<PlaylistSongContains>();
    	
    	
    	try {
			Playlists playlist = playlistsDao.getPlaylistById(playlistId);
			playlistName = playlist.getPlaylistName();
			description = playlist.getDescription();
			playlistSongContains = playlistSongContainsDao.getSongsForPlaylist(playlist);
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new IOException(e);
		}
    	req.setAttribute("playlistId", playlistId);
    	req.setAttribute("playlistName", playlistName);
    	req.setAttribute("description", description);
    	req.setAttribute("playlistSongContains",playlistSongContains);
    	return req;
    }
}
