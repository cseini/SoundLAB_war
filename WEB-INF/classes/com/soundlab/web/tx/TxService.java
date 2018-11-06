package com.soundlab.web.tx;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soundlab.web.dj.ArticleMapper;
import com.soundlab.web.foryou.ForYouMapper;

@Service
@Transactional
public class TxService {
	@Autowired ForYouMapper fm;
	@Autowired ArticleMapper am;
	public String putMusicUp(Map<String, String> p) {
		// 음악 좋아요 쿼리, 장르 좋아요 쿼리 트랜잭션
		String ms = p.get("mSeq"), res = "";
		res += (fm.putMusicUp(ms))?"m up":"";
		res += (fm.putGenreUp(p.get("gSeq")))?"/g up":"";
		res += (fm.delDown(ms))?"/m down del":"";
		return res;
	}
	public String delMusicUp(Map<String, String> p) {
		String res = "";
		res += (fm.delUp(p.get("mSeq")))?"m up del":"";
		res += (fm.delGenreUp(p.get("gSeq")))?"/g up del":"";
		return res;
	}
	public String putMusicDown(Map<String, String> p) {
		String ms = p.get("mSeq"), res = "";
		res += (fm.putMusicDown(ms))?"m down":"";
		res += (fm.delUp(ms))?"/m up del":"";
		res += (fm.delGenreUp(p.get("gSeq")))?"/g up del":"";
		return res;
	}
	public String putArtistUp(String p) {
		String res = "";
		res += (fm.putArtistUp(p))?"a up":"";
		res += (fm.delDown(p))?"/a down del":"";
		return res;
	}
	public String putArtistDown(String p) {
		String res = "";
		res += (fm.putArtistDown(p))?"a down":"";
		res += (fm.delUp(p))?"a up del":"";
		return res;
	}
}
