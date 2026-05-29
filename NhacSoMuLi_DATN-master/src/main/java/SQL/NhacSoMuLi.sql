-- 1. Tạo Database
CREATE DATABASE NhacSoMuli;
GO
USE NhacSoMuli;
GO

-- 2. Bảng USER (Người dùng / Khách hàng)
CREATE TABLE [USER] (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    [password] VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name NVARCHAR(100),
    role VARCHAR(20) DEFAULT 'USER', -- ADMIN, USER
    status INT DEFAULT 1,            -- 1: Active, 0: Blocked
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- 3. Bảng ARTIST (Ca sĩ / Nghệ sĩ)
CREATE TABLE ARTIST (
    artist_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    bio NVARCHAR(MAX),
    country NVARCHAR(50)
);
GO

-- 4. Bảng ALBUM
CREATE TABLE ALBUM (
    album_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(150) NOT NULL,
    release_date DATE,
    cover_image NVARCHAR(500),
    artist_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Album_Artist FOREIGN KEY (artist_id) REFERENCES ARTIST(artist_id) ON DELETE SET NULL
);
GO

-- 5. Bảng GENRE (Thể loại nhạc)
CREATE TABLE GENRE (
    genre_id INT IDENTITY(1,1) PRIMARY KEY,
    genre_name NVARCHAR(100) NOT NULL UNIQUE
);
GO

-- 6. Bảng SONG (Bài hát)
CREATE TABLE SONG (
    song_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(150) NOT NULL,
    duration INT, -- Tính bằng giây (ví dụ: 240 giây = 4 phút)
    file_url NVARCHAR(500) NOT NULL, -- Đường dẫn file nhạc (.mp3)
    cover_image NVARCHAR(500),       -- Ảnh thu nhỏ bài hát
    album_id INT NULL,
    listens_count INT DEFAULT 0,     -- Lượt nghe
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Song_Album FOREIGN KEY (album_id) REFERENCES ALBUM(album_id) ON DELETE SET NULL
);
GO

-- 7. Bảng PLAYLIST (Danh sách phát cá nhân)
CREATE TABLE PLAYLIST (
    playlist_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(150) NOT NULL,
    description NVARCHAR(500),
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Playlist_User FOREIGN KEY (user_id) REFERENCES [USER](user_id) ON DELETE CASCADE
);
GO

-- =======================================================
-- CÁC BẢNG TRUNG GIAN GIẢI QUYẾT QUAN HỆ NHIỀU - NHIỀU (MANY-TO-MANY)
-- =======================================================

-- 8. Bảng trung gian SONG_ARTIST (Một bài hát có thể có nhiều ca sĩ kết hợp và ngược lại)
CREATE TABLE SONG_ARTIST (
    song_id INT NOT NULL,
    artist_id INT NOT NULL,
    CONSTRAINT PK_Song_Artist PRIMARY KEY (song_id, artist_id),
    CONSTRAINT FK_SongArtist_Song FOREIGN KEY (song_id) REFERENCES SONG(song_id) ON DELETE CASCADE,
    CONSTRAINT FK_SongArtist_Artist FOREIGN KEY (artist_id) REFERENCES ARTIST(artist_id) ON DELETE CASCADE
);
GO

-- 9. Bảng trung gian SONG_GENRE (Một bài hát có thể thuộc nhiều thể loại)
CREATE TABLE SONG_GENRE (
    song_id INT NOT NULL,
    genre_id INT NOT NULL,
    CONSTRAINT PK_Song_Genre PRIMARY KEY (song_id, genre_id),
    CONSTRAINT FK_SongGenre_Song FOREIGN KEY (song_id) REFERENCES SONG(song_id) ON DELETE CASCADE,
    CONSTRAINT FK_SongGenre_Genre FOREIGN KEY (genre_id) REFERENCES GENRE(genre_id) ON DELETE CASCADE
);
GO

-- 10. Bảng trung gian PLAYLIST_SONG (Quản lý các bài hát có trong một Playlist)
CREATE TABLE PLAYLIST_SONG (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Playlist_Song PRIMARY KEY (playlist_id, song_id),
    CONSTRAINT FK_PlaylistSong_Playlist FOREIGN KEY (playlist_id) REFERENCES PLAYLIST(playlist_id) ON DELETE CASCADE,
    CONSTRAINT FK_PlaylistSong_Song FOREIGN KEY (song_id) REFERENCES SONG(song_id) ON DELETE CASCADE
);
GO