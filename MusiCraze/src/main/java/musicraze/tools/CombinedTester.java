package musicraze.tools;


import musicraze.dal.*;
import musicraze.model.*;
import static org.junit.Assert.*;
import java.sql.SQLException;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;
import java.util.List;

public class CombinedTester {
	
	public static void main(String[] args) throws Exception {
	/** ===========	Persons, Users, Administrators   =========== */
		PersonsDao personsDao = PersonsDao.getInstance();
	    UsersDao usersDao = UsersDao.getInstance();
	    AdministratorsDao administratorsDao = AdministratorsDao.getInstance();

	    // Test PersonsDao.create()
	    Persons person1 = personsDao
	        .create(new Persons("UserName1", "Password1", "FirstName1", "LastName1", "Email1"));

	    // Test PersonsDao.getPersonByUserName()
	    assertNotNull(personsDao.getPersonByUserName("UserName1"));

	    // Test PersonsDao.getPersonsByFirstName()
	    assertFalse(personsDao.getPersonsByFirstName("FirstName1").isEmpty());

	    // Test PersonsDao.updatePassword()
	    person1 = personsDao.updatePassword(person1, "newPassword");
	    assertEquals("newPassword", personsDao.getPersonByUserName("UserName1").getPassword());

	    // Test PersonsDao.updateFirstName()
	    person1 = personsDao.updateFirstName(person1, "newFirstName");
	    assertEquals("newFirstName", personsDao.getPersonByUserName("UserName1").getFirstName());

	    // Test PersonsDao.updateLastName()
	    person1 = personsDao.updateLastName(person1, "newLastName");
	    assertEquals("newLastName", personsDao.getPersonByUserName("UserName1").getLastName());

	    // Test PersonsDao.updateEmail()
	    person1 = personsDao.updateEmail(person1, "newEmail");
	    assertEquals("newEmail", personsDao.getPersonByUserName("UserName1").getEmail());

	    // Test PersonsDao.delete()
	    person1 = personsDao.delete(person1);
	    assertNull(personsDao.getPersonByUserName("UserName1"));

	    // Test UsersDao.create()
	    Date bornDate2 = new SimpleDateFormat("yyyy-MM-dd").parse("1985-12-05");
	    Instant joinDate2 = Instant.parse("2022-03-27T12:30:00Z");
	    Users user2 = usersDao.create(new Users("UserName2", "Password2", "FirstName2", "LastName2",
	        "Email2", "Avatar2", "Bio2", bornDate2, joinDate2));

	    // Test UsersDao.getUserByUserName()
	    assertNotNull(usersDao.getUserByUserName("UserName2"));

	    // Test UsersDao.getUsersByFirstName()
	    assertFalse(usersDao.getUsersByFirstName("FirstName2").isEmpty());

	    // Test UsersDao.updatePassword()
	    user2 = usersDao.updatePassword(user2, "newPassword");
	    assertEquals("newPassword", usersDao.getUserByUserName("UserName2").getPassword());

	    // Test UsersDao.updateFirstName()
	    user2 = usersDao.updateFirstName(user2, "newFirstName");
	    assertEquals("newFirstName", usersDao.getUserByUserName("UserName2").getFirstName());

	    // Test UsersDao.updateLastName()
	    user2 = usersDao.updateLastName(user2, "newLastName");
	    assertEquals("newLastName", usersDao.getUserByUserName("UserName2").getLastName());

	    // Test UsersDao.updateEmail()
	    user2 = usersDao.updateEmail(user2, "newEmail");
	    assertEquals("newEmail", usersDao.getUserByUserName("UserName2").getEmail());

	    // Test UsersDao.updateAvatar()
	    user2 = usersDao.updateAvatar(user2, "newAvatar");
	    assertEquals("newAvatar", usersDao.getUserByUserName("UserName2").getAvatar());

	    // Test UsersDao.updateBio()
	    user2 = usersDao.updateBio(user2, "newBio");
	    assertEquals("newBio", usersDao.getUserByUserName("UserName2").getBio());

	    // Test UsersDao.updateBornDate()
	    Date newBornDate = new SimpleDateFormat("yyyy-MM-dd").parse("1987-06-14");
	    user2 = usersDao.updateBornDate(user2, newBornDate);
	    assertEquals(newBornDate, usersDao.getUserByUserName("UserName2").getBornDate());

	    // Test UsersDao.delete()
	    user2 = usersDao.delete(user2);
	    assertNull(usersDao.getUserByUserName("UserName2"));

	    // Test AdministratorsDao.create()
	    Administrators administrator3 = administratorsDao
	        .create(new Administrators("UserName3", "Password3", "FirstName3", "LastName3", "Email3"));

	    // Test AdministratorsDao.getAdministratorByUserName()
	    assertNotNull(administratorsDao.getAdministratorByUserName("UserName3"));

	    // Test AdministratorsDao.getAdministratorsByFirstName()
	    assertFalse(administratorsDao.getAdministratorsByFirstName("FirstName3").isEmpty());

	    // Test AdministratorsDao.updatePassword()
	    administrator3 = administratorsDao.updatePassword(administrator3, "newPassword");
	    assertEquals("newPassword",
	        administratorsDao.getAdministratorByUserName("UserName3").getPassword());

	    // Test AdministratorsDao.updateFirstName()
	    administrator3 = administratorsDao.updateFirstName(administrator3, "newFirstName");
	    assertEquals("newFirstName",
	        administratorsDao.getAdministratorByUserName("UserName3").getFirstName());

	    // Test AdministratorsDao.updateLastName()
	    administrator3 = administratorsDao.updateLastName(administrator3, "newLastName");
	    assertEquals("newLastName",
	        administratorsDao.getAdministratorByUserName("UserName3").getLastName());

	    // Test AdministratorsDao.updateEmail()
	    administrator3 = administratorsDao.updateEmail(administrator3, "newEmail");
	    assertEquals("newEmail", administratorsDao.getAdministratorByUserName("UserName3").getEmail());

	    // Test AdministratorsDao.delete()
	    administrator3 = administratorsDao.delete(administrator3);
	    assertNull(administratorsDao.getAdministratorByUserName("UserName3"));
	
		
	/** ================   	Songs    ================*/
	    SongsDao songsDao = SongsDao.getInstance();

        Songs song1 = songsDao.create(new Songs("test", 12345, 2343));
        System.out.println(song1.getSongName() + " " + song1.getArtistId() + " " + song1.getArtistId());

        Songs song2 = songsDao.getSongById(23);

        System.out.println(song2.toString());

        song1 = songsDao.updateAlbumId(song1, 2);
        song1 = songsDao.updateArtistId(song1, 5);

        System.out.println(song1.getAlbumId());

        song1 = songsDao.delete(song1);    
		 
        
     /** ================   	Artists    ================*/
        ArtistsDao artistsDao = ArtistsDao.getInstance();
		

		// INSERT objects from our model.
		Artists evelyn = new Artists("evelynxu", "abcedf", "US", "SELF");
		evelyn = artistsDao.create(evelyn);
		System.out.format("Reading artist: id:%s name:%s  \n",
				evelyn.getArtistId(), evelyn.getArtistName());
		
		// Test get artist by id
		Artists artist_test1 = artistsDao.getArtistById(137447);
		System.out.format("Reading artist: id: %s name: %s  \n",
				artist_test1.getArtistId(), artist_test1.getArtistName());
		
		// Test get artists by name
		Artists evelynxu = new Artists("evelynxu", "xndhrhgjg", "Korea", "SELF");
		evelynxu = artistsDao.create(evelynxu);
		List<Artists> artistList = artistsDao.getArtistByName("evelynxu");
		for (Artists artist_test2 : artistList) {
			System.out.format("Listing artist: id: %s name: %s country: %s \n",
				artist_test2.getArtistId(), artist_test2.getArtistName(), artist_test2.getArtistCountry());
		}
		
		// Test artist name update
		Artists michael = new Artists("michaelchen", "888888", "US", "SELF");
		michael = artistsDao.create(michael);
		System.out.format("Reading artist: id: %s name: %s  \n",
				michael.getArtistId(), michael.getArtistName());
		
		michael = artistsDao.updateArtistName(michael, "TomChen");
		System.out.format("After updating, artist: id: %s name: %s \n",
				michael.getArtistId(), michael.getArtistName());
		
		
		// Test artist spotifyid update
		Artists bruce = new Artists("bruceLi", "000000", "US", "SELF");
		bruce = artistsDao.create(bruce);
		System.out.format("Reading artist: id: %s name: %s spotifyid: %s \n",
				bruce.getArtistId(), bruce.getArtistName(), bruce.getArtistSpotifyId());
		
		bruce = artistsDao.updateArtistSpotifyId(bruce, "77777777");
		System.out.format("After updating: id: %s name: %s spotifyid: %s \n",
				bruce.getArtistId(), bruce.getArtistName(), bruce.getArtistSpotifyId());
		
		
		// Test artist country update
		Artists jannie = new Artists("jannieTong", "9876543", "UK", "SELF");
		jannie = artistsDao.create(jannie);
		System.out.format("Reading artist: id: %s name: %s country: %s \n",
				jannie.getArtistId(), jannie.getArtistName(), jannie.getArtistCountry());
		
		jannie = artistsDao.updateArtistCountry(jannie, "Tailand");
		System.out.format("After updating: id: %s name: %s country: %s \n",
				jannie.getArtistId(), jannie.getArtistName(), jannie.getArtistCountry());
		
		
		// Test artist recordlabel update
		Artists rose = new Artists("roseWu", "9876543", "UK", "SELF");
		rose = artistsDao.create(rose);
		System.out.format("Reading artist: id: %s name: %s recordLabel: %s \n",
				rose.getArtistId(), rose.getArtistName(), rose.getArtistRecordLabel());
		
		rose = artistsDao.updateArtistRecordLabel(rose, "ROCK");
		System.out.format("Reading artist: id: %s name: %s recordLabel: %s \n",
				rose.getArtistId(), rose.getArtistName(), rose.getArtistRecordLabel());
		
		
	/** ================   	Albums    ================*/
		// DAO instances.
		AlbumsDao albumsDao = AlbumsDao.getInstance();
		
		
		// INSERT objects from our model.
		Albums album1 = new Albums("asasd45", "Yesterday once more", 1994, new Date(), 14535);
		albumsDao.delete(album1);
		album1 = albumsDao.create(album1);
		Albums album2 = new Albums("sdfgsdfg456", "Mayday", 1995, new Date(), 145885);
		albumsDao.delete(album2);
		album2 = albumsDao.create(album2);
		Albums album3 = new Albums("ss33asd45", "New World", 1999, new Date(), 145225);
		albumsDao.delete(album3);
		album3 = albumsDao.create(album3);

	
		
		// READ.
		List<Albums> pList1 = albumsDao.getAlbumsFromAlbumName("Mayday");
		
		for(Albums p : pList1) {
			System.out.format("Looping Albums: Name: %s ReleaseDate: %s Duration: %s \n",
					p.getName(), p.getReleaseDate().toString(), p.getDuration());
		}
		
		
	/** ================   	Likes, Comments    ================*/
		 LikesDao likesDao = LikesDao.getInstance();
        CommentsDao commentsDao = CommentsDao.getInstance();


        // Test UsersDao.create()
        Date bornDateForLike = new SimpleDateFormat("yyyy-MM-dd").parse("1985-12-05");
        Instant joinDateForLike = Instant.parse("2022-03-27T12:30:00Z");
        Users userForLikesComments1 = usersDao.create(new Users("UserNameTestForLikes1", "Password2", "FirstName2", "LastName2",
                "Email2", "Avatar2", "Bio2", bornDateForLike, joinDateForLike));
        Users userForLikesComments2 = usersDao.create(new Users("UserNameTestForLikes2", "Password2", "FirstName2", "LastName2",
                "Email2", "Avatar2", "Bio2", bornDateForLike, joinDateForLike));

        Songs songForLikesComments1 = songsDao.create(new Songs("songTestForLike1", 12345, 2343));
        Songs songForLikesComments2 = songsDao.create(new Songs("songTestForLike2", 12345, 2343));


        /****************TEST FOR LikesDao*******************/
        // Create Likes
        Likes likeTest1 = likesDao.create(new Likes(userForLikesComments1, songForLikesComments1, new Date()));
        Likes likeTest2 = likesDao.create(new Likes(userForLikesComments2, songForLikesComments2, new Date()));
        Likes likeTest3 = likesDao.create(new Likes(userForLikesComments2, songForLikesComments1, new Date()));

        // Get Like by id
        Likes likeById = likesDao.getLikeByLikeId(likeTest1.getLikeId());
        System.out.println("Get like by id: " + likeById.toString());

        // Get likes by userName
        List<Likes> listLikesByUserName = likesDao.getLikesByUserName(userForLikesComments2.getUserName());
        for(Likes like: listLikesByUserName) {
            System.out.println("Get likes by userName: " + like.toString());
        }

        // Get likes by songId
        List<Likes> listLikesBySongId = likesDao.getLikesBySongId(songForLikesComments1.getSongId());
        for(Likes like: listLikesBySongId) {
            System.out.println("Get likes by songId: " + like.toString());
        }

        // Delete Likes
        Likes deletedLike1 = likesDao.delete(likeTest1);
        Likes deletedLike2 = likesDao.delete(likeTest2);
        Likes deletedLike3 = likesDao.delete(likeTest3);


        if(deletedLike1 != null || deletedLike2 != null || deletedLike3 != null) {
            throw new Exception("Delete test for likes failed.");
        } else {
            System.out.println("Delete test succeeded.");
        }
        System.out.println();

        /****************TEST FOR CommentsDao*******************/
        // Create
        Comments commentTest1 = commentsDao.create(new Comments(userForLikesComments1, songForLikesComments1, "User1 comment song1", new Date()));
        Comments commentTest2 = commentsDao.create(new Comments(userForLikesComments1, songForLikesComments1, "User1 comment song1 again", new Date()));
        Comments commentTest3 = commentsDao.create(new Comments(userForLikesComments2, songForLikesComments1, "User2 comment song1", new Date()));

        // Get comment by comment id
        Comments commentGetById = commentsDao.getCommentByCommentId(commentTest1.getCommentId());
        System.out.println("Get comment by id: " + commentGetById.toString());

        // Get comments by userName
        List<Comments> commentsByUserName = commentsDao.getCommentsByUserName(userForLikesComments1.getUserName());
        for(Comments comment: commentsByUserName) {
            System.out.println("Get comments by username: " + comment.toString());
        }

        // Get comments by songId
        List<Comments> commentsBySongId = commentsDao.getCommentsBySongId(songForLikesComments1.getSongId());
        for(Comments comment: commentsBySongId) {
            System.out.println("Get comments by songId: " + comment.toString());
        }

        // Update comment
        System.out.println("Comment1 before update: " + commentsDao.getCommentByCommentId(commentTest1.getCommentId()).toString());
        commentsDao.updateContent(commentTest1, "updated content");
        System.out.println("Comment1 after updated: " + commentsDao.getCommentByCommentId(commentTest1.getCommentId()).toString());


        // Delete comments
        Comments deletedComment1 = commentsDao.delete(commentTest1);
        Comments deletedComment2 = commentsDao.delete(commentTest2);
        Comments deletedComment3 = commentsDao.delete(commentTest3);
        if(deletedComment1 != null || deletedComment2 != null || deletedComment3 != null) {
            throw new Exception("Delete comments failed.");
        } else {
            System.out.println("Delete comments test succeeded.");
        }


        // Delete test Users and songs
        usersDao.delete(userForLikesComments1);
        usersDao.delete(userForLikesComments2);
        songsDao.delete(songForLikesComments1);
        songsDao.delete(songForLikesComments2);
	        
	        
     /** ================   	Playlists, PlaylistSongContains    ================*/    
        // Instantiate DAO instances.
 		PlaylistsDao playlistsDao = PlaylistsDao.getInstance();
 		PlaylistSongContainsDao containsDao = PlaylistSongContainsDao.getInstance();
 		
 		// INSERT objects from our model.
 		// dao.create <==> INSERT statement 

 		Users userZwill = usersDao.getUserByUserName("zwillgooselr"); // the last record in users.csv;
 	    
 		
 		// Create Playlist: userZwill creats 3 new playlists:
 		
 	    Playlists playlist1 = new Playlists(userZwill, "Workout", "workout music");
 	    playlist1 = playlistsDao.create(playlist1);
 	    
 	    Playlists playlist2 = new Playlists(userZwill, "Workout", "Some more workout music");
 	    playlist2 = playlistsDao.create(playlist2);
 		
 	    Playlists playlist3 = new Playlists(userZwill, "Happy Drive", "xxxx");
 	    playlist3 = playlistsDao.create(playlist3);
 	    
 	    Playlists playlist4 = new Playlists(userZwill, "Hip hop", "!!!!");
 	    playlist4 = playlistsDao.create(playlist4);

 	    
 	    // Update playlist3:		
 		playlistsDao.updatePlaylistName(playlist3, "RoadTrip Music");
 		playlistsDao.updateDescription(playlist3, "Some good music for road trip!!");
 		
 		
 		
 		// Test whether updating a playlist's name/description would update the playlist's UpdatedAt field.
 		// Update playlist3:
 		//		playlistsDao.updatePlaylistName(playlistsDao.getPlaylistById(134), "RoadTrip Music");
 		//		playlistsDao.updateDescription(playlistsDao.getPlaylistById(134), "Some good music for road trip!!");
 		
 	    
 		 // Get playlists for userZwill: (Should have playlist1, playlist2, playlist3)
  	    List<Playlists> listOfPlaylists1 = playlistsDao.getPlaylistsForUser(userZwill);
  	    for(Playlists pl : listOfPlaylists1) {
 			System.out.format("Get Playlists For UserZwill: userName:%s playlistId:%s playlistName:%s Description: %s \n",
 			pl.getUser().getUserName(), pl.getPlaylistId(), pl.getPlaylistName(), pl.getDescription());
 		}
  	    
  	    
  	    // Get playlists by playlistName: Workout (should have playlist1, playlist2)
  	    List<Playlists> listOfPlaylists2 = playlistsDao.getPlaylistsByName("Workout");
  	    for(Playlists pl : listOfPlaylists2) {
 			System.out.format("Get Playlists By PlaylistName: userName:%s playlistId:%s playlistName:%s Description: %s \n",
 			pl.getUser().getUserName(), pl.getPlaylistId(), pl.getPlaylistName(), pl.getDescription());
 		}
  	    
  	    
  	    // Get playlist by Id: 1
  	    Playlists playlist5 = playlistsDao.getPlaylistById(1);
  	   System.out.format("Get Playlists By Id: playlistId:%s playlistName:%s Description: %s \n",
  			   playlist5.getPlaylistId(), playlist5.getPlaylistName(),playlist5.getDescription());
 	 
  	    // User2 Adds song11, song12 to playlist1
  	    Songs song11 = songsDao.getSongById(11);
  	    PlaylistSongContains contain1 = new PlaylistSongContains(playlist1, song11);
  	    contain1 =  containsDao.create(contain1);
  	    
  	    Songs song12 = songsDao.getSongById(12);
  	    PlaylistSongContains contain2 = new PlaylistSongContains(playlist1, song12);
  	    contain2 =  containsDao.create(contain2);
  	    
  	    
  	    // User2 Adds song11, song13 to playlist2
  	    PlaylistSongContains contain3 = new PlaylistSongContains(playlist2, song11);
 	    contain3 =  containsDao.create(contain3);
 	    
  	    Songs song13 = songsDao.getSongById(13);
  	    PlaylistSongContains contain4 = new PlaylistSongContains(playlist2, song13);
  	    contain4 =  containsDao.create(contain4);
 		
 		
  	    // Test whether adding a song to a playlist would update the playlist's UpdatedAt field.
  	    // User2 Adds song11, song12 to playlist1
 		// 	    Songs song11 = songsDao.getSongById(11);
 		// 	    PlaylistSongContains contain1 = new PlaylistSongContains(playlistsDao.getPlaylistById(132), song11);
 		// 	    contain1 =  containsDao.create(contain1);
 		// 	    
 		// 	    Songs song12 = songsDao.getSongById(12);
 		// 	    PlaylistSongContains contain2 = new PlaylistSongContains(playlistsDao.getPlaylistById(132), song12);
 		// 	    contain2 =  containsDao.create(contain2);
 		// 	    
 		// 	    
 		// 	    // User2 Adds song11, song13 to playlist2
 		// 	    PlaylistSongContains contain3 = new PlaylistSongContains(playlistsDao.getPlaylistById(133), song11);
 		//	    contain3 =  containsDao.create(contain3);
 		//	    
 		// 	    Songs song13 = songsDao.getSongById(13);
 		// 	    PlaylistSongContains contain4 = new PlaylistSongContains(playlistsDao.getPlaylistById(133), song13);
 		// 	    contain4 =  containsDao.create(contain4);
  	    
  	    
  	    // Get all songs for playlist1 (should contain song11 & song12)
  	    List<PlaylistSongContains> listOfContains1 = containsDao.getSongsForPlaylist(playlist1);
  	    for(PlaylistSongContains c : listOfContains1) {
  		  System.out.format("Get Songs For Playlist: playlistId:%s playlistName:%s songId:%s songName:%s\n",
  		    c.getPlaylist().getPlaylistId(), c.getPlaylist().getPlaylistName(),
  		    c.getSong().getSongId(), c.getSong().getSongName());
  	    }
  	    
  	   
 	    // Get all songs for playlist2 (should contain song11 & song13)
 	    List<PlaylistSongContains> listOfContains2 = containsDao.getSongsForPlaylist(playlist2);
 	    for(PlaylistSongContains c : listOfContains2) {
 		  System.out.format("Get Songs For Playlist: playlistId:%s playlistName:%s songId:%s songName:%s\n",
 		    c.getPlaylist().getPlaylistId(), c.getPlaylist().getPlaylistName(),
 		    c.getSong().getSongId(), c.getSong().getSongName());
 	    }
  	   
  	    // Deletes song11 from playlist2
  	    containsDao.delete(contain3);
  	    System.out.format("Song11 deleted from playlist2.\n");
  	    
  	    
  	    //  Test whether deleting a song from a playlist would update the playlist's UpdatedAt field.
  	    // Deletes song11 from playlist2
 	    // 	    containsDao.delete(containsDao.getContainById(1003));
 	    // 	    System.out.format("Song11 deleted from playlist2.\n");


  	    
  	    // Get all songs for playlist2 (NOTE: should ONLY contain song13)
  	    List<PlaylistSongContains> listOfContains3 = containsDao.getSongsForPlaylist(playlist2);
  	    for(PlaylistSongContains c : listOfContains3) {
  		  System.out.format("Get Songs For Playlist: playlistId:%s playlistName:%s songId:%s songName:%s\n",
  		    c.getPlaylist().getPlaylistId(), c.getPlaylist().getPlaylistName(),
  		    c.getSong().getSongId(), c.getSong().getSongName());
  	    }
  	    
  	    // Deletes playlist4
 		playlistsDao.delete(playlist4);
 		System.out.format("playlist4: \"Hip Hop\" deleted from playlist4.\n");    
		    
	}
	
	

}
