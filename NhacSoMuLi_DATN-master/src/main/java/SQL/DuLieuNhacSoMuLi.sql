USE NhacSoMuli;
GO

-- ==========================================
-- 1. CHÈN DỮ LIỆU MẪU CHO BẢNG [USER] (20 người: 5 Admin, 15 Users)
-- ==========================================
INSERT INTO [USER] (username, [password], email, full_name, role, status) VALUES
('admin1', 'hashed_pass_1', 'admin.muli1@nhacso.vn', N'Nguyễn Hoàng Long', 'ADMIN', 1),
('admin2', 'hashed_pass_2', 'admin.muli2@nhacso.vn', N'Trần Thị Thanh Tuyền', 'ADMIN', 1),
('admin3', 'hashed_pass_3', 'admin.muli3@nhacso.vn', N'Lê Minh Khôi', 'ADMIN', 1),
('admin4', 'hashed_pass_4', 'admin.muli4@nhacso.vn', N'Phạm Bảo Nam', 'ADMIN', 1),
('admin5', 'hashed_pass_5', 'admin.muli5@nhacso.vn', N'Vũ Hoàng Yến', 'ADMIN', 1),
('user01', 'user_pass_1', 'tung.nguyen@gmail.com', N'Nguyễn Thanh Tùng', 'USER', 1),
('user02', 'user_pass_2', 'hoa.vu@gmail.com', N'Vũ Thị Hoa', 'USER', 1),
('user03', 'user_pass_3', 'dung.le@gmail.com', N'Lê Văn Dũng', 'USER', 1),
('user04', 'user_pass_4', 'linh.hoang@gmail.com', N'Hoàng Thùy Linh', 'USER', 1),
('user05', 'user_pass_5', 'khanh.pham@gmail.com', N'Phạm Nam Khánh', 'USER', 1),
('user06', 'user_pass_6', 'vy.tran@gmail.com', N'Trần Thảo Vy', 'USER', 1),
('user07', 'user_pass_7', 'minh.nguyen@gmail.com', N'Nguyễn Quang Minh', 'USER', 1),
('user08', 'user_pass_8', 'ha.pham@gmail.com', N'Phạm Thu Hà', 'USER', 1),
('user09', 'user_pass_9', 'quan.do@gmail.com', N'Đỗ Anh Quân', 'USER', 1),
('user10', 'user_pass_10', 'trang.le@gmail.com', N'Lê Thu Trang', 'USER', 1),
('user11', 'user_pass_11', 'phuc.hoang@gmail.com', N'Hoàng Hồng Phúc', 'USER', 1),
('user12', 'user_pass_12', 'anh.nguyen@gmail.com', N'Nguyễn Đức Anh', 'USER', 1),
('user13', 'user_pass_13', 'mai.tuyet@gmail.com', N'Tuyết Mai', 'USER', 1),
('user14', 'user_pass_14', 'son.lam@gmail.com', N'Lâm Thanh Sơn', 'USER', 0), -- User bị khóa tài khoản
('user15', 'user_pass_15', 'huyen.dang@gmail.com', N'Đặng Thanh Huyền', 'USER', 1);
GO

-- ==========================================
-- 2. CHÈN DỮ LIỆU MẪU CHO BẢNG ARTIST (10 Nghệ sĩ)
-- ==========================================
INSERT INTO ARTIST (name, bio, country) VALUES
(N'Sơn Tùng M-TP', N'Ca sĩ, nhạc sĩ nhạc Pop hàng đầu Việt Nam.', N'Việt Nam'),
(N'Đen Vâu', N'Rapper mang phong cách mộc mạc, triết lý.', N'Việt Nam'),
(N'Mỹ Tâm', N'Họa mi tóc nâu, diva nhạc Pop nổi tiếng.', N'Việt Nam'),
(N'Vũ.', N'Hoàng tử Indie Việt Nam với chất giọng trầm ấm.', N'Việt Nam'),
(N'Hoàng Thùy Linh', N'Nổi tiếng với dòng nhạc Pop kết hợp văn hóa dân gian.', N'Việt Nam'),
(N'Charlie Puth', N'Ca sĩ, nhạc sĩ, nhà sản xuất âm nhạc quốc tế.', N'Mỹ'),
(N'Taylor Swift', N'Siêu sao nhạc Pop và nhạc đồng quê thế giới.', N'Mỹ'),
(N'GREY D', N'Hoàng tử mới của dòng nhạc RnB/Lo-fi Việt.', N'Việt Nam'),
(N'tlinh', N'Nữ rapper, ca sĩ GenZ đầy cá tính.', N'Việt Nam'),
(N'SOOBIN', N'Nam ca sĩ đa tài thuộc tổ đội SpaceSpeakers.', N'Việt Nam');
GO

