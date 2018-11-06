package com.soundlab.web.dj;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository
public interface ArticleMapper {
	public List<Object> get(Map<String, Object> p);
	public List<Object> getDetail(Map<String, Object> p);
	public boolean putHashView(Map<String, Object> p);
	
}
