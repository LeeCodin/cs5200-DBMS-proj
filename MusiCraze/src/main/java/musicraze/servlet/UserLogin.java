package musicraze.servlet;

import musicraze.dal.*;
import musicraze.model.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {

  private UsersDao usersDao;

  @Override
  public void init() throws ServletException {
    this.usersDao = UsersDao.getInstance();
  }

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    if (req.getSession().getAttribute("user") == null) {
      req.getRequestDispatcher("/UserLogin.jsp").forward(req, resp);
      return;
    }
    // just render the page
    req.getRequestDispatcher("/UserLogin.jsp").forward(req, resp);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    Map<String, String> alerts = new HashMap<>();
    try {
      String userName = this.trimString(req.getParameter("userName"));
      String password = this.trimString(req.getParameter("password"));
      if (userName.isEmpty()) {
        alerts.put("userName", "User name cannot be empty.");
      }
      if (password.isEmpty()) {
        alerts.put("password", "Password cannot be empty.");
      }
      if (alerts.size() != 0) {
        throw new IllegalArgumentException();
      }
      // Authenticate user name and user password
      Users user = this.usersDao.authenticateUserName(userName);
      
      if (user == null) {
        alerts.put("login", "User Not Found");
        throw new IllegalArgumentException();
      }
      
      user = this.usersDao.authenticateUserPassword(user, password);
    	
      if (user == null) {
          alerts.put("login", "Password Incorrect");
          throw new IllegalArgumentException();
      }
      req.getSession(true).setAttribute("user", user);
      req.setAttribute("user", user);
      resp.sendRedirect("FindMusic");
    } catch (IllegalArgumentException e) {
      req.setAttribute("alerts", alerts);
      req.getRequestDispatcher("/UserLogin.jsp").forward(req, resp);
    } catch (SQLException e) {
      e.printStackTrace();
      throw new IOException(e);
    }
  }

  private String trimString(String str) {
    return str == null ? "" : str.trim();
  }
}
