package com.soundlab.web.mbr;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberMapper {
	public void post(Map<?,?> p);
	public void postKakao(Map<?,?> p);
	public void upGenre(Map<?,?> p);
	public void upArtist(Map<?,?> p);
	public Map<String,Object> get(Map<?,?> p);
	public String getKakao(Map<?,?> p);
	public int count(Map<?,?> p);
	public int kakao(Map<?,?> p);
	public void update(Map<?,?> p);
	public void delete(String p);
	public void loginRecord(Map<?,?> p);
}
