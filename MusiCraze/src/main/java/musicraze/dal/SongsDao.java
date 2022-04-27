package musicraze.dal;

import musicraze.model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SongsDao {
    protected ConnectionManager connectionManager;
    private static SongsDao instance = null;

    private static final String INSERT = "INSERT INTO Songs(SongName, ArtistId, AlbumId) VALUES(?,?,?);";
    private static final String GETBYSONGID = "SELECT * FROM Songs INNER JOIN Artists ON Songs.artistId = Artists.artistId WHERE SongId = ?;";
    private static final String GETBYSONGNAME = "SELECT * FROM Songs INNER JOIN Artists ON Songs.artistId = Artists.artistId WHERE SongName = ?;";
    private static final String GETBYALBUMID = "SELECT * FROM Songs WHERE AlbumId = ?;";
    private static final String GETBYARTISTID = "SELECT * FROM \r\n"
    		+ "	Songs INNER JOIN ( SELECT Songs.SongId AS SongId, COUNT(Likes.LikeId) AS CNT FROM Songs INNER JOIN Likes ON Songs.SongId = Likes.SongId"
    		+ "    WHERE ArtistId = ?"
    		+ "    GROUP BY SongId"
    		+ "    ORDER BY CNT DESC) AS like_table"
    		+ " ON Songs.SongId = like_table.SongId"
    		+ " ORDER BY like_table.CNT DESC"
    		+ " LIMIT 10; ";
    private static final String DELETE = "DELETE FROM Songs WHERE SongId = ?;";
    private static final String UPDATE_SONGNAME = "UPDATE Songs SET SongName = ? WHERE SongId = ?;";
    private static final String UPDATE_ARTISTID = "UPDATE Songs SET ArtistId = ? WHERE SongId = ?;";
    private static final String UPDATE_ALBUMID = "UPDATE Songs SET AlbumId = ? WHERE SongId = ?;";

    protected SongsDao() {
        this.connectionManager = new ConnectionManager();
    }

    public static SongsDao getInstance() {
        if (instance == null) {
            instance = new SongsDao();
        }
        return instance;
    }

    public Songs create(Songs songs) throws SQLException {
        Connection connection = null;
        PreparedStatement insertStmt = null;
        ResultSet resultKey = null;
        try {
            connection = connectionManager.getConnection();
            insertStmt = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
            insertStmt.setString(1, songs.getSongName());
            insertStmt.setInt(2, songs.getArtist().getArtistId());
            insertStmt.setInt(3, songs.getAlbum().getAlbumId());
            insertStmt.executeUpdate();

            resultKey = insertStmt.getGeneratedKeys();
            int songId = -1;
            if (resultKey.next()) {
                songId = resultKey.getInt(1);
            } else {
                throw new SQLException("Unable to retrieve auto-generated key");
            }

            songs.setSongId(songId);
            return songs;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (connection != null) {
                connection.close();
            }
            if (insertStmt != null) {
                insertStmt.close();
            }
            if (resultKey != null) {
                resultKey.close();
            }
        }
    }

    public Songs getSongById(Integer songId) throws SQLException {
        Connection connection = null;
        PreparedStatement selectStmt = null;
        ResultSet results = null;
        try {
            connection = this.connectionManager.getConnection();
            selectStmt = connection.prepareStatement(GETBYSONGID);
            selectStmt.setInt(1, songId);
            results = selectStmt.executeQuery();
            if (results.next()) {
                Integer resultId = results.getInt("SongId");
                String songName = results.getString("SongName");
                Integer artistId = results.getInt("ArtistId");
                Integer albumId = results.getInt("AlbumId");
                String artistName = results.getString("ArtistName");
                String artistSpotifyId = results.getString("ArtistSpotifyId");
                String artistCountry = results.getString("ArtistCountry");
                String artistRecordLabel = results.getString("ArtistRecordLabel");

                Artists artist = new Artists(artistId, artistName, artistSpotifyId, artistCountry, artistRecordLabel);
                AlbumsDao albumsDao = AlbumsDao.getInstance();
                Albums album = albumsDao.getAlbumById(albumId);
                
                Songs song = new Songs(resultId, songName, artist, album);
                
                return song;
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

    public List<Songs> getSongsByName(String songName) throws SQLException {
        List<Songs> songs = new ArrayList<Songs>();
        Connection connection = null;
        PreparedStatement selectStmt = null;
        ResultSet results = null;
        try {
            connection = this.connectionManager.getConnection();
            selectStmt = connection.prepareStatement(GETBYSONGNAME);
            selectStmt.setString(1, songName);
            results = selectStmt.executeQuery();
            while (results.next()) {
                Integer resultId = results.getInt("SongId");
                String songname = results.getString("SongName");
                Integer artistId = results.getInt("ArtistId");
                Integer albumId = results.getInt("AlbumId");

                AlbumsDao albumsDao = AlbumsDao.getInstance();
                Albums album = albumsDao.getAlbumById(albumId);

                ArtistsDao artistsDao = ArtistsDao.getInstance();
                Artists artist = artistsDao.getArtistById(artistId);

                Songs song = new Songs(resultId, songname, artist, album);
                songs.add(song);
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
        return songs;
    }

    
    public List<Songs> getSongsByAlbumId(Integer albumId) throws SQLException {
        List<Songs> songs = new ArrayList<Songs>();
        Connection connection = null;
        PreparedStatement selectStmt = null;
        ResultSet results = null;
        try {
            connection = this.connectionManager.getConnection();
            selectStmt = connection.prepareStatement(GETBYALBUMID);
            selectStmt.setInt(1, albumId);
            results = selectStmt.executeQuery();
            while (results.next()) {
                Integer resultId = results.getInt("SongId");
                String songname = results.getString("SongName");
                Integer artistId = results.getInt("ArtistId");
                Integer _albumId = results.getInt("AlbumId");
                AlbumsDao albumsDao = AlbumsDao.getInstance();
                Albums album = albumsDao.getAlbumById(_albumId);

                ArtistsDao artistsDao = ArtistsDao.getInstance();
                Artists artist = artistsDao.getArtistById(artistId);

                Songs song = new Songs(resultId, songname, artist, album);
                songs.add(song);
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
        return songs;
    }
    
    public List<Songs> getSongsByArtistId(Integer artistId) throws SQLException {
        List<Songs> songs = new ArrayList<Songs>();
        Connection connection = null;
        PreparedStatement selectStmt = null;
        ResultSet results = null;
        try {
            connection = this.connectionManager.getConnection();
            
            selectStmt = connection.prepareStatement(GETBYARTISTID);
            selectStmt.setInt(1, artistId);
            results = selectStmt.executeQuery();
            while (results.next()) {
                Integer resultId = results.getInt("SongId");
                String songname = results.getString("SongName");
                Integer _artistId = results.getInt("ArtistId");
                Integer albumId = results.getInt("AlbumId");
                AlbumsDao albumsDao = AlbumsDao.getInstance();
                Albums album = albumsDao.getAlbumById(albumId);

                ArtistsDao artistsDao = ArtistsDao.getInstance();
                Artists artist = artistsDao.getArtistById(_artistId);

                Songs song = new Songs(resultId, songname, artist, album);
                songs.add(song);
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
        return songs;
    }
    
    public Songs updateSongName(Songs songs, String songName) throws SQLException {
        Connection connection = null;
        PreparedStatement insertStmt = null;
        try {
            connection = connectionManager.getConnection();
            insertStmt = connection.prepareStatement(UPDATE_SONGNAME);
            insertStmt.setString(1, songName);
            insertStmt.setInt(2, songs.getSongId());
            insertStmt.executeUpdate();
            songs.setSongName(songName);
            return songs;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (connection != null) {
                connection.close();
            }
            if (insertStmt != null) {
                insertStmt.close();
            }
        }
    }
  

    // Update methods not used at Front-end.
    // Also, not sure if a method for updating Foreign Key should
    // take in a new Id, or a new object.
    
//    public Songs updateAlbumId(Songs songs, Integer albumId) throws SQLException {
//        Connection connection = null;
//        PreparedStatement insertStmt = null;
//        try {
//            connection = connectionManager.getConnection();
//            insertStmt = connection.prepareStatement(UPDATE_ALBUMID);
//            insertStmt.setInt(1, albumId);
//            insertStmt.setInt(2, songs.getSongId());
//            insertStmt.executeUpdate();
//            
//            
//            songs.setAlbumId(albumId);
//            return songs;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw e;
//        } finally {
//            if (connection != null) {
//                connection.close();
//            }
//            if (insertStmt != null) {
//                insertStmt.close();
//            }
//        }
//    }
//
//    public Songs updateArtistId(Songs songs, Integer artistId) throws SQLException {
//        Connection connection = null;
//        PreparedStatement insertStmt = null;
//        try {
//            connection = connectionManager.getConnection();
//            insertStmt = connection.prepareStatement(UPDATE_ARTISTID);
//            insertStmt.setInt(1, artistId);
//            insertStmt.setInt(2, songs.getSongId());
//            insertStmt.executeUpdate();
//            songs.setArtistId(artistId);
//            return songs;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw e;
//        } finally {
//            if (connection != null) {
//                connection.close();
//            }
//            if (insertStmt != null) {
//                insertStmt.close();
//            }
//        }
//    }

    public Songs delete(Songs songs) throws SQLException {
        Connection connection = null;
        PreparedStatement deleteStmt = null;
        try {
            connection = connectionManager.getConnection();
            deleteStmt = connection.prepareStatement(DELETE);
            deleteStmt.setInt(1, songs.getSongId());
            deleteStmt.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (connection != null) {
                connection.close();
            }
            if (deleteStmt != null) {
            	deleteStmt.close();
            }
        }
    }
}
