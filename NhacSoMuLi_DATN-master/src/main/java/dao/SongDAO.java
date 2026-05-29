package dao;


import com.nhacso.dto.SongDTO;
import com.nhacso.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SongDAO {

    public List<SongDTO> findLatestSongs(int limit) {
        List<SongDTO> songs = new ArrayList<>();
        String sql = """
                SELECT s.song_id,
                       s.title,
                       s.duration,
                       s.file_url,
                       s.cover_image,
                       s.listens_count,
                       a.album_id,
                       a.title AS album_title
                FROM SONG s
                LEFT JOIN ALBUM a ON s.album_id = a.album_id
                ORDER BY s.created_at DESC, s.song_id DESC
                OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SongDTO song = mapSong(rs);
                    loadArtists(conn, song);
                    loadGenres(conn, song);
                    songs.add(song);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy danh sách bài hát", e);
        }
        return songs;
    }

    public List<SongDTO> findTopSongs(int limit) {
        List<SongDTO> songs = new ArrayList<>();
        String sql = """
                SELECT s.song_id,
                       s.title,
                       s.duration,
                       s.file_url,
                       s.cover_image,
                       s.listens_count,
                       a.album_id,
                       a.title AS album_title
                FROM SONG s
                LEFT JOIN ALBUM a ON s.album_id = a.album_id
                ORDER BY ISNULL(s.listens_count, 0) DESC, s.song_id DESC
                OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SongDTO song = mapSong(rs);
                    loadArtists(conn, song);
                    loadGenres(conn, song);
                    songs.add(song);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy top bài hát", e);
        }
        return songs;
    }

    public SongDTO findById(int songId) {
        String sql = """
                SELECT s.song_id,
                       s.title,
                       s.duration,
                       s.file_url,
                       s.cover_image,
                       s.listens_count,
                       a.album_id,
                       a.title AS album_title
                FROM SONG s
                LEFT JOIN ALBUM a ON s.album_id = a.album_id
                WHERE s.song_id = ?
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, songId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SongDTO song = mapSong(rs);
                    loadArtists(conn, song);
                    loadGenres(conn, song);
                    return song;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy chi tiết bài hát", e);
        }
        return null;
    }

    public List<SongDTO> findRelatedSongs(int songId, int limit) {
        List<SongDTO> songs = new ArrayList<>();
        String sql = """
                SELECT s.song_id,
                       s.title,
                       s.duration,
                       s.file_url,
                       s.cover_image,
                       s.listens_count,
                       a.album_id,
                       a.title AS album_title
                FROM SONG s
                LEFT JOIN ALBUM a ON s.album_id = a.album_id
                WHERE s.song_id <> ?
                ORDER BY ISNULL(s.listens_count, 0) DESC, s.song_id DESC
                OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, songId);
            ps.setInt(2, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SongDTO song = mapSong(rs);
                    loadArtists(conn, song);
                    songs.add(song);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy danh sách liên quan", e);
        }
        return songs;
    }

    public void increaseListenCount(int songId) {
        String sql = "UPDATE SONG SET listens_count = ISNULL(listens_count, 0) + 1 WHERE song_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, songId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi cập nhật lượt nghe", e);
        }
    }

    private void loadArtists(Connection conn, SongDTO song) throws SQLException {
        String sql = """
                SELECT a.name
                FROM SONG_ARTIST sa
                INNER JOIN ARTIST a ON sa.artist_id = a.artist_id
                WHERE sa.song_id = ?
                ORDER BY a.name
                """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, song.getSongId());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    song.getArtists().add(rs.getString("name"));
                }
            }
        }
    }

    private void loadGenres(Connection conn, SongDTO song) throws SQLException {
        String sql = """
                SELECT g.genre_name
                FROM SONG_GENRE sg
                INNER JOIN GENRE g ON sg.genre_id = g.genre_id
                WHERE sg.song_id = ?
                ORDER BY g.genre_name
                """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, song.getSongId());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    song.getGenres().add(rs.getString("genre_name"));
                }
            }
        }
    }

    private SongDTO mapSong(ResultSet rs) throws SQLException {
        SongDTO song = new SongDTO();
        song.setSongId(rs.getInt("song_id"));
        song.setTitle(rs.getString("title"));
        song.setDuration((Integer) rs.getObject("duration"));
        song.setFileUrl(rs.getString("file_url"));
        song.setCoverImage(rs.getString("cover_image"));
        song.setListensCount((Integer) rs.getObject("listens_count"));
        song.setAlbumId((Integer) rs.getObject("album_id"));
        song.setAlbumTitle(rs.getString("album_title"));
        return song;
    }
}
