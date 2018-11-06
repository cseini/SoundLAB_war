package com.soundlab.web.foryou;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository
public interface ForYouMapper {
	public List<Object> getForYou();
	public List<Object> getAlbumDetail(String p);
	public boolean putMusicUp(String p);
	public boolean putMusicDown(String p);
	public boolean putGenreUp(String p);
	public boolean putArtistUp(String p);
	public boolean putArtistDown(String p);
	public boolean delDown(String p);
	public boolean delUp(String p);
	public boolean delGenreUp(String p);
}
