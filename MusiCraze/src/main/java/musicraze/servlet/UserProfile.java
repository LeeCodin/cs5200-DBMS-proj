package musicraze.servlet;

import musicraze.model.*;
import musicraze.dal.*;
import java.io.IOException;
import java.sql.SQLException;
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

  private GuestsDao guestsDao;
  private UsersDao usersDao;
  protected PlaylistsDao playlistsDao;

  @Override
  public void init() throws ServletException {
    this.guestsDao = GuestsDao.getInstance();
    this.usersDao = UsersDao.getInstance();
    this.playlistsDao = PlaylistsDao.getInstance();
  }

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    Users user = (Users) (req.getSession().getAttribute("user"));
    if (user == null) {
      res.sendRedirect("UserLogin");
      return;
    }
    String username = req.getParameter("username");
    System.out.println("username: " + username);
    Boolean isOwner = username == null || username.equals(user.getUserName());
    try {
      if (isOwner) {
        List<Playlists> playlists = this.playlistsDao.getPlaylistsForUser(user);
        req.setAttribute("playlists", playlists);
      } else {
        Guests guest = this.guestsDao.getGuestByUserName(username);
        req.setAttribute("guest", guest);
        
        Users guestUser = this.usersDao.getUserByUserName(username);
        List<Playlists> playlists = this.playlistsDao.getPlaylistsForUser(guestUser);
        req.setAttribute("playlists", playlists);
      }
    } catch (SQLException ignored) {
    }
    req.getRequestDispatcher("/UserProfile.jsp").forward(req, res);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {

    // Delete user's playlist
    Map<String, String> messages = new HashMap<String, String>();
    req.setAttribute("messages", messages);

    String playlistIdStr = req.getParameter("playlistId");
    int playlistId = Integer.parseInt(playlistIdStr);

    Playlists playlist = null;
    try {
      playlist = playlistsDao.getPlaylistById(playlistId);
    } catch (SQLException e) {
      e.printStackTrace();
      throw new IOException(e);
    }
    
    String playlistName = playlist.getPlaylistName();
    
    try {
      playlist = playlistsDao.delete(playlist);

      if (playlist == null) {
        messages.put("title", "Successfully deleted playlist: \"" + playlistName + "\"");
        messages.put("isSuccessful", "true");
        messages.put("disableMessage", "false");
      } else {
        messages.put("title", "Failed to delete playlist: \"" + playlistName + "\"");
        messages.put("isSuccessful", "false");
        messages.put("disableMessage", "false");
      }
    } catch (SQLException e) {
      e.printStackTrace();
      messages.put("title", "Failed to delete playlist: \"" + playlistName + "\"");
    }
    doGet(req, res);
  }
}