-- ==========================================
-- 3. CHÈN DỮ LIỆU MẪU CHO BẢNG ALBUM (7 Album)
-- ==========================================
-- Lưu ý: id tự tăng nên: Sơn Tùng = 1, Đen Vâu = 2, Mỹ Tâm = 3, Vũ = 4, Hoàng Thùy Linh = 5, Taylor Swift = 7
INSERT INTO ALBUM (title, release_date, cover_image, artist_id) VALUES
(N'Chúng Ta', '2020-12-20', 'images/albums/chung_ta.jpg', 1),
(N'Dongvau (Show của Đen)', '2019-11-01', 'images/albums/show_cua_den.jpg', 2),
(N'Tâm 9', '2017-12-03', 'images/albums/tam_9.jpg', 3),
(N'Một Vạn Năm', '2022-09-08', 'images/albums/mot_van_nam.jpg', 4),
(N'Hoàng', '2019-10-20', 'images/albums/hoang.jpg', 5),
(N'Link', '2022-08-11', 'images/albums/link.jpg', 5),
(N'Midnights', '2022-10-21', 'images/albums/midnights.jpg', 7);
GO

-- ==========================================
-- 4. CHÈN DỮ LIỆU MẪU CHO BẢNG GENRE (8 Thể loại)
-- ==========================================
INSERT INTO GENRE (genre_name) VALUES
(N'Pop'),
(N'Rap / Hip Hop'),
(N'Indie / Underground'),
(N'R&B'),
(N'Ballad'),
(N'Dance / Electronic'),
(N'Folk Pop (Dân gian đương đại)'),
(N'Lo-Fi');
GO

-- ==========================================
-- 5. CHÈN DỮ LIỆU MẪU CHO BẢNG SONG (16 Bài hát)
-- ==========================================
-- Thời lượng (duration) tính bằng giây. Album_id map tương ứng với bảng ALBUM trên.
INSERT INTO SONG (title, duration, file_url, cover_image, album_id, listens_count) VALUES
(N'Chúng Ta Của Hiện Tại', 301, 'music/chung_ta_cua_hien_tai.mp3', 'images/songs/chung_ta_cua_hien_tai.jpg', 1, 1500000),
(N'Chúng Ta Của Tương Lai', 245, 'music/chung_ta_cua_tuong_lai.mp3', 'images/songs/chung_ta_cua_tuong_lai.jpg', NULL, 980000), -- Bài đơn lẻ, không thuộc album
(N'Lối Nhỏ', 268, 'music/loi_nho.mp3', 'images/songs/loi_nho.jpg', 2, 2300000),
(N'Trốn Tìm', 245, 'music/tron_tim.mp3', 'images/songs/tron_tim.jpg', NULL, 3100000),
(N'Người Hãy Quên Em Đi', 215, 'music/nguoi_hay_quen_em_di.mp3', 'images/songs/nguoi_hay_quen_em_di.jpg', 3, 5000000),
(N'Muộn Màng Là Từ Lúc', 270, 'music/muon_mang_la_tu_luc.mp3', 'images/songs/muon_mang_la_tu_luc.jpg', 3, 1200000),
(N'Bước Qua Nhau', 257, 'music/buoc_qua_nhau.mp3', 'images/songs/buoc_qua_nhau.jpg', 4, 1800000),
(N'Bước Qua Mùa Cô Đơn', 282, 'music/buoc_qua_mua_co_don.mp3', 'images/songs/buoc_qua_mua_co_don.jpg', 4, 2500000),
(N'Để Mị Nói Cho Mà Nghe', 182, 'music/de_mi_noi_cho_ma_nghe.mp3', 'images/songs/de_mi_noi_cho_ma_nghe.jpg', 5, 4200000),
(N'Duyên Âm', 200, 'music/duyen_am.mp3', 'images/songs/duyen_am.jpg', 5, 3500000),
(N'See Tình', 185, 'music/see_tinh.mp3', 'images/songs/see_tinh.jpg', 6, 8900000),
(N'Gieo Quẻ', 212, 'music/gieo_que.mp3', 'images/songs/gieo_que.jpg', 6, 1700000),
(N'Anti-Hero', 200, 'music/anti_hero.mp3', 'images/songs/anti_hero.jpg', 7, 9500000),
(N'Đưa Em Về Nhà', 221, 'music/dua_em_ve_nha.mp3', 'images/songs/dua_em_ve_nha.jpg', NULL, 1100000),
(N'Nếu Lúc Đó', 234, 'music/neu_luc_do.mp3', 'images/songs/neu_luc_do.jpg', NULL, 2800000),
(N'Giá Như', 240, 'music/gia_nhu.mp3', 'images/songs/gia_nhu.jpg', NULL, 600000);
GO

