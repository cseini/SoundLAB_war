package com.soundlab.web.mbr;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.sf.json.JSONArray;



@RestController
@RequestMapping("/member")
public class MemberCtrl {
	static final Logger logger = LoggerFactory.getLogger(MemberCtrl.class);
	@Autowired Map<String,Object> rm;
	@Autowired MemberMapper mp;

	@PostMapping("/kakao")
	public Map<String,Object> kakao(@RequestBody Map<String,Object> pm) {
		logger.info("MemberController ::: kakao id {} pass {}",pm.get("KAKAO_ID"),pm.get("KAKAO_PASS"));
		rm.clear();
		rm.put("kId", pm.get("KAKAO_ID"));
		rm.put("kPass", pm.get("KAKAO_PASS"));
		if(mp.kakao(pm)!=0) {
			rm.put("memberId",mp.getKakao(pm));
			System.out.println("kakao id::"+mp.getKakao(pm));
			rm.put("valid", "Y");
		}else {
			rm.put("valid", "N");
		}
		
		
		return rm;
	}
	
	@GetMapping("/auth")
	public Map<String,Object> auth() {
		logger.info("MemberController ::: auth ");
		rm.clear();
		return rm;
	}
	
	@GetMapping("/{memberId}")
	public Map<String,Object> duple(@PathVariable String memberId) {
		logger.info("MemberController ::: duple ");
		rm.clear();
		String valid = "없는 아이디입니다.";
		rm.put("memberId", memberId);
		if(mp.count(rm) != 0) {
			valid = "아이디가 존재합니다.";
		}
		rm.put("valid", valid);
		return rm;
	}
	
	
	@PostMapping("/login")
	@Transactional
	public Map<String,Object> login(@RequestBody Map<String,Object> pm) {
		logger.info("MemberController ::: login ");
		rm.clear();
		logger.info("memberId {} pass {} ",pm.get("memberId"),pm.get("pass"));
		String valid = "아이디";
		rm.put("memberId", pm.get("memberId"));
		if(mp.count(rm) != 0) {
			valid="비밀번호";
			rm = mp.get(pm);
			if(rm != null) {
				valid = (rm.get("memberId").equals("admin"))?"admin":"user";
				mp.loginRecord(rm);
				System.out.println("kakao 있니?? "+ pm.containsKey("KAKAO_ID"));
				if(pm.containsKey("KAKAO_ID")) {
					mp.postKakao(pm);
				}
			}else {
				rm = new HashMap<>();
			}
		}
		
		rm.put("valid", valid);
		
		return rm;
	}
	
	@PostMapping("/member")
	@Transactional
	public Map<String,Object> join(@RequestBody Map<String,Object> pm) {
		logger.info("MemberController ::: join ");
		rm.clear();
		rm.put("memberId",pm.get("memberId"));
		pm.put("genres", JSONArray.fromObject(pm.get("genres")));
		pm.put("artists", JSONArray.fromObject(pm.get("artists")));
		logger.info("memberId {} pass {} ",pm.get("memberId"),pm.get("pass"));
		String valid = "이미 존재하는 아이디입니다.";
		logger.info("name {} nick {} ",pm.get("name"),pm.get("nick"));
		logger.info("ssn {} email {} ",pm.get("ssn"),pm.get("email"));
		logger.info("phone {} genres {} ",pm.get("phone"),pm.get("genres"));
		logger.info("artists {} sex {}",pm.get("artists"),pm.get("sex"));
		System.out.println("아이디 탐색 ::: "+mp.count(rm));
		if(mp.count(rm) == 0) {
			mp.post(pm);
			logger.info("MemberController ::: join :: post fin");
			mp.upGenre(pm);
			logger.info("MemberController ::: join :: upGenre fin");
			mp.upArtist(pm);
			logger.info("MemberController ::: join :: upArtist fin");
			valid = "회원가입성공";
		}
		
		rm.put("valid", valid);
		
		return rm;
	}
	
	//pass, email, phone
	@PutMapping("/member")
	public Map<String,Object> update(@RequestBody Map<String,Object> pm) {
		logger.info("MemberController ::: update ");
		rm.clear();
		logger.info("memberId {} pass {} ",pm.get("memberId"),pm.get("pass"));
		String valid = "회원정보가 변경되었습니다.";
		mp.update(pm);
		rm.put("valid", valid);
		
		return rm;
	}
	@DeleteMapping("/{memberId}")
	public Map<String,Object> delete(@PathVariable String memberId) {
		logger.info("MemberController ::: delete ");
		rm.clear();
		logger.info("memberId {}",memberId);
		String valid = "계정삭제";
		mp.delete(memberId);
		rm.put("valid", valid);
		
		return rm;
	}
}
