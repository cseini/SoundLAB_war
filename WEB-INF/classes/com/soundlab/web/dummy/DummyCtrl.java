package com.soundlab.web.dummy;


import java.util.HashMap;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;




@RestController
@RequestMapping("/dummy")
public class DummyCtrl {
	static final Logger logger = LoggerFactory.getLogger(DummyCtrl.class);
	@Autowired Map<String,Object> rm;
	@Autowired DummyMapper dp;
	
	
	@GetMapping("/loginRecord")
	public Map<String,Object> loginRecord(){
		logger.info("DummyCtrl ::: loginRecord ");
		rm.clear();
		String[] man = { "admin","metus","mollis","neque","nulla","ornare","pizza","risus","sapien","semper","shin",
				 "tempus","tortor","velit","mattis","zuzu","ligula","libero","criss","congue"};
		String[] woman = {  "sound2","tellus","tempor","turpis","varius","auctor","vitae","sound","dolor","mauris",
				"magna","lorem","lacus","justo","porta","ipsum","felis","enimIn","massa"};
		String[] date = {"2018-11-12 10:12:30","2018-11-13 10:12:30","2018-11-14 10:18:50",
				"2018-11-15 10:18:50","2018-11-16 10:18:50","2018-11-17 10:18:50",
				"2018-11-18 10:18:50","2018-11-19 10:18:50","2018-11-20 10:18:50",
				"2018-11-21 10:18:50",
				"2018-11-22 10:18:50","2018-11-23 10:18:50","2018-11-24 10:18:50",
				"2018-11-25 10:18:50"};
		Map<String, String> mm = new HashMap<String, String>();
		Map<String, String> wm = new HashMap<String, String>();
		for(int i=0;i<14;i++) {
			int ml = (int)((Math.random()*6)+1);
			int wl = (int)((Math.random()*6)+1);
			int mi = (int)((Math.random()*20));
			int wi = (int)((Math.random()*19));
			mm.put("memberId", man[mi]);
			mm.put("sex", "남");
			mm.put("date", date[i]);
			wm.put("memberId", woman[wi]);
			wm.put("sex", "여");
			wm.put("date", date[i]);
			for(int j=0;j<ml;j++) {
				dp.loginRecord(mm);
			}
			for(int j=0;j<wl;j++) {
				dp.loginRecord(wm);
			}	
		}
		
		return rm;
	}
	
	/*<insert id="hashRecord">
  	INSERT INTO VIEW_RECORD
  	(MEMBER_ID, SEQ_GROUP, SG_ELEMENT)
  	VALUES
  	(#{memberId},#{seq},'hash')
  </insert>*/
	@GetMapping("/hash")
	public Map<String,Object> hash(){
		logger.info("DummyCtrl ::: hash ");
		rm.clear();
		rm.put("memberId", "shin");
		for(int j=0;j<100;j++) {
			rm.put("seq", (int)(Math.random()*15 + 1));
			int cnt = (int)(Math.random()*70 + 1);
			for(int i=0;i<cnt;i++) {
				dp.hashRecord(rm);
			}
		}
		return rm;
	}
	
