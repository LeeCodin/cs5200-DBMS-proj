package musicraze.servlet;

import musicraze.dal.*;
import musicraze.model.*;

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


/**
 * FindUsers is the primary entry point into the application.
 */
@WebServlet("/FindMusic")
public class FindMusic extends HttpServlet {

  protected SongsDao songsDao;
  protected ArtistsDao artistsDao;
  protected AlbumsDao albumsDao;

  @Override
  public void init() throws ServletException {
    songsDao = SongsDao.getInstance();
    artistsDao = ArtistsDao.getInstance();
    albumsDao = AlbumsDao.getInstance();
  }

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // Map for storing messages.
    Map<String, String> messages = new HashMap<String, String>();
    req.setAttribute("messages", messages);

    // Check if user login
    if (req.getSession().getAttribute("user") == null) {
      req.getRequestDispatcher("UserLogin.jsp").forward(req, resp);
      return;
    }

    List<Songs> songs = new ArrayList<Songs>();

    // Retrieve and validate song name.
    // firstname is retrieved from the URL query string.
    String searchItem = req.getParameter("searchItem");
    if (searchItem == null || searchItem.trim().isEmpty()) {
      messages.put("success", "Please enter a valid song name.");
    } else {
      // Retrieve songs, and store as a message.
      try {
        songs = songsDao.getSongsByName(searchItem);
      } catch (SQLException e) {
        e.printStackTrace();
        throw new IOException(e);
      }
      messages.put("success", "Displaying results for " + searchItem);
      // Save the previous search term, so it can be used as the default
      // in the input box when rendering FindUsers.jsp.
      messages.put("previousSongName", searchItem);
    }
    req.setAttribute("songs", songs);

    req.getRequestDispatcher("/FindMusic.jsp").forward(req, resp);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    // Map for storing messages.
    Map<String, String> messages = new HashMap<String, String>();
    req.setAttribute("messages", messages);

    // Check if user login
    if (req.getSession().getAttribute("user") == null) {
      req.getRequestDispatcher("UserLogin.jsp").forward(req, resp);
      return;
    }
    //String username = req.getSession().getAttribute("username").toString();
    //System.out.println("username is: " + username);

    List<Songs> songs = new ArrayList<Songs>();
    List<Artists> artists = new ArrayList<Artists>();
    List<Albums> albums = new ArrayList<Albums>();

    // Retrieve and validate name.
    // firstname is retrieved from the form POST submission. By default, it
    // is populated by the URL query string (in FindUsers.jsp).
    String searchItem = req.getParameter("searchItem");
    if (searchItem == null || searchItem.trim().isEmpty()) {
      messages.put("success", "Please enter a valid name.");
    } else {
      // Retrieve users, and store as a message.
      try {
        songs = songsDao.getSongsByName(searchItem);
        artists = artistsDao.getArtistByName(searchItem);
        albums = albumsDao.getAlbumsFromAlbumName(searchItem);
      } catch (SQLException e) {
        e.printStackTrace();
        throw new IOException(e);
      }
      messages.put("success", "Displaying results for " + searchItem);
    }
    req.setAttribute("songs", songs);
    req.setAttribute("artists", artists);
    req.setAttribute("albums", albums);
    req.getRequestDispatcher("/FindMusic.jsp").forward(req, resp);
  }
}