package com.soundlab.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.soundlab.web.bean.*;

@Repository
public interface ServiceMapper {
	public Map<?,?> getArtist(Map<?,?> map);
	public List<?> getMusicList(Map<?,?> map);
	public List<?> getAlbumList(String album);
	public List<?> getMvList(String mv);
	public List<Map<String,Object>> getPlayer(Map<?, ?> map);
	public void musicRecord(Map<?, ?> map);
}
