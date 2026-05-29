package Serverlet;


import com.nhacso.dao.SongDAO;
import com.nhacso.dto.SongDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SongDetailServlet", urlPatterns = {"/song-detail"})
public class SongDetailServlet extends HttpServlet {

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

        List<SongDTO> relatedSongs = songDAO.findRelatedSongs(songId, 8);

        request.setAttribute("song", song);
        request.setAttribute("relatedSongs", relatedSongs);

        request.getRequestDispatcher("/WEB-INF/views/song-detail.jsp").forward(request, response);
    }
}
