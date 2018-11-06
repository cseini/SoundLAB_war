package com.soundlab.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.soundlab.web.bean.*;
import com.soundlab.web.service.ServiceCtrl;



@RestController
@RequestMapping("/service")
public class ServiceCtrl {
	static final Logger logger = LoggerFactory.getLogger(ServiceCtrl.class);
	@Autowired Map<String, Object> map;
	@Autowired ServiceMapper sm;
	@Autowired artist at;
	
	@SuppressWarnings("unchecked")
	@GetMapping("/search/{artist}/{id}")
	public @ResponseBody Map<String,Object> search(@PathVariable String artist,@PathVariable String id){
		logger.info("ServiceCtrl ::: search");
		System.out.println("cookieID :: "+id);
		map.clear();
		if(!id.equals("undefined")) {
			map.put("id", id);
		}
		map.put("artist", artist);
		HashMap<String, Object> am = (HashMap<String, Object>) sm.getArtist(map);
		map.put("artist", am);
		String artistSeq = am.get("ARTIST_SEQ").toString();
		
		map.put("artistSeq", artistSeq);
		map.put("musics", sm.getMusicList(map));
		System.out.println("musics:::"+map.get("musics"));
		
		
		map.put("album", sm.getAlbumList(artistSeq));
		map.put("mv", sm.getMvList(artistSeq));
		
		System.out.println("artist::"+am);
		System.out.println("musics:::"+map.get("musics"));
		System.out.println("album:::"+map.get("album"));
		System.out.println("mv:::"+map.get("mv"));
		

		return map;
	}

	
	@GetMapping("/player/music/{musicSeq}/{memberId}")
	public Map<String,Object> playerMusic(@PathVariable String musicSeq
			,@PathVariable String memberId){
		logger.info("ServiceCtrl ::: MusicPlayer");
		System.out.println("넘어온 musicSeq::"+musicSeq);
		map.clear();
		map.put("musicSeq", musicSeq);
		String[] ms = musicSeq.split(",");
		List<Map<String,Object>> res = new ArrayList<>();
		for(int i=0;i<ms.length;i++) {
			for(Map<String,Object> m : sm.getPlayer(map)) {
				if(ms[i].equals(m.get("MUSIC_SEQ").toString())) {
					System.out.println("music seq :: "+m.get("MUSIC_SEQ")+" :: 받아온 ms "+i+" 번째 :: "+ms[i]);
					res.add(m);
					break;
				}
			}
		}
		System.out.println(res);
		map.put("musics", res);
		map.put("musicList", ms);
		map.put("memberId", memberId);
		sm.musicRecord(map);
		return map;
	}
	@SuppressWarnings("unchecked")
	@GetMapping("/player/album/{albumSeq}/{memberId}")
	public Map<String,Object> playerAlbum(@PathVariable String albumSeq,
			@PathVariable String memberId){
		logger.info("ServiceCtrl ::: AlbumPlayer");
		System.out.println("넘어온  albumSeq::"+albumSeq);
		map.clear();
		map.put("albumSeq",albumSeq);
		map.put("albums", sm.getPlayer(map));
		System.out.println("album플레이어::"+map.get("albumSeq"));
		System.out.println("앨범스::"+map.get("albums"));
		
		List<Map<String,Object>> albums = (List<Map<String, Object>>) map.get("albums");
		int len = albums.size();
		String[] ms = new String[len];
		System.out.println("albums.size :: "+len);
		for(int i=0;i<len;i++) {
			ms[i]= String.valueOf(albums.get(i).get("MUSIC_SEQ"));
		}
		System.out.println("albumplayer .. ms :: "+ ms[0]);
		map.put("musicList", ms);
		map.put("memberId", memberId);
		sm.musicRecord(map);
		return map;
	}
}
