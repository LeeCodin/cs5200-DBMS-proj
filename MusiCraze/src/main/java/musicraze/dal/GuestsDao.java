package musicraze.dal;

import musicraze.model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;

public class GuestsDao {

  private static final String SELECT =
      "SELECT UserName,Avatar,Bio,JoinDate FROM Users WHERE UserName=?;";
  private static GuestsDao instance = null;
  protected ConnectionManager connectionManager;

  private GuestsDao() {
    this.connectionManager = new ConnectionManager();
  }

  public static GuestsDao getInstance() {
    if (instance == null) {
      instance = new GuestsDao();
    }
    return instance;
  }

  public Guests getGuestByUserName(String userName) throws SQLException {
    Connection connection = null;
    PreparedStatement selectStmt = null;
    ResultSet results = null;
    try {
      connection = this.connectionManager.getConnection();
      selectStmt = connection.prepareStatement(SELECT);
      selectStmt.setString(1, userName);
      results = selectStmt.executeQuery();
      if (results.next()) {
        String avatar = results.getString("Avatar");
        String bio = results.getString("Bio");
        Instant joinDate = results.getTimestamp("JoinDate").toInstant();
        return new Guests(userName, avatar, bio, joinDate);
      }
    } catch (SQLException e) {
      e.printStackTrace();
      throw e;
    } finally {
      if (connection != null) {
        connection.close();
      }
      if (selectStmt != null) {
        selectStmt.close();
      }
      if (results != null) {
        results.close();
      }
    }
    return null;
  }
}
