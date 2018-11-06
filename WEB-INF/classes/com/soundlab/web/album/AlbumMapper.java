package com.soundlab.web.album;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.soundlab.web.bean.album;
import com.soundlab.web.bean.comment;

public interface AlbumMapper {
	public List<Map<?,?>>  newAl_like ();
	public List<Map<?,?>>  newAl_recent ();
	public  void al_comment (comment comment);
	public List<Map<?,?>> viewComment();
	public List<Map<?, ?>> carousel(HashMap<?,?> map);
	public List<Map<?,?>>  getMusSeq(HashMap<?,?> map);
}
