package musicraze.servlet;

import musicraze.model.*;
import musicraze.dal.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserProfile")
public class UserProfile extends HttpServlet {
  protected PlaylistsDao playlistsDao; 
	
  @Override
  public void init() throws ServletException {
	playlistsDao = PlaylistsDao.getInstance();
  }
  
  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    Users user = (Users) (req.getSession().getAttribute("user"));
    if (user == null) {
      res.sendRedirect("UserLogin");
      return;
    }
    
    // Get user's playlists
    List<Playlists> playlists = new ArrayList<Playlists>();
    try {
		playlists = playlistsDao.getPlaylistsForUser(user);
	} catch (SQLException e) {
		e.printStackTrace();
		throw new IOException(e);
	}
    req.setAttribute("playlists", playlists);
    
    
    req.getRequestDispatcher("/UserProfile.jsp").forward(req, res);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
	  
	  Map<String, String> messages = new HashMap<String, String>();
      req.setAttribute("messages", messages);

      String playlistIdStr = req.getParameter("playlistId");
      int playlistId = Integer.parseInt(playlistIdStr);
      
      Playlists playlist = new Playlists(playlistId);
      try {
		playlist = playlistsDao.delete(playlist);
		
		if (playlist == null) {
			messages.put("title", "Successfully deleted playlist:" + playlistId);
		} else {
			messages.put("title", "Failed to delete" + playlistId);
		}
      } catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		messages.put("title", "Failed to delete " + playlistId);
      }
      
	  
      doGet(req, res);
    
    
  }
}