-- ==========================================
-- 6. CHÈN DỮ LIỆU MẪU CHO BẢNG PLAYLIST (6 Playlist)
-- ==========================================
-- Gán cho các user_id ngẫu nhiên (Ví dụ user01 = id 6, user02 = id 7...)
INSERT INTO PLAYLIST (name, description, user_id) VALUES
(N'Nhạc Chill Cuối Tuần', N'Danh sách phát giúp bạn thư giãn sau tuần làm việc mệt mỏi.', 6),
(N'Lofi Gây Nghiện', N'Học tập và làm việc cực kỳ tập trung.', 6),
(N'V-Pop Hits Đỉnh Nhất', N'Tổng hợp nhạc Việt đang thịnh hành.', 7),
(N'Tâm Trạng Buồn', N'Những giai điệu chạm vào cảm xúc.', 8),
(N'Nhạc Âu Mỹ Bất Hủ', N'Đổi gió với US-UK chất lượng cao.', 9),
(N'Nhạc Của Tôi', N'Playlist cá nhân riêng tư.', 10);
GO

-- =======================================================
-- 7. CHÈN DỮ LIỆU MẪU CHO BẢNG TRUNG GIAN SONG_ARTIST (Many-To-Many)
-- =======================================================
-- Ánh xạ Bài hát - Nghệ sĩ (Giải quyết vụ 1 bài hát có nghệ sĩ Ft. nhau)
INSERT INTO SONG_ARTIST (song_id, artist_id) VALUES
(1, 1),   -- Chúng Ta Của Hiện Tại - Sơn Tùng
(2, 1),   -- Chúng Ta Của Tương Lai - Sơn Tùng
(3, 2),   -- Lối Nhỏ - Đen Vâu
(4, 2),   -- Trốn Tìm - Đen Vâu
(5, 3),   -- Người Hãy Quên Em Đi - Mỹ Tâm
(6, 3),   -- Muộn Màng Là Từ Lúc - Mỹ Tâm
(7, 4),   -- Bước Qua Nhau - Vũ
(8, 4),   -- Bước Qua Mùa Cô Đơn - Vũ
(9, 5),   -- Để Mị Nói Cho Mà Nghe - Hoàng Thùy Linh
(10, 5),  -- Duyên Âm - Hoàng Thùy Linh
(11, 5),  -- See Tình - Hoàng Thùy Linh
(12, 5),  -- Gieo Quẻ - Hoàng Thùy Linh (Bản gốc có cả Đen Vâu)
(12, 2),  -- Gieo Quẻ - Đen Vâu (Mối quan hệ Nhiều-Nhiều thể hiện ở đây)
(13, 7),  -- Anti-Hero - Taylor Swift
(14, 8),  -- Đưa Em Về Nhà - GREY D
(15, 9),  -- Nếu Lúc Đó - tlinh
(16, 10); -- Giá Như - SOOBIN
GO

