package com.soundlab.web.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface AdminMapper {
	//방문자
	public int cntNew();
	public Map<?,?> countStrm();
	public List<?> cntVisiter();

	//선호도
	public List<?> ageGenre();
	public List<?> ageArtist();
	public List<?> sexGenre();
	public List<?> sexArtist();	
	public List<?> listTotalSong(Map<?, ?> p);
	
	//아티스트
	public List<?> artistStats(String artistName);
	public Map<?,?> getPerSex(String artistName);
	public List<?> getCntAge(String artistName);
	public List<?> listTopSong(Map<?,?> p);
	
	//해시태그
	public List<?> getHash();
}