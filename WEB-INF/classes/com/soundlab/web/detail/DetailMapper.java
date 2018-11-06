package com.soundlab.web.detail;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.soundlab.web.bean.music;

@Repository
public interface DetailMapper {
	public Map<?,?> getAlbum(String albumSeq);
	public List<?> getAlbumMusic(Map<?,?> map);
	public Integer count(String albumSeq);
	public void create(Map<?,?> map);
	public Integer countMy(Map<?,?> map);
	public List<?> getMy(Map<?,?> map);

	
}