-- =======================================================
-- 8. CHÈN DỮ LIỆU MẪU CHO BẢNG TRUNG GIAN SONG_GENRE (Many-To-Many)
-- =======================================================
-- Ánh xạ Bài hát - Thể loại (1 bài hát có thể vừa là Pop vừa là Ballad...)
INSERT INTO SONG_GENRE (song_id, genre_id) VALUES
(1, 1), (1, 5), -- Chúng Ta Của Hiện Tại: Pop + Ballad
(2, 1),         -- Chúng Ta Của Tương Lai: Pop
(3, 2), (3, 3), -- Lối Nhỏ: Rap + Indie
(4, 2), (4, 3), -- Trốn Tìm: Rap + Indie
(5, 1), (5, 4), -- Người Hãy Quên Em Đi: Pop + R&B
(6, 5),         -- Muộn Màng Là Từ Lúc: Ballad
(7, 3), (7, 5), -- Bước Qua Nhau: Indie + Ballad
(8, 3), (8, 5), -- Bước Qua Mùa Cô Đơn: Indie + Ballad
(9, 1), (9, 7), -- Để Mị Nói Cho Mà Nghe: Pop + Dân gian
(10, 1), (10, 7),-- Duyên Âm: Pop + Dân gian
(11, 1), (11, 6),-- See Tình: Pop + Dance
(12, 1), (12, 7),-- Gieo Quẻ: Pop + Dân gian
(13, 1),        -- Anti-Hero: Pop
(14, 4), (14, 8),-- Đưa Em Về Nhà: R&B + Lo-Fi
(15, 2), (15, 4),-- Nếu Lúc Đó: Rap + R&B
(16, 4), (16, 5);-- Giá Như: R&B + Ballad
GO

-- =======================================================
-- 9. CHÈN DỮ LIỆU MẪU CHO BẢNG TRUNG GIAN PLAYLIST_SONG (Many-To-Many)
-- =======================================================
-- Phân phối các bài hát vào các danh sách phát cá nhân
INSERT INTO PLAYLIST_SONG (playlist_id, song_id) VALUES
(1, 3),  -- Playlist 1 có bài Lối Nhỏ
(1, 7),  -- Playlist 1 có bài Bước Qua Nhau
(1, 14), -- Playlist 1 có bài Đưa Em Về Nhà
(2, 14), -- Playlist 2 có bài Đưa Em Về Nhà (Trùng bài nhưng khác playlist - Chuẩn logic)
(2, 8),  -- Playlist 2 có bài Bước Qua Mùa Cô Đơn
(3, 1),  -- Playlist 3 có bài Chúng Ta Của Hiện Tại
(3, 2),  -- Playlist 3 có bài Chúng Ta Của Tương Lai
(3, 11), -- Playlist 3 có bài See Tình
(4, 6),  -- Playlist 4 có bài Muộn Màng Là Từ Lúc
(4, 7),  -- Playlist 4 có bài Bước Qua Nhau
(4, 15), -- Playlist 4 có bài Nếu Lúc Đó
(4, 16), -- Playlist 4 có bài Giá Như
(5, 13); -- Playlist 5 có bài Anti-Hero
GO

SELECT s.title AS [Tên Bài Hát], a.name AS [Nghệ Sĩ], g.genre_name AS [Thể Loại]
FROM SONG s
JOIN SONG_ARTIST sa ON s.song_id = sa.song_id
JOIN ARTIST a ON sa.artist_id = a.artist_id
JOIN SONG_GENRE sg ON s.song_id = sg.song_id
JOIN GENRE g ON sg.genre_id = g.genre_id;