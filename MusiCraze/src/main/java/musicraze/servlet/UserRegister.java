package musicraze.servlet;

import musicraze.dal.*;
import musicraze.model.*;
import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.annotation.*;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {

  private UsersDao usersDao;

  @Override
  public void init() throws ServletException {
    this.usersDao = UsersDao.getInstance();
  }

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    if (req.getSession().getAttribute("user") == null) {
      req.getRequestDispatcher("/UserRegister.jsp").forward(req, res);
      return;
    }
    res.sendRedirect("FindMusic");
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {
    Map<String, String> alerts = new HashMap<>();
    String[] inputs = this.retrieveActualInputs(req);
    try {
      String userName = this.validateUserName(inputs[0]);
      String password = this.validatePassword(inputs[1]);
      String firstName = this.validateLegalName(inputs[2]);
      String lastName = this.validateLegalName(inputs[3]);
      String email = this.validateEmail(inputs[4]);
      String avatar = this.validateAvatar(inputs[5]);
      String bio = inputs[6];
      Date bornDate = this.validateBornDate(inputs[7]);
      if (userName == null) {
        alerts.put("userName", "User name must contain only letters or numbers.");
      } else if (this.usersDao.isDuplicatedUserName(userName)) {
        alerts.put("userName", "User name already exists. Please try another.");
      }
      if (password == null) {
        alerts.put("password", "Password cannot be empty or contain spaces.");
      }
      if (firstName == null) {
        alerts.put("firstName", "First name must contain only letters or spaces.");
      }
      if (lastName == null) {
        alerts.put("lastName", "Last name must contain only letters or spaces.");
      }
      if (email == null) {
        alerts.put("email", "Email must be formatted correctly.");
      }
      if (avatar == null) {
        alerts.put("avatar", "Avatar URL must be valid.");
      }
      if (bornDate == null) {
        alerts.put("bornDate",
            "Born date must be in format: yyyy-MM-dd. You must be 18+ to use MusiCraze.");
      }
      if (alerts.size() != 0) {
        throw new IllegalArgumentException();
      }
      this.usersDao.create(new Users(userName, password, firstName, lastName, email, avatar, bio, bornDate, Instant.now()));
      res.sendRedirect("UserLogin");
    } catch (IllegalArgumentException e) {
      req.setAttribute("alerts", alerts);
      req.setAttribute("inputs", inputs);
      req.getRequestDispatcher("/UserRegister.jsp").forward(req, res);
    } catch (SQLException e) {
      e.printStackTrace();
      throw new IOException(e);
    }
  }

  private String[] retrieveActualInputs(HttpServletRequest req) {
    String[] inputs = new String[8];
    inputs[0] = this.trimString(req.getParameter("userName"));
    inputs[1] = this.trimString(req.getParameter("password"));
    inputs[2] = this.trimString(req.getParameter("firstName"));
    inputs[3] = this.trimString(req.getParameter("lastName"));
    inputs[4] = this.trimString(req.getParameter("email"));
    inputs[5] = this.trimString(req.getParameter("avatar"));
    inputs[6] = this.trimString(req.getParameter("bio"));
    inputs[7] = this.trimString(req.getParameter("bornDate"));
    return inputs;
  }

  private String trimString(String str) {
    return str == null ? "" : str.trim();
  }

  private String validateUserName(String userName) {
    if (userName.matches("^[A-Za-z0-9]+$")) {
      return userName.toLowerCase();
    }
    return null;
  }

  private String validatePassword(String password) {
    if (password.contains(" ") || password.isEmpty()) {
      return null;
    }
    return password;
  }

  private String validateLegalName(String legalName) {
    if (legalName.matches("^[ A-Za-z]+$")) {
      return legalName;
    }
    return null;
  }

  private String validateEmail(String email) {
    if (email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
      return email;
    }
    return null;
  }

  private String validateAvatar(String avatar) {
    try {
      if (ImageIO.read(new URL(avatar)) != null) {
        return avatar;
      }
    } catch (Exception ignored) {
    }
    return null;
  }

  private Date validateBornDate(String bornDate) {
    try {
      if (Period.between(LocalDate.parse(bornDate), LocalDate.now()).getYears() >= 18) {
        return new SimpleDateFormat("yyyy-MM-dd").parse(bornDate);
      }
    } catch (Exception ignored) {
    }
    return null;
  }
}
