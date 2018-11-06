package com.soundlab.web.detail;

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

import com.soundlab.web.page.PageProxy;
import com.soundlab.web.page.Pagination;
import com.soundlab.web.service.ServiceCtrl;

@RestController
@RequestMapping("/detailPg")
public class DetailCtrl {
	static final Logger logger = LoggerFactory.getLogger(ServiceCtrl.class);
	@Autowired Map<String,Object> map;
	@Autowired DetailMapper dm;
	@Autowired Pagination page;
	
	
	
	@GetMapping("/detail/{albumSeq}/{id}")
	public Map<String,Object> detail(@PathVariable String albumSeq,@PathVariable String id){
		logger.info("DetailPgCtrl ::: detail");
		map.clear();
		System.out.println("cookieID :: "+id);
		if(!id.equals("undefined")) {
			map.put("id", id);
		}
		
		map.put("albumSeq", albumSeq);
		map.put("musics", dm.getAlbumMusic(map));
		
		map.put("album", dm.getAlbum(albumSeq));
		map.put("rowCount", dm.count(albumSeq));
		System.out.println("앨범정보::"+map.get("album"));
		System.out.println("musics::"+map.get("musics"));
		System.out.println("rowCount::"+map.get("rowCount"));
	
		return map;
	}
	@PostMapping("/write")
	public Map<String, Object> albumComment(@RequestBody Map<String,Object> am){
		logger.info("DetailPgCtrl ::: write");
		System.out.println(am);
		
		map.clear();
		map.put("memberId", am.get("memberId"));
		map.put("seqGroup", am.get("seqGroup"));
		map.put("msg", am.get("msg"));
		dm.create(map);
		
		return map;
		
	}
	
	@GetMapping("/list/{seqGroup}/{pageNo}")
	public Map<String,Object> albumlist(@PathVariable String seqGroup, @PathVariable String pageNo) {
		logger.info("DetailPgCtrl ::: list");
		map.clear();
		
		System.out.println("seqGroup::"+seqGroup);
		System.out.println("pageNo::"+pageNo);
		map.put("pageNumber", pageNo);
		map.put("seqGroup", seqGroup);
		map.put("rowCount", dm.countMy(map));
		
		PageProxy pxy = new PageProxy();
		pxy.carryOut(map);
		page = pxy.getPagination();
		map.clear();
		System.out.println("map클리어 후 seqGroup::"+seqGroup);
		map.put("seqGroup", seqGroup);
		map.put("beginRow", page.getBeginRow());
		map.put("endRow", page.getEndRow());
		map.put("list", dm.getMy(map));
		map.put("page", page);
		
		System.out.println("seqGroup::"+map.get("seqGroup"));
		System.out.println("beginRow::"+map.get("beginRow"));
		System.out.println("endRow::"+map.get("endRow"));
		System.out.println("list::"+map.get("list"));
		System.out.println("page::"+map.get("page"));
	
		return map;
		
	}



}
