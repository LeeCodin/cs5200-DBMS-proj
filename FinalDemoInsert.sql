INSERT INTO Persons(UserName, Password, FirstName, LastName, Email)
  VALUES("cathy55", "cathy55", "Cathy", "Dayton","cdaytonjs@wsj.com");

INSERT INTO Users(UserName, Avatar, Bio, BornDate, JoinDate)
  VALUES("cathy55", "https://cdn.pixabay.com/photo/2017/04/11/22/25/megaphone-2223049_960_720.png", 
  "Bacon scholar. Future teen idol. Tv junkie. Wannabe twitter enthusiast. Web fanatic. Beer evangelist. Food buff.", "1994-05-11","2020-01-30 15:34:09");


INSERT INTO Comments(UserName, SongId, Content, CreatedAt)
  VALUES("cathy55", 24680, "Am I the only one listening to this masterpiece in 2021?", "2021-10-23 14:27:09");
  
INSERT INTO Comments(UserName, SongId, Content, CreatedAt)
  VALUES("ecaughtead", 24680, "This is one of the saddest and yet most beautiful songs ever written.", "2020-03-09 20:09:09");
  
INSERT INTO Comments(UserName, SongId, Content, CreatedAt)
  VALUES("jnoice7c", 24680, "This song, along with 'Lucky' are her best songs and music videos in my book. I get emotional EVERYTIME! ", "2022-03-09 15:34:09");
  
INSERT INTO Playlists(PlaylistId, UserName,PlaylistName, Description, CreatedAt, UpdatedAt)
  VALUES(200, "cathy55", "Late 90s Early 00s pop", "My favorite iconic Pop hits from late 90s early 00s", "2020-03-07 06:40:43", "2020-05-10 10:30:20");
  
INSERT INTO Playlists(PlaylistId, UserName,PlaylistName, Description, CreatedAt, UpdatedAt)
  VALUES(201, "cathy55", "Acoustic hits", "Instant classics from over the years loaded into one sweet mix", "2020-06-14 06:40:43", "2020-06-14 10:30:20");

INSERT INTO Playlists(PlaylistId, UserName,PlaylistName, Description, CreatedAt, UpdatedAt)
  VALUES(202, "cathy55", "Happy Monday", "Banish Monday Morning Blues with this uplifting playlist of happy songs and good mood music", "2020-12-13 10:30:19", "2020-12-13 10:30:19");

INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 1600);
  
INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 26462);
  
INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 70301);
  
INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 24680);
  
INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 24689);

INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 42073);
  
INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 58285);
  
INSERT INTO PlaylistSongContains(PlaylistId, SongId)
  VALUES(200, 13242);
  
# Create Likes for Toxic
INSERT INTO Likes (UserName, SongId)
  VALUES("aribab6", 24674), ("ealenov9a", 24674), ("echadbournr5", 24674), ("wdooleq6", 24674), ("sbusseyo3",24674), ("rfrodsamcc", 24674);
# Create Likes for ...Baby One More Time
INSERT INTO Likes (UserName, SongId)
  VALUES("aribab6", 24681), ("ealenov9a", 24681), ("echadbournr5", 24681), ("wdooleq6", 24681), ("sbusseyo3",24681), ("rfrodsamcc", 24681), ("cathy55", 24681);

# Create Likes for Lucky 24689
INSERT INTO Likes (UserName, SongId)
  VALUES("aribab6", 24689), ("wdooleq6", 24689), ("sbusseyo3",24689), ("rfrodsamcc", 24689), ("cathy55", 24689);
  
# Create Likes for Everytime
INSERT INTO Likes (UserName, SongId)
  VALUES("aribab6", 24680), ("ealenov9a", 24680), ("echadbournr5", 24680), ("wdooleq6", 24680), ("sbusseyo3",24680),  ("cathy55", 24680);

# Create Likes
INSERT INTO Likes (UserName, SongId)
  VALUES("aribab6", 24676), ("ealenov9a", 24676), ("echadbournr5", 24676); 
  