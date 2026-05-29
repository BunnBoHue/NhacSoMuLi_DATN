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

@WebServlet(name = "SongServlet", urlPatterns = {"/", "/home", "/songs"})
public class SongServlet extends HttpServlet {

    private final SongDAO songDAO = new SongDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<SongDTO> songList = songDAO.findLatestSongs(12);
        List<SongDTO> topSongs = songDAO.findTopSongs(10);

        request.setAttribute("songList", songList);
        request.setAttribute("topSongs", topSongs);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
