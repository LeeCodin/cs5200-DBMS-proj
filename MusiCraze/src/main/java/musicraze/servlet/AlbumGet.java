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

@WebServlet("/AlbumDetail")
public class AlbumGet extends HttpServlet {
	
	protected AlbumsDao albumsDao;
	protected SongsDao songsDao;
	protected List<Songs> songs;
	protected Albums album;
	protected Users user;

	@Override
	public void init() throws ServletException {
		albumsDao = AlbumsDao.getInstance();
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
        
        songs = new ArrayList<>();
        album = null;
        
        String albumId = req.getParameter("albumId");
        if (albumId == null || albumId.trim().isEmpty()) {
            messages.put("success", "Song Id does not exist.");
        } else {
        	try {
        	album = albumsDao.getAlbumById(Integer.valueOf(albumId));
        	songs = songsDao.getSongsByAlbumId(album.getAlbumId()); 
        	}
        	catch (SQLException e) {
    			e.printStackTrace();
    			throw new IOException(e);
            }
        	messages.put("success", "Displaying albumInfo for " + albumId);
        }
        req.setAttribute("albumInfo", album);
        req.setAttribute("songsInfo", songs);
        req.getRequestDispatcher("/AlbumDetail.jsp").forward(req, resp);
        
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//:TODO
	}
}