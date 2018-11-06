package com.soundlab.web.foryou;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.soundlab.web.tx.TxService;

@RestController
public class ForYouCtrl {
	@Autowired ForYouMapper fm;
	@Autowired TxService ts;
	@RequestMapping("/foryou/{id}")
	public @ResponseBody Map<String, Object> getForYou(@PathVariable String id){
		System.out.println("cookieID :: "+id);
		Map<String, Object> res = new HashMap<>();
		res.put("fy", fm.getForYou());
		System.out.println(res.get("fy"));
		return res;
	}
	@RequestMapping("/foryou/albums/{seq}")
	public @ResponseBody Map<String, Object> getAlbumDt(@PathVariable String seq){
		System.out.println("albumSeq :: "+seq);
		Map<String, Object> res = new HashMap<>();
		res.put("albumDt", fm.getAlbumDetail(seq));
		System.out.println(res.get("albumDt"));
		return res;
	}
	@RequestMapping("/foryou/putML/{mSeq}/{gSeq}")
	public @ResponseBody Map<String, Object> putMusicUp(@PathVariable String mSeq, @PathVariable String gSeq){
		Map<String, Object> res = new HashMap<>();
		Map<String, String> p = new HashMap<>();
		p.put("mSeq", mSeq);
		p.put("gSeq", gSeq);
		res.put("res", ts.putMusicUp(p));
		return res;
	}
	@RequestMapping("/foryou/delML/{mSeq}/{gSeq}")
	public @ResponseBody Map<String, Object> delMusicUp(@PathVariable String mSeq, @PathVariable String gSeq){
		Map<String, Object> res = new HashMap<>();
		Map<String, String> p = new HashMap<>();
		p.put("mSeq", mSeq);
		p.put("gSeq", gSeq);
		res.put("res", ts.delMusicUp(p));
		return res;
	}
	@RequestMapping("/foryou/putMH/{mSeq}")
	public @ResponseBody  Map<String, Object> putMusicDown(@PathVariable String mSeq){
		Map<String, Object> res = new HashMap<>();
		res.put("res", (fm.putMusicDown(mSeq))?"m down":"");
		return res;
	}
	@RequestMapping("/foryou/putMH/{mSeq}/{gSeq}")
	public @ResponseBody Map<String, Object> putMusicDown(@PathVariable String mSeq, @PathVariable String gSeq){
		Map<String, Object> res = new HashMap<>();
		Map<String, String> p = new HashMap<>();
		p.put("mSeq", mSeq);
		p.put("gSeq", gSeq);
		res.put("res", ts.putMusicDown(p));
		return res;
	}
	@RequestMapping("/foryou/delMH/{mSeq}")
	public @ResponseBody Map<String, Object> delMusicDown(@PathVariable String mSeq){
		Map<String, Object> res = new HashMap<>();
		res.put("res", (fm.delDown(mSeq))?"m down del":"");
		return res;
	}
	@RequestMapping("/foryou/putAL/{aSeq}")
	public @ResponseBody Map<String, Object> putArtistUp(@PathVariable String aSeq){
		Map<String, Object> res = new HashMap<>();
		res.put("res", ts.putArtistUp(aSeq));
		return res;
	}
	@RequestMapping("/foryou/delAL/{aSeq}")
	public @ResponseBody Map<String, Object> delArtistUp(@PathVariable String aSeq){
		Map<String, Object> res = new HashMap<>();
		res.put("res", (fm.delUp(aSeq))?"a up del":"");
		return res;
	}
	@RequestMapping("/foryou/putAH/{aSeq}")
	public @ResponseBody Map<String, Object> putArtistDown(@PathVariable String aSeq){
		Map<String, Object> res = new HashMap<>();
		res.put("res", ts.putArtistDown(aSeq));
		return res;
	}
	@RequestMapping("/foryou/delAH/{aSeq}")
	public @ResponseBody Map<String, Object> delArtistDown(@PathVariable String aSeq){
		Map<String, Object> res = new HashMap<>();
		res.put("res", (fm.delDown(aSeq))?"a down del":"");
		return res;
	}
	
}
