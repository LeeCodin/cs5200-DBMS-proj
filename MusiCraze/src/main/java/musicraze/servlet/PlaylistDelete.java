//package musicraze.servlet;
//
//import musicraze.dal.*;
//import musicraze.model.*;
//
//import javax.servlet.annotation.*;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@WebServlet("/playlistdelete")
//public class PlaylistDelete extends HttpServlet{
//  protected PlaylistsDao playlistsDao; 
//	
//  @Override
//  public void init() throws ServletException {
//	playlistsDao = PlaylistsDao.getInstance();
//  }
//  
//  @Override
//  public void doGet(HttpServletRequest req, HttpServletResponse res)
//      throws ServletException, IOException {
//  }
//  
//  @Override
//  public void doPost(HttpServletRequest req, HttpServletResponse res)
//      throws ServletException, IOException {
//	  Map<String, String> messages = new HashMap<String, String>();
//      req.setAttribute("messages", messages);
//      
////      messages.put("test", "??");
//      String playlistIdStr = req.getParameter("playlistId");
//      int playlistId = Integer.parseInt(playlistIdStr);
//      
//      Playlists playlist = new Playlists(playlistId);
//      try {
//		playlist = playlistsDao.delete(playlist);
//		
//		if (playlist == null) {
//			messages.put("title", "Successfully deleted playlist:" + playlistId);
//			messages.put("disableSubmit", "true");
//		} else {
//			messages.put("title", "Failed to delete" + playlistId);
//			messages.put("disableSubmit", "false");
//		}
//      } catch (SQLException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//		messages.put("title", "Failed to delete " + playlistId);
//    	messages.put("disableSubmit", "false");
//      }
//      UserProfile userProfileServlet = new UserProfile();
//      userProfileServlet.doGet(req, res);
////      req.getRequestDispatcher("/UserProfile.jsp").forward(req, res);
//      
//  }
//  
//  
//}
