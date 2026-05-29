package Serverlet;



import com.nhacso.dao.SongDAO;
import com.nhacso.dto.SongDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;

@WebServlet(name = "PlayerServlet", urlPatterns = {"/player"})
public class PlayerServlet extends HttpServlet {

    private static final int BUFFER_SIZE = 16 * 1024;
    private final SongDAO songDAO = new SongDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        int songId;

        try {
            songId = Integer.parseInt(idParam);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bài hát không hợp lệ");
            return;
        }

        SongDTO song = songDAO.findById(songId);
        if (song == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài hát");
            return;
        }

        File audioFile = resolveAudioFile(song.getFileUrl(), request);
        if (audioFile == null || !audioFile.exists() || !audioFile.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy file nhạc");
            return;
        }

        long fileLength = audioFile.length();
        String range = request.getHeader("Range");

        response.setHeader("Accept-Ranges", "bytes");
        response.setContentType("audio/mpeg");

        if (range == null || range.isBlank()) {
            maybeIncreaseListen(request.getSession(), songId);
            response.setContentLengthLong(fileLength);

            try (BufferedInputStream input = new BufferedInputStream(new FileInputStream(audioFile));
                 BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream())) {
                copy(input, output);
            }
            return;
        }

        long start = 0;
        long end = fileLength - 1;

        try {
            String[] parts = range.replace("bytes=", "").split("-");
            if (!parts[0].isBlank()) {
                start = Long.parseLong(parts[0]);
            }
            if (parts.length > 1 && !parts[1].isBlank()) {
                end = Long.parseLong(parts[1]);
            }
        } catch (Exception e) {
            response.setHeader("Content-Range", "bytes */" + fileLength);
            response.sendError(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
            return;
        }

        if (start > end || start < 0 || end >= fileLength) {
            response.setHeader("Content-Range", "bytes */" + fileLength);
            response.sendError(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
            return;
        }

        long contentLength = end - start + 1;
        if (start == 0) {
            maybeIncreaseListen(request.getSession(), songId);
        }

        response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
        response.setHeader("Content-Range", "bytes " + start + "-" + end + "/" + fileLength);
        response.setContentLengthLong(contentLength);

        try (RandomAccessFile input = new RandomAccessFile(audioFile, "r");
             OutputStream output = response.getOutputStream()) {

            input.seek(start);

            byte[] buffer = new byte[BUFFER_SIZE];
            long remaining = contentLength;
            int read;

            while (remaining > 0 &&
                    (read = input.read(buffer, 0, (int) Math.min(buffer.length, remaining))) != -1) {
                output.write(buffer, 0, read);
                remaining -= read;
            }
        }
    }

    private void maybeIncreaseListen(HttpSession session, int songId) {
        String key = "played_song_" + songId;
        if (session.getAttribute(key) == null) {
            songDAO.increaseListenCount(songId);
            session.setAttribute(key, Boolean.TRUE);
        }
    }

    private File resolveAudioFile(String fileUrl, HttpServletRequest request) {
        if (fileUrl == null || fileUrl.isBlank()) {
            return null;
        }

        File file = new File(fileUrl);
        if (file.isAbsolute()) {
            return file;
        }

        String rootPath = request.getServletContext().getRealPath("/");
        if (rootPath == null) {
            return null;
        }

        return new File(rootPath, fileUrl.replace("/", File.separator));
    }

    private void copy(InputStream input, OutputStream output) throws IOException {
        byte[] buffer = new byte[BUFFER_SIZE];
        int bytesRead;
        while ((bytesRead = input.read(buffer)) != -1) {
            output.write(buffer, 0, bytesRead);
        }
    }
}
