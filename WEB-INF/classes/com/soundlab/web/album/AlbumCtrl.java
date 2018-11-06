package com.soundlab.web.album;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.soundlab.web.bean.album;
import com.soundlab.web.bean.comment;
import com.soundlab.web.bean.music;
import com.soundlab.web.cmm.Util;

@RestController
@RequestMapping("/album")
public class AlbumCtrl {
	static final Logger logger = LoggerFactory.getLogger(AlbumCtrl.class);
	@Autowired AlbumMapper alMapper;
	@Autowired HashMap<String, Object> map;
	@GetMapping("/newAl/{x}")
	public List<Map<?,?>> newAl_recent(@PathVariable String x){
		List<Map<?,?>> newAl = null;
		  if(x.equals("newAl_recent")) {
				 newAl=alMapper.newAl_recent();
		  }else {
			  newAl=alMapper.newAl_like();
		  }
		
		return newAl;
	}
	@PostMapping("/alComment")
	public void alCommentAdd(@RequestBody comment comment){
		alMapper.al_comment(comment);
	}
	@GetMapping("/viewComment")
	public List<Map<?,?>> viewComment(){
		List<Map<?,?>> viewComment = null;		
		viewComment= alMapper.viewComment();
		return viewComment;
	}
	@GetMapping("/carousel")
	public List<Map<?,?>> carousel(){
		List<Map<?,?>> carousel = null;
		Calendar cal = Calendar.getInstance();

        cal.add(Calendar.DATE, +1);
        String date1 = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
        map.put("date1", date1);
        cal.add(Calendar.DATE, -2);
        String date2 = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
        map.put("date2", date2);		
		carousel= alMapper.carousel(map);
		return carousel;
	}
	@GetMapping("/getMusSeq/{x}")
	public List<Map<?,?>> getMusSeq(@PathVariable int x){
		  Util.log.accept("getMusSeq:: " +x);
		  List<Map<?,?>> musSeq = null;
		  map.put("alSeq", x);
		  musSeq = alMapper.getMusSeq(map);
		 Util.log.accept("musSeqList:: " +musSeq);
		
		return musSeq;
	}
	
}
