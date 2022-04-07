package musicraze.servlet;

import musicraze.dal.*;
import musicraze.model.*;

import javax.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Map;
import java.util.Date;
import java.util.HashMap;


//
//@WebServlet("/usercreate")
//public class UserCreate_Cindy extends HttpServlet {
//	protected UsersDao usersDao;
//	
//	@Override
//	public void init() throws ServletException {
//		usersDao = UsersDao.getInstance();
//	}
//	
//	
//	@Override
//	public void doGet(HttpServletRequest req, HttpServletResponse resp)
//			throws ServletException, IOException {
//		// Map for storing messages.
////        Map<String, String> messages = new HashMap<String, String>();
////        req.setAttribute("messages", messages);
//        //Just render the JSP.   
//        req.getRequestDispatcher("/UserCreate.jsp").forward(req, resp);
//	}
//	
//	@Override
//	public void doPost(HttpServletRequest req, HttpServletResponse resp)
//    		throws ServletException, IOException {
//        // Map for storing messages.
//        Map<String, String> messages = new HashMap<String, String>();
//        req.setAttribute("messages", messages);
//
//        // Retrieve and validate name.
//        String userName = req.getParameter("username");
//        if (userName == null || userName.trim().isEmpty()) {
//            messages.put("success", "Invalid UserName");
//        } else {
//        	// Create the BlogUser.
//        	String password = req.getParameter("password");
//        	String firstName = req.getParameter("firstname");
//        	String lastName = req.getParameter("lastname");
//        	String email = req.getParameter("email");
//        	String avatar = req.getParameter("avatar");
//        	String bio = req.getParameter("bio");
//        	// dob must be in the format yyyy-mm-dd.
//        	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//        	String stringBornDate = req.getParameter("borndate");
//        	Date bornDate = new Date();
//        	try {
//        		bornDate = dateFormat.parse(stringBornDate);
//        	} catch (ParseException e) {
//        		e.printStackTrace();
//				throw new IOException(e);
//        	}
//        	
//	        try {
//	        	// Exercise: parse the input for StatusLevel.
//	        	Users user = new Users(userName, password, firstName, lastName, email,
//	        		      avatar, bio, bornDate);
//	        	user = usersDao.create(user);
//	        	messages.put("success", "Successfully created " + userName);
//	        } catch (SQLException e) {
//				e.printStackTrace();
//				throw new IOException(e);
//	        }
//        }
//        
//        req.getRequestDispatcher("/UserCreate.jsp").forward(req, resp);
//    }
//	
//	
//	
//
//}
