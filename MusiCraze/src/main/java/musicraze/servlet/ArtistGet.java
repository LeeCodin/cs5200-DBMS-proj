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

@WebServlet("/ArtistDetail")
public class ArtistGet extends HttpServlet {
	
	protected ArtistsDao artistDao;
	protected SongsDao songsDao;
	protected Artists artist;
	protected List<Songs> songs;
	protected Users user;

	@Override
	public void init() throws ServletException {
		artistDao = ArtistsDao.getInstance();
		songsDao = SongsDao.getInstance();
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Map for storing messages.
        Map<String, String> messages = new HashMap<String, String>();
        req.setAttribute("messages", messages);
        user = (Users) req.getSession().getAttribute("user");
       
        if (user == null) {
          resp.sendRedirect("UserLogin");
          return;
        }
        
        artist = null;
        songs = new ArrayList<>();
        
        String artistId = req.getParameter("artistId");
        if (artistId == null || artistId.trim().isEmpty()) {
            messages.put("success", "Song Id does not exist.");
        } else {
        	try {
        	artist = artistDao.getArtistById(Integer.valueOf(artistId));
        	songs = songsDao.getSongsByArtistId(Integer.valueOf(artistId)); 
        	}
        	catch (SQLException e) {
    			e.printStackTrace();
    			throw new IOException(e);
            }
        	messages.put("success", "Displaying albumInfo for " + artistId);
        }
        req.setAttribute("artistInfo", artist);
        req.setAttribute("songsInfo", songs);
        req.getRequestDispatcher("/ArtistDetail.jsp").forward(req, resp);
        
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//:TODO
	}
}