package musicraze.model;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class Guests {

  private String userName;
  private String avatar;
  private String bio;
  private Instant joinDate;

  public Guests(String userName) {
    this.userName = userName;
  }

  public Guests(String userName, String avatar, String bio, Instant joinDate) {
    this.userName = userName;
    this.avatar = avatar;
    this.bio = bio;
    this.joinDate = joinDate;
  }

  public String getUserName() {
    return this.userName;
  }

  public String getAvatar() {
    return this.avatar;
  }

  public String getBio() {
    return this.bio;
  }

  public Instant getJoinDate() {
    return this.joinDate;
  }

  public String getJoinDateStr() {
    return DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.of("UTC"))
        .format(this.joinDate);
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public void setBio(String bio) {
    this.bio = bio;
  }

  public void setJoinDate(Instant joinDate) {
    this.joinDate = joinDate;
  }
}