	@GetMapping("/view")
	public Map<String,Object> view(){
		logger.info("DummyCtrl ::: view ");
		rm.clear();
		String[] mems = {
				"libero","varius",
				"libero","varius",
				"ornare","justo",
				"ornare","justo",
				"ornare","justo",
				"velit","massa",
				"velit","massa",
				"nulla","lorem"
		};
		/* 74 | IDOL
	     75 | I`m Fine
	     76 | Euphoria
	    133 | FAKE LOVE
	    134 | 전하지 못한 진심 (Feat. Steve Aoki)
	    135 | Anpanman
	    136 | Airplane pt.2
	    137 | DNA
	    138 | MIC Drop
	    139 | 고민보다 Go
	    140 | Best Of Me
	    141 | 봄날
	    142 | Not Today
	    143 | Lost
	    144 | BTS Cypher 4
	    145 | 피 땀 눈물
	    146 | Am I Wrong
	    147 | 21세기 소녀
	    148 | 둘! 셋! (그래도 좋은 날이 더 많기를)
	    149 | 불타오르네 (FIRE)
	    150 | Save ME
	    151 | EPILOGUE : Young Forever
	    152 | RUN
	    153 | Butterfly
	    154 | Whalien 52
	    155 | 뱁새
	    156 | I NEED U
	    157 | 쩔어
	    158 | 흥탄소년단
	    159 | 잡아줘 (Hold Me Tight)
	    30곡*/
		int[] bangmusics = { 74,
				75,
			    76,
			   133,
			   134,
			   135,
			   136,
			   137,
			   138,
			   139,
			   140,
			   141,
			   142,
			   143,
			   144,
			   145,
			   146,
			   147,
			   148,
			   149,
			   150,
			   151,
			   152,
			   153,
			   154,
			   155,
			   156,
			   157,
			   158,
			   159};
		
		for(int i=0;i<1000;i++) {
			int memIndex = (int)(Math.random()*16);
			int	bangmusicIndex = (int)(Math.random()*30);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", bangmusics[bangmusicIndex]);
			dp.bangRecord(rm);
		}
		
		return rm;
	}
	
	
	@GetMapping("/updown")
	public Map<String,Object> updown(){
		logger.info("DummyCtrl ::: updown ");
		rm.clear();
		/*8명*/
		String[] mems = {
			"libero","varius",
			"libero","varius",
			"ornare","justo",
			"ornare","justo",
			"ornare","justo",
			"velit","massa",
			"velit","massa",
			"nulla","lorem"
		};
	
				
		int[] genres = {1,2,3,6,32};
		
		int[] artists = {11,19,20};
		
		
	    /* 74 | IDOL
	     75 | I`m Fine
	     76 | Euphoria
	    133 | FAKE LOVE
	    134 | 전하지 못한 진심 (Feat. Steve Aoki)
	    135 | Anpanman
	    136 | Airplane pt.2
	    137 | DNA
	    138 | MIC Drop
	    139 | 고민보다 Go
	    140 | Best Of Me
	    141 | 봄날
	    142 | Not Today
	    143 | Lost
	    144 | BTS Cypher 4
	    145 | 피 땀 눈물
	    146 | Am I Wrong
	    147 | 21세기 소녀
	    148 | 둘! 셋! (그래도 좋은 날이 더 많기를)
	    149 | 불타오르네 (FIRE)
	    150 | Save ME
	    151 | EPILOGUE : Young Forever
	    152 | RUN
	    153 | Butterfly
	    154 | Whalien 52
	    155 | 뱁새
	    156 | I NEED U
	    157 | 쩔어
	    158 | 흥탄소년단
	    159 | 잡아줘 (Hold Me Tight)
	    30곡*/
		/*int[] bangmusics = { 74,
				75,
			    76,
			   133,
			   134,
			   135,
			   136,
			   137,
			   138,
			   139,
			   140,
			   141,
			   142,
			   143,
			   144,
			   145,
			   146,
			   147,
			   148,
			   149,
			   150,
			   151,
			   152,
			   153,
			   154,
			   155,
			   156,
			   157,
			   158,
			   159};*/
		
		/*방탄곡 업 몇개 지우고 넣음
		int[] bangmusics = {
			   136, //9개
			   140, //10개
			   143,  //10개
			   154,  // 15개
			   157   // 10개
			   };
		 for(int i=0;i<9;i++) {
			int memIndex = (int)(Math.random()*16);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", bangmusics[0]);
			dp.musicUp(rm);
		}
		 for(int i=0;i<10;i++) {
				int memIndex = (int)(Math.random()*16);
				rm.put("memberId", mems[memIndex]);
				rm.put("seq", bangmusics[1]);
				dp.musicUp(rm);
			}
		 for(int i=0;i<10;i++) {
				int memIndex = (int)(Math.random()*16);
				rm.put("memberId", mems[memIndex]);
				rm.put("seq", bangmusics[2]);
				dp.musicUp(rm);
			}
		 for(int i=0;i<15;i++) {
				int memIndex = (int)(Math.random()*16);
				rm.put("memberId", mems[memIndex]);
				rm.put("seq", bangmusics[3]);
				dp.musicUp(rm);
			}
		 for(int i=0;i<10;i++) {
				int memIndex = (int)(Math.random()*16);
				rm.put("memberId", mems[memIndex]);
				rm.put("seq", bangmusics[4]);
				dp.musicUp(rm);
			}*/
		 /*116 | Dance The Night Away
		 117 | CHILLAX
		 118 | Shot thru the heart
		 119 | What is Love?
		 120 | HO!
		 121 |  SWEET TALKER?
		 177 | CHEER UP
		 178 | KNOCK KNOCK
		 179 | LIKEY
		 180 | Heart Shaker
		 181 | TT
		 11곡*/
		/*int[] twicemusics = {   116,
				   117,
				   118,
				   119,
				   120,
				   121,
				   177,
				   178,
				   179,
				   180,
				   181 };*/
		
		 /*105 | Power Up
		 106 | 한 여름의 크리스마스
		 107 | Mr. E
		 108 | Mosquito
		 109 | Hit That Drum
		 182 | 빨간 맛 (Red Flavor)
		 183 | Bad Boy
		 184 | 러시안 룰렛 (Russian Roulette)
		 185 | Rookie
		 186 | Ice Cream Cake
		 10곡*/
		/*int[] revelmusics = {
				 105,
				 106,
				 107,
				 108,
				 109,
				 182,
				 183,
				 184,
				 185,
				 186	
		};*/
		
		//장르업
		/*for(int i=0;i<100;i++) {
			int memIndex = (int)(Math.random()*16);
			int genreIndex = (int)(Math.random()*5);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", genres[genreIndex]);
			dp.genreUp(rm);
		}*/
		//아티스트업
		/*for(int i=0;i<50;i++) {
			int memIndex = (int)(Math.random()*16);
			int artistIndex = (int)(Math.random()*3);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", artists[artistIndex]);
			dp.artistUp(rm);
		}*/
		//아티스트다운
				/*for(int i=0;i<100;i++) {
					int memIndex = (int)(Math.random()*16);
					int artistIndex = (int)(Math.random()*3);
					rm.put("memberId", mems[memIndex]);
					rm.put("seq", artists[artistIndex]);
					dp.artistDown(rm);
				}*/
		//방탄뮤직업
		/*for(int i=0;i<300;i++) {
			int memIndex = (int)(Math.random()*16);
			int	bangmusicIndex = (int)(Math.random()*30);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", bangmusics[bangmusicIndex]);
			dp.musicUp(rm);
		}*/
		//방탄뮤직다운
		/*for(int i=0;i<100;i++) {
			int memIndex = (int)(Math.random()*16);
			int	bangmusicIndex = (int)(Math.random()*30);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", bangmusics[bangmusicIndex]);
			dp.musicDown(rm);
		}*/
		
		//트와이스뮤직업
		/*for(int i=0;i<100;i++) {
			int memIndex = (int)(Math.random()*16);
			int	twicemusicIndex = (int)(Math.random()*11);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", twicemusics[twicemusicIndex]);
			dp.musicUp(rm);
		}*/
		//트와이스뮤직다운
		/*for(int i=0;i<50;i++) {
			int memIndex = (int)(Math.random()*16);
			int	twicemusicIndex = (int)(Math.random()*11);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", twicemusics[twicemusicIndex]);
			dp.musicDown(rm);
		}*/
		//레벨뮤직업
		/*for(int i=0;i<100;i++) {
			int memIndex = (int)(Math.random()*16);
			int	revelmusicIndex = (int)(Math.random()*10);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", revelmusics[revelmusicIndex]);
			dp.musicUp(rm);
		}*/
		//레벨뮤직다운
		/*for(int i=0;i<50;i++) {
			int memIndex = (int)(Math.random()*16);
			int	revelmusicIndex = (int)(Math.random()*10);
			rm.put("memberId", mems[memIndex]);
			rm.put("seq", revelmusics[revelmusicIndex]);
			dp.musicDown(rm);
		}
		*/
		
		return rm;
	}
	
