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
        String description = req.getParameter("newDescription");
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
        
        req.getRequestDispatcher("/PlaylistCreate.jsp").forward(req, res);
    }
}
