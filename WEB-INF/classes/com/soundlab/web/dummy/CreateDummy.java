package com.soundlab.web.dummy;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;

public class CreateDummy {

	public static void main(String[] args) {
		chartview();

	}
	static void artistUpDown사운드제외() {
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
		int[] artists = {
				
				11,
				
				19,
				20
		};
		
		for(int i=0;i<100;i++) {
			int memIndex = (int)(Math.random()*16);
			int	musicIndex = (int)(Math.random()*3);
			System.out.println("INSERT INTO UPDOWN (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, TYPES)\n" 
					+"VALUES\n" 
					+"('"+mems[memIndex]+"',"+artists[musicIndex]+",'artist','u');");
		}
		
		
	}
	static void redmusicUpDown() {
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
		int[] revelmusics = {
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
		};
		for(int i=0;i<100;i++) {
			int memIndex = (int)(Math.random()*16);
			int	musicIndex = (int)(Math.random()*10);
			System.out.println("INSERT INTO UPDOWN (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, TYPES)\n" 
					+"VALUES\n" 
					+"('"+mems[memIndex]+"',"+revelmusics[musicIndex]+",'music','d');");
		}
		
		
	}
	
	static void twicemusicUpDown() {
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
		int[] twicemusics = {   
				   119};
		for(int i=0;i<50;i++) {
			int memIndex = (int)(Math.random()*16);
			int	musicIndex = (int)(Math.random()*1);
			System.out.println("INSERT INTO UPDOWN (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, TYPES)\n" 
					+"VALUES\n" 
					+"('"+mems[memIndex]+"',"+twicemusics[musicIndex]+",'music','u');");
		}
		
		
	}
	
	static void bangmusicUpDown() {
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
		for(int i=0;i<150;i++) {
			int memIndex = (int)(Math.random()*16);
			int	bangmusicIndex = (int)(Math.random()*30);
			System.out.println("INSERT INTO UPDOWN (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, TYPES)\n" 
					+"VALUES\n" 
					+"('"+mems[memIndex]+"',"+bangmusics[bangmusicIndex]+",'music','d');");
		}
		
		
	}
	
	 static void 장르UPsound제외() {
			int[] genre = { 1,2,3,4,5,6,32 };
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
			for(int i=0;i<300;i++) {
				int memIndex = (int)(Math.random()*16);
				int	musicIndex = (int)(Math.random()*7);
				System.out.println("INSERT INTO UPDOWN (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, TYPES)\n" 
						+"VALUES\n" 
						+"('"+mems[memIndex]+"',"+genre[musicIndex]+",'genre','u');");
			}
			
	 }
	 static void chartview() {
				int[] lst = {   104	
							  ,87
								 ,119
										,62
											  ,88
										  	  ,111
												 ,107
												 ,64
										   ,123
										   ,113
										    ,93
										  ,92
										  ,78
										  ,120
										  ,117
										  ,58
										   ,94
										   ,95
										   ,96
										   ,73
											  ,124
											  ,79
												  ,80		
												 ,110
											  ,72
											  ,66
												 ,85
												  ,68
												  ,122
													 ,125
														 ,114
														 ,116
														  ,97
														  ,115
															 ,99
															 ,100
															 ,69
														  ,81
												  					  ,84
												  					  ,90
												  						 ,108	
																  ,102
																  ,57 
																  ,103
																  ,86
																  ,91
																		  ,67
																		  ,106
														
												  						  ,76
																			 ,82
																			 ,105
																			 ,74  // 방탄 아이돌
														  ,59
														  ,77
									  ,70
										  ,71
										  ,75  // 방탄 아임파인
											 ,121
													 ,118
															  ,98 
													  		  ,109	
																 ,101
																 ,112
																  ,83
													  		 ,65 //아이유 삐삐
										  ,63 //빈지노 아쿠아맨
										  ,89  // 박효신 기프트		
											 
														
														
				};
				for(int s=0;s<67;s++) {
					for(int i=0;i<s+1;i++) {
						System.out.println("INSERT INTO VIEW_RECORD (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, VIEW_DATE)\n" 
								+"VALUES\n" 
								+"('sound',"+lst[s]+",'music','2018-10-23 20:20:34');");
					}
				}
				/*for(int i=0;i<67;i++) {
					for(int j=0;j<4;j++) {
						System.out.println("INSERT INTO VIEW_RECORD (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, VIEW_DATE)\n" 
								+"VALUES\n" 
								+"('shin',"+lst[i]+",'music','2018-11-02 20:20:34');");
					}
					
				}*/
	 }
	
	
	
	/*<insert id="hashRecord">
  	INSERT INTO VIEW_RECORD
  	(MEMBER_ID, SEQ_GROUP, SG_ELEMENT)
  	VALUES
  	(#{memberId},#{seq},'hash')
  </insert>*/
	static void hashView() {
		//단어구름, 해시태그, 디제이 게시판 
		for(int i=0;i<300;i++) {
			System.out.println("INSERT INTO VIEW_RECORD (MEMBER_ID, SEQ_GROUP, SG_ELEMENT)\n" 
					+"VALUES\n" 
					+"('shin',"+(int)(Math.random()*15 + 1)+",'hash');");
		}
	}
	
	
	static void adminView() {
		//방탄 관련곡들 뷰레코드 기록 생성기  '2019-01-01 20:20:34'
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
		 /*74 | IDOL
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
		int[] revelmusics = {
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
		};
		int[] twicemusics = {   116,
				   117,
				   118,
				   119,
				   120,
				   121,
				   177,
				   178,
				   179,
				   180,
				   181 };
		/*<insert id="bangRecord">
	  	INSERT INTO VIEW_RECORD
	  	(MEMBER_ID, SEQ_GROUP, SG_ELEMENT, VIEW_DATE)
	  	VALUES
	  	(#{memberId},#{seq},'music', '2019-01-01 20:20:34')
	  </insert>*/
		for(int i=0;i<500;i++) {
			int memIndex = (int)(Math.random()*16);
			int	bangmusicIndex = (int)(Math.random()*10);
			System.out.println("INSERT INTO VIEW_RECORD (MEMBER_ID, SEQ_GROUP, SG_ELEMENT, VIEW_DATE)\n" 
					+"VALUES\n" 
					+"('"+mems[memIndex]+"',"+revelmusics[bangmusicIndex]+",'music','2019-01-01 20:20:34');");
		}
		
		
	}
}