	@GetMapping("/chart")
	public Map<String,Object> chart() {
		logger.info("DummyCtrl ::: chart ");
		rm.clear();
		/*rm.put("memberId", "shin");
		rm.put("seq", 63);
		for(int i=0;i<400;i++) {
			dp.post(rm);
		}*/
		/*75
		 */ 
		
		int[] lst = {  
				  73
				  ,124
					
				  ,79
							  ,80		
					 ,110
				  ,72
					 ,121
			

							 ,118
					
					  ,66
					 ,85
					  ,68
					  ,70
						  ,71
					  ,86
					  ,83
				  ,88

					 ,107
					 ,64
	  ,122
		 ,125

			 ,114
	 
								  ,102
								  ,57 
								  ,103
							
								  ,91
										  ,67
										  ,106
						
					
						  ,59
						  ,77
							 ,116

					
					  ,97
					  ,115
						 ,99
						 ,100
						 ,69

					  ,81
								  ,104	
								  
								  ,87
								 ,119
				,62
						  
					 ,101
					 ,112
			
					  ,78
					  ,120

					  ,117


					  ,58
					   ,94
					   ,95
					   ,96   
					   ,123
					   ,113
					    ,93
					  ,92

					  ,98 
					  		  ,109	


					  	
					  	  ,111
					  			
					  					  ,84
					  					  ,90

					  						 ,108
					  							
					  						  ,76
						 ,82
						 ,105
							
			
		
				 ,63 //빈지노 아쿠아맨
				
				 
				
				 ,75  // 방탄 아임파인
				 ,74  // 방탄 아이돌
				 
				 ,65 //아이유 삐삐
				 ,89  // 박효신 기프트
				 
				
		};
		rm.put("memberId", "shin");
		for(int s=0;s<67;s++) {
			rm.put("seq", lst[s]);
			for(int i=0;i<s+1;i++) {
				dp.post(rm);
			}
		}
		
		return rm;
	}
}
