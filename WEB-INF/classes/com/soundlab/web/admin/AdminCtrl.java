package com.soundlab.web.admin;

import java.util.List;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin")
public class AdminCtrl {
	static final Logger logger = LoggerFactory.getLogger(AdminCtrl.class);
	@Autowired Map<String, Object> m;
	@Autowired AdminMapper mpr;
	
	@GetMapping("/visit")
	public Map<String,Object> getVisitInfo() {
		logger.info("visit 페이지 진입");
		m.clear();
		m.put("st", mpr.countStrm());
		m.put("nu", mpr.cntNew());
		m.put("vcha", mpr.cntVisiter());
		logger.info("nu에 담긴 값 :"+m.get("nu"));
		logger.info("st에 담긴 값 :"+m.get("st"));
		logger.info("vcha에 담긴 값 :"+m.get("vcha"));
		return m;
	}
	
	@GetMapping("/pref")
	public Map<String,Object> getPref(){
		logger.info("선호도 페이지");
		m.clear();
		m.put("AG",mpr.ageGenre());
		m.put("AA", mpr.ageArtist());
		m.put("SG", mpr.sexGenre());
		m.put("SA", mpr.sexArtist());
		
		m.put("order", "sum_good");
		m.put("goodlist", mpr.listTotalSong(m));
		m.put("order", "sum_bad");
		m.put("badlist", mpr.listTotalSong(m));
		logger.info("AG에 담긴 값"+m.get("AG"));
		logger.info("AA에 담긴 값 ::"+m.get("AA"));
		logger.info("SG에 담긴 값: "+m.get("SG"));
		logger.info("SA에 담긴 값: "+m.get("SA"));
		return m;
	}

	@GetMapping("/artist/{artistName}")
	public Map<String, Object> retrieveArtist(@PathVariable String artistName){
		logger.info("아티스트 페이지");
		logger.info("아티스트 이름 :: "+artistName);
		m.clear();
		m.put("GS", mpr.artistStats(artistName));
		m.put("mf", mpr.getPerSex(artistName));
		m.put("artiAG", mpr.getCntAge(artistName));
		
		m.put("artistName", artistName);
		m.put("order", "sum_good");
		m.put("goodlist", mpr.listTopSong(m));
		m.put("order", "sum_bad");
		m.put("badlist", mpr.listTopSong(m));
		
		logger.info("GS에 담긴 값 : "+m.get("GS"));
		logger.info("mf에 담긴 값 : "+m.get("mf"));
		logger.info("artiAG에 담긴 값 : "+m.get("artiAG"));
		logger.info("goodlist에 담긴 값 : "+m.get("goodlist"));
		logger.info("badlist에 담긴 값 : "+m.get("badlist"));
		return m;
	}
	
	@GetMapping("/hash")
	public Map<String,Object> readHash(){
		logger.info("해시태그 진입 ");
		m.clear();
		m.put("hs", mpr.getHash());
		logger.info("해시 m : "+m.get("hs"));
		return m;
	}
}

