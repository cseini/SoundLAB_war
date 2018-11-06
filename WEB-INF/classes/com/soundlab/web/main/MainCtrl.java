package com.soundlab.web.main;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import com.soundlab.web.cmm.Util;




@RestController
@RequestMapping("/main")
public class MainCtrl {
	static final Logger logger = LoggerFactory.getLogger(MainCtrl.class);
	@Autowired Map<String,Object> rm;
	@Autowired MainMapper mp;
	
	@GetMapping("/mainContents/{memberId}")
	public Map<String,Object> mainContents(@PathVariable String memberId) {
		logger.info("MainCtrl ::: mainContents ");
		rm.clear();
		System.out.println("hash ::: "+mp.getHash());
		rm.put("cnt", mp.getHash());
    	rm.put("date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));	
		Util.log.accept("main chart date :: " +rm.get("date"));
		rm.put("memberId", memberId);
		System.out.println("chart ::: "+mp.getChart(rm));
		rm.put("top5", mp.getChart(rm));
		
		return rm;
	}
	
	@GetMapping("/hash")
	public Map<String,Object> hash() {
		logger.info("MainCtrl ::: hash ");
		rm.clear();
		System.out.println("hash ::: "+mp.getHash());
		rm.put("cnt", mp.getHash());
		return rm;
	}
	
	@GetMapping("/chart")
	public Map<String,Object> chart() {
		logger.info("MainCtrl ::: chart ");
		rm.clear();
	     rm.put("date", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));	
		 Util.log.accept("main chart date :: " +rm.get("date"));
		System.out.println("chart ::: "+mp.getChart(rm));
		rm.put("top5", mp.getChart(rm));
		
		return rm;
	}
	
}
