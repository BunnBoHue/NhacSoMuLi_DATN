package entity;


import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class SongDTO {
    private Integer songId;
    private String title;
    private Integer duration;
    private String fileUrl;
    private String coverImage;
    private Integer listensCount;
    private Integer albumId;
    private String albumTitle;
    private final List<String> artists = new ArrayList<>();
    private final List<String> genres = new ArrayList<>();

    public Integer getSongId() {
        return songId;
    }

    public void setSongId(Integer songId) {
        this.songId = songId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public Integer getListensCount() {
        return listensCount;
    }

    public void setListensCount(Integer listensCount) {
        this.listensCount = listensCount;
    }

    public Integer getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Integer albumId) {
        this.albumId = albumId;
    }

    public String getAlbumTitle() {
        return albumTitle;
    }

    public void setAlbumTitle(String albumTitle) {
        this.albumTitle = albumTitle;
    }

    public List<String> getArtists() {
        return artists;
    }

    public List<String> getGenres() {
        return genres;
    }

    public String getArtistsText() {
        return artists.stream().collect(Collectors.joining(", "));
    }

    public String getGenresText() {
        return genres.stream().collect(Collectors.joining(", "));
    }

    public String getDurationText() {
        if (duration == null || duration <= 0) {
            return "00:00";
        }
        int minutes = duration / 60;
        int seconds = duration % 60;
        return String.format("%02d:%02d", minutes, seconds);
    }
}
