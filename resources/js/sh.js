"use strict";
var sh = sh || {};
sh = (()=>{
     var $ctx,$js,$css,$img,w,state;
     var setState =x=>{state=x};
     var init =()=>{
         $ctx = $.ctx();
         $js = $.js();
         $css = $.css();
         $img = $.img();
         w = $('#wrapper');
         $.when(
            $.getScript(sh.js()+'/compo.js'),
            $.getScript(sh.js()+'/sj.js'),
            $.getScript(sh.js()+'/ls.js'),
            $.getScript(sh.js()+'/jt.js'),
            $.getScript(sh.js()+'/nr.js')
         ).done(d=>{
        	 home(); 
         });
         
     };
     var home =()=>{
    	 $('#nrcss').remove();
         w.html(nav()+banner()+slider()+mainContents()+footer());
		 $('<main id="id_main">')
		 .html(
		
		'<div id="main_carousel">'
		    +'<div class="hideLeft">'
		     +'<img src="'+$.ctx()+'/resources/img/album/에이핑크_ONE_SIX.jpg">'
		   +'</div>'
		   +'<div class="prevLeftSecond">'
		     +'<img src="'+$.ctx()+'/resources/img/album/IU_꽃갈피_둘.jpg">'
		   +'</div>'
		   +'<div class="prev">'
		     +'<img src="'+$.ctx()+'/resources/img/album/빈지노_24_26.jpg">'
		  +'</div>'
		   +'<div class="selected">'
		     +'<img src="'+$.ctx()+'/resources/img/album/방탄소년단_LY_Answer.jpg">'
		   +'</div>'
		   +'<div class="next">'
		     +'<img src="'+$.ctx()+'/resources/img/album/방탄소년단_WINGS.jpg">'
		   +'</div>'
		   +'<div class="nextRightSecond">'
		     +'<img src="'+$.ctx()+'/resources/img/album/트와이스_Summer_Nights.jpg">'
		   +'</div>'
		   +'<div class="hideRight">'
		     +'<img src="'+$.ctx()+'/resources/img/album/마마무_RED_MOON.jpg">'
		   +'</div>'
		 +'</div>'
		 +'<div class="buttons">'
		 +'<button id="prev">'
		 +'<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>'
		 +'</button>'
		   +'<button id="next">'
		   +'<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>'
		   +'</button>'
		 +'</div>'
		).appendTo($('#slider'));
		     
		function moveToSelected(element) {
		if (element == "next") {
		 var selected = $(".selected").next();
		} else if (element == "prev") {
		 var selected = $(".selected").prev();
		} else {
		 var selected = element;
		}
		var next = $(selected).next();
		var prev = $(selected).prev();
		var prevSecond = $(prev).prev();
		var nextSecond = $(next).next();
		$(selected).removeClass().addClass("selected");
		$(prev).removeClass().addClass("prev");
		$(next).removeClass().addClass("next");
		$(nextSecond).removeClass().addClass("nextRightSecond");
		$(prevSecond).removeClass().addClass("prevLeftSecond");
		$(nextSecond).nextAll().removeClass().addClass('hideRight');
		$(prevSecond).prevAll().removeClass().addClass('hideLeft');
		}
		// Eventos teclado
		$(document).keydown(function(e) {
		 switch(e.which) {
		     case 37: // left
		     moveToSelected('prev');
		     break;
		     case 39: // right
		     moveToSelected('next');
		     break;
		     default: return;
		 }
		 e.preventDefault();
		});
		$('#carousel div').click(function() {
		moveToSelected($(this));
		});
		$('#prev').click(function() {
		moveToSelected('prev');
		});
		$('#next').click(function() {
		moveToSelected('next');
		});
		let loginID = 'none';
		
		if($.cookie('loginID') != null){
            loginID = $.cookie('loginID');
            $('#loginBtn').attr('id','logoutBtn').text('logout').click(()=>{
                alert('로그아웃');
                $.removeCookie("loginID");
                home();
            });
            $('#joinBtn').attr('id','myPageBtn').text('My page').click(()=>{
                sh.service.mypage();
            });
       }
		
	    $.getJSON($ctx+'/main/mainContents/'+loginID,d=>{
	    	 let hashcnt = d.cnt;
	    	 let hashdata = {"count":{"신나는":hashcnt[0],"차분한":hashcnt[1],"어쿠스틱":hashcnt[2],"트로피칼":hashcnt[3],"부드러운":hashcnt[4],"드라이브":hashcnt[5],"휴식":hashcnt[6],"편집숍&카페":hashcnt[7],"헬스":hashcnt[8],"클럽":hashcnt[9],"스트레스":hashcnt[10],"이별":hashcnt[11],"사랑&고백":hashcnt[12],"새벽감성":hashcnt[13],"위로":hashcnt[14]},
		    		 "sample_title":{"신나는":[hashcnt[0]],"차분한":[hashcnt[1]],"어쿠스틱":[hashcnt[2]],"트로피칼":[hashcnt[3]],"부드러운":[hashcnt[4]],"드라이브":[hashcnt[5]],"휴식":[hashcnt[6]],"편집숍&카페":[hashcnt[7]],"헬스":[hashcnt[8]],"클럽":[hashcnt[9]],"스트레스":[hashcnt[10]],"이별":[hashcnt[11]],"사랑&고백":[hashcnt[12]],"새벽감성":[hashcnt[13]],"위로":[hashcnt[14]]}
		     };
	    	 WordCloud({
		    		container : '#cloud-container',
		    		data : hashdata
		     });
	    	
	    	$('#cloud-container').on("click",'text',function(event){
	    		 sh.service.removeSec();
	    		 sj.dj();
	    		 setTimeout(()=>{
	    			 fn.scroll({ id : $("#djSec"), len : 200});
	    			 let hashbtn = $('input:checkbox[value="'+$(this).text()+'"]');
	    			 hashbtn.closest('button').addClass('active');
	    			 //hashbtn.prop('checked',true).trigger('change');
	    			 hashbtn.prop('checked',true).change();
	          	 },300);
	    	  });
	    	 
	    	 let genres =[];
	    	 let titles = [];
	    	 let musicSeq = [];
	    	 let albums = [];
	    	 let albumSeq = [];
	    	 let rank = [];
	    	 let img = [];
	    	 let artists = [];
	    	 let artistSeq = [];
	    	 let updown = [];
	    	 $.each(d.top5,(i,v)=>{
	    		 genres.push(v.장르);
	    		 titles.push(v.타이틀);
	    		 albums.push(v.앨범);
	    		 albumSeq.push(v.ALBUM_SEQ);
	    		 rank.push(v.RANK);
	    		 img.push(v.IMG_NAME);
	    		 artists.push(v.가수);
	    		 artistSeq.push(v.ARTIST_SEQ);
	    		 musicSeq.push(v.MUSIC_SEQ);
	    		 updown.push(v.업다운);
	    	 });
	    	 let tr,info,cover,title,artist,player,pa,up,ua,down,da;
	    	 let tb = $('#sh-tbody');
	    	 for(let i=0;i<5;i++){
	    		 tr = $('<tr/>').addClass('sh-list').appendTo(tb);
	    		 $('<td/>').addClass('sh-chart-rank').html(rank[i]).appendTo(tr);
	    		 info = $('<td/>').addClass('sh-music-info').appendTo(tr);
	    		 cover = $('<a/>').attr({href : '#'}).addClass('sh-cover').appendTo(info);
	    		 $('<span/>').addClass('mask').appendTo(cover);
	    		 $('<img/>').addClass('sh-album-img').attr({src : $img+'/album/'+img[i]}).appendTo(cover).click(e=>{
	    			 jt.album_detail(albumSeq[i]);
	    		 });
	    		 title = $('<a/>').attr({href : '#'}).addClass('sh-title').html(titles[i]).appendTo(info);
	    		 artist = $('<a/>').attr({href : '#'}).addClass('sh-artist').html(artists[i]).appendTo(info).click(e=>{
	    			 let x = artists[i];
					 jt.search(x);
					 setTimeout(()=>{
						 fn.scroll({ id : $("#jt_search"), len : 400});
			         },200);
	    		 });
	    		 player = $('<td/>').addClass('sh-music-player').appendTo(tr);
	    		 pa = $('<a/>').attr({href : '#'}).appendTo(player);
	    		 $('<i/>').addClass('ls_fa fa fa-play').appendTo(pa).click(e=>{
	    			 jt.music_player(musicSeq[i]);
	    		 });
	    		 up = $('<td/>').addClass('sh-music-upbtn').appendTo(tr);
	    		 //ua = $('<a/>').attr({href : '#'}).appendTo(up);
	    		 $('<i/>').attr({id : 'sh-up-'+i}).addClass((updown[i]==='u')?'sh-up fa fa-heart active':'sh-up fa fa-heart').appendTo(up).click(function(e){
	    			 e.preventDefault();
	    			 if(sh.service.auth()==0){
	    				 sj.service.put_ud({thiz:$(this),btn:'like',mSeq:musicSeq[i],gSeq:genres[i]});
	    			 }
	    		 });
	    		 $('<i/>').attr({id : 'sh-down-'+i}).addClass((updown[i]==='d')?'sh-down fa fa-thumbs-down active':'sh-down fa fa-thumbs-down').appendTo(up).click(function(e){
	    			 e.preventDefault();
	    			 if(sh.service.auth()==0){
	    				 sj.service.put_ud({thiz:$(this),btn:'hate',mSeq:musicSeq[i],gSeq:genres[i]});
	    			 }
	    			
	    		 });
	    	 }
	    	 $('.sh-music-info').hover(
		    		 function () {
		    			 $(this).children('a').children('img').addClass('sh-img-hover');
		    		 },
		    		 function () {
		    			 $(this).children('a').children('img').removeClass('sh-img-hover');
		    		 }
		      );

	     });

	     $('#bannerItem').carousel({
	    	 interval: 2600
	     });
         $('#loginBtn').click(()=>{
              sh.service.login();
         });
         $('#joinBtn').click(()=>{
              sh.service.join();
         });
        
         $('#searchBtn').click(e=>{
        		 let x = $('#searchInput').val();
				 jt.search(x);
    	 });
    	 $('#searchInput').keyup(e=>{
    		 if(e.keyCode == 13) { 
    			 
    			 	let x = $('#searchInput').val();
					 jt.search(x);
					 setTimeout(()=>{
						 fn.scroll({ id : $("#jt_search"), len : 400});
			         },200);
    			 
    		 } 
    	 });
         
    	 $('.chartBtn').click(e=>{
    		 e.preventDefault();
    		 if(!($("#banner").length >0)){   //not exist
    			 home(); 
        	 }
    		 sh.service.removeSec();
    		 let x = 'realChart';
   	       	 ls.chart(x)
       		 setTimeout(()=>{
       			fn.scroll({ id : $("#chartSec"), len : 200});
       		 },1500);
         });
         $('#albumBtn').click(e=>{
        	 e.preventDefault();
        	 if(!($("#banner").length >0)){   //not exist
    			 home(); 
        	 }
        	 sh.service.removeSec();
        	 let x = 'newAl_recent';
           	 ls.album(x);
           	 setTimeout(()=>{
     			  fn.scroll({ id : $("#albumSec"), len : 150});
         	 },400);
        		 
    	    
      		
         });
         $('#djBtn').click(e=>{
        	 e.preventDefault();
        	 if(!($("#banner").length >0)){   //not exist
    			 home(); 
        	 }
        	 sh.service.removeSec();
       		 sj.dj();
    		 setTimeout(()=>{
    			 fn.scroll({ id : $("#djSec"), len : 200});
          	 },400);
         });
         $('#forBtn').click(e=>{
        	 e.preventDefault();
        	 if(sh.service.auth()==0){
        		 if(!($("#banner").length >0)){   //not exist
        			 home(); 
            	 }
            	 sh.service.removeSec();  
         		 sj.forYou();
         		 setTimeout(()=>{
    				 if($("#foryouSec").length > 0){
    					 fn.scroll({ id : $("#foryouSec"), len : 200});
    				 }
             	 },400); 
        	 }
        	 
         });
         
        $('#logoImg').click(e=>{
        	e.preventDefault();
            home();
            fn.scroll({ id : $("#banner"), len : 150});
        });

     };
     var nav =()=> '<header id="header" class="header">'
     + '<div id="navBox" class="header_menu text-center affix" data-spy="affix" data-offset-top="50" >'
     /* container */
     + '<div class="container-fluid">'
     /* nav */
     + '<nav class="navbar navbar-default zero_mp ">'
     +'<div class="row">'
     +'<div id="navLB" class="col-md-1">'
     /*--여백--*/
     +'</div>'
     +'<div class="col-md-2" id="logoBox">'
     +'<img src="'+$img+'/logo.png" id="logoImg" class="logoImg">'
     +'</div>'
     +'<div class="col-md-3" id="searchBox">'
     /* searchBox */
     +'<div id="searchBox" class="searchBox">'
     +'<input id="searchInput" type="text" placeholder="검색어 입력"/>'
     +'<button id="searchBtn" type="button"/>'
     +'</div>'
     /*--searchBox--*/
     +'</div>'
     +'<div class="col-md-5">'
     /* 삼선 */
     + '<div id="samsun" class="navbar-header">'
     + '<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".collapseNav" aria-expanded="false">'
     + '<span class="sr-only">Toggle navigation</span>'
     + '<span class="icon-bar"></span>'
     + '<span class="icon-bar"></span>'
     + '<span class="icon-bar"></span>'
     + '</button>'
     + '<a class="navbar-brand custom_navbar-brand" href="#"></a>'
     + '</div>'
     /*--삼선--*/
     /* userBox */
     + '<div class="collapse navbar-collapse collapseNav" id="userBox">'
     + '<ul class="nav navbar-nav navbar-right main_menu">'
     + '<li><a id ="loginBtn" href="#" class="loginBtn">LOGIN</a></li>'
     + '<li><a id ="joinBtn" href="#" class="joinBtn">회원가입</a></li>'
     + '</ul>'
     + '</div>'
     /*--userBox--*/
     /* serviceBox */
     + '<!-- /.navbar-collapse -->'
     + '<!-- Collect the nav links, forms, and other content for toggling -->'
     + '<div class="collapse navbar-collapse collapseNav" id="serviceBox">'
     + '<ul class="nav nav-justified navbar-right main_menu">'
     + '<li class="chartBtn"><a id="chartBtn" href="#chartSec" class="chartBtn">차트 <span class="sr-only">(current)</span></a></li>'
     + '<li class="albumBtn"><a id="albumBtn" href="#albumSec" class="albumBtn">최신앨범</a></li>'
     + '<li class="djBtn"><a id="djBtn" href="#djSec" class="djBtn">뮤직DJ</a></li>'
     + '<li class="forBtn"><a id="forBtn" href="#foryouSec" class="forBtn">FOR YOU</a></li>'
     + '</ul>'
     + '</div>'
     /*--serviceBox--*/
     +'</div>'
     +'<div id="navRB" class="col-md-1">'
     /*--여백--*/
     +'</div>'
     +'</div>'
     + '<!-- /.navbar-collapse -->'
     + '</nav>'
     /*--nav--*/
     + '</div>'
     /*--container--*/
     //+ '</div>'
     + '<!--End of header menu-->'
     + '</header>'
    +'<!--Scroll to top-->'
    +'<a href="#" id="back-to-top" title="Back to top" class="show">↑</a>'
    +'<!--End of Scroll to top-->'
    +'<div id="contents">';
var banner =()=> '<section id="banner" class="banner">'
		+'<div class="container-fluid">'
		+'<div class="col-md-2">'
	     /*--여백--*/
	     +'</div>'
	     +'<div class="col-md-8" id="bannerBox">'
		+'<div id="bannerItem" class="carousel slide" data-ride="carousel">'
		+'<ol class="carousel-indicators">'
		  +'<li data-target="#bannerItem" data-slide-to="0" class="active"></li>'
		  +'<li data-target="#bannerItem" data-slide-to="1" class=""></li>'
		  +'<li data-target="#bannerItem" data-slide-to="2" class=""></li>'
		+'</ol>'
		+'<div id="bannerImg" class="carousel-inner" role="listbox">'
		  +'<div class="item active">'
		    +'<img src="'+$img+'/메인캐러셀1.jpg" alt="First slide">'
		    +'<div class="carousel-caption">'
			//+'<h4>2018 Grand Mint Festival</h2>'
			//+'<h5>일시 : 2018년 10월 20일(토요일)- 10월 21일(일요일)</h3>'
			//+'<h5>위치 : 올림픽 공원 (서울 송파구 올림픽로 424 올림픽공원)</h3>'
		    +'</div>'
		  +'</div>'
		  +'<div class="item">'
		    +'<img src="'+$img+'/메인캐러셀2.jpg" alt="Second slide">'
		    +'<div class="carousel-caption">'
		    //+'<h4>2018 스타라이트 뮤지컬 페스티벌</h2>'
			//+'<h5>일시 : 2018년 10월 20일(토요일)-10월 21일(일요일)</h3>'
			//+'<h5>위치 : 인천 파라다이스 시티 호텔 (인천광역시 중구 영종해안남로321번길 186)</h3>'
		    +'</div>'
		  +'</div>'
		  +'<div class="item">'
		    +'<img src="'+$img+'/메인캐러셀3.jpg" alt="Third slide">'
		    +'<div class="carousel-caption">'
		    //+'<h4>할로윈 레드문 서울 패션 페스티벌 2018</h2>'
			//+'<h5>일시 : 2018년 10월 27일(토요일)</h3>'
		    +'</div>'  
		  +'</div>'
		+'</div>'
		+'<a class="left carousel-control" href="#bannerItem" role="button" data-slide="prev">'
		  +'<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>'
		  +'<span class="sr-only">Previous</span>'
		+'</a>'
		+'<a class="right carousel-control" href="#bannerItem" role="button" data-slide="next">'
		  +'<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>'
		  +'<span class="sr-only">Next</span>'
		+'</a>'
		+'</div>'
		+'</div>'
		+'<div class="col-md-2">'
	     /*--여백--*/
	     +'</div>'
		+'</div>'
     +'</section>';
var slider =()=> '<section id="slider">'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</br>'
		+'</section>';	
var mainContents =()=> '<section id="mainContents">'
     +'<div class="container-fluid">'
     +'<div class="col-md-1">'
     +'</div>'
	 /* cloud */
	 +'<div id="cloud"  class="col-md-5">'
     +'</br>'
     +'</br>'
     +'</br>'
     +'<div id="cloud-container"></div>'
     +'</div>'
     /* top five */
     +'<div id="topFive" class="topFive col-md-3">'
     +'</br>'
     +'</br>'
     +'</br>'
	     +'<table class="sh-listbox">'
	     +'<a id="main-chart" class="chartBtn">실시간 차트</a>'
	    +'<thead>'
	        +'<tr class="sh-list sh-hover">'
	            +'<th scope="col" class="col-md-1">순위</th>'
	            +'<th scope="col" class="col-md-8">곡정보</th>'
	            +'<th scope="col" class="col-md-1">듣기</th>'
	            +'<th scope="col" class="col-md-2">좋아요</th>'
	        +'</tr>'
	    +'</thead>'
	    +'<tbody id="sh-tbody">'
	    +'</tbody>'
	+'</table>'
     +'</br>'
     +'</br>'
     +'</br>'
     +'</br>'
     +'</br>'
     +'</div>'
     +'<div class="col-md-1">'
     +'</div>'
     +'</div>'
     +'</section>';
     
var footer =()=> '</div>'
     +'<section id="footer">'
     +'</br>'
     +'</br>'
     +'</br>'
     +'</br>'
     +'</br>'
     +'</br>'
+'</div>'
+'</section>';
var login = ()=> '<section id="loginSec" class="loginSec" >'
	 +'<div class="container-fluid">'
	 +'<div class="col-md-4">'
	 +'</div>'
	 +'<div class="col-md-5">'
	 /* loginBox */
     +'<div id="loginBox" class="loginBox">'
     +'<div id="logoForm" class="logoForm">'
     +'<img src="'+$.img()+'/logo.png" id="logoImg" class="loginLogo"><h2 class="loginInst">로그인 후 이용하실 수 있습니다.</h2>'
     +'</div>'
     +'<div id="loginForm" class="loginForm">'
     +'<input id="memberId" class="loginInput" type="text" placeholder="아이디" required/></br>'
     +'<input id="pass" class="loginInput" type="password" placeholder="비밀번호" required/></br>'
     +'<span class="saveID"><input type="checkbox" class="saveID" id="saveID"/>  ID저장</span>'
     +'</div>'
     +'</div>'
     /*--loginBox--*/
     +'</div>'
     +'<div class="col-md-3">'
	 +'</div>'
	 +'</div>'
     +'</section>';
var login2 = ()=> '<section id="loginSec" class="loginSec" >'
+'<div class="container-fluid">'
+'<div class="col-md-4">'
+'</div>'
+'<div class="col-md-5">'
/* loginBox */
+'<div id="loginBox" class="loginBox">'
+'<div id="logoForm" class="logoForm">'
+'<img src="'+$.img()+'/logo.png" id="logoImg" class="loginLogo2"><h2 class="loginInst">로그인 후 이용하실 수 있습니다.</h2>'
+'</div>'
+'<div id="loginForm" class="loginForm">'
+'<input id="memberId" class="loginInput" type="text" placeholder="아이디" required/></br>'
+'<input id="pass" class="loginInput" type="password" placeholder="비밀번호" required/></br>'
+'</div>'
+'</div>'
/*--loginBox--*/
+'</div>'
+'<div class="col-md-3">'
+'</div>'
+'</div>'
+'</section>';
var find = ()=> '<section id="loginSec" class="loginSec" >'
+'<div class="container-fluid">'
+'<div class="col-md-4">'
+'</div>'
+'<div class="col-md-5">'
/* loginBox */
+'<div id="loginBox" class="loginBox">'
+'<div id="logoForm" class="logoForm">'
+'<img src="'+$.img()+'/logo.png" id="logoImg" class="loginLogo2"><h2 class="loginInst">로그인 후 이용하실 수 있습니다.</h2>'
+'</div>'
+'<div id="loginForm" class="loginForm">'
+'<input id="memberId" class="loginInput" type="text" placeholder="메일" required/></br>'
+'</div>'
+'</br>'
+'</br>'
+'</br>'
+'</br>'
+'</div>'
/*--loginBox--*/
+'</div>'
+'<div class="col-md-3">'
+'</div>'
+'</div>'
+'</section>';
var join = ()=> '<section id="joinSec" class="joinSec">'
	 +'<div class="container-fluid">'
	 +'<div class="col-md-4">'
	 +'</div>'
	 +'<div class="col-md-5">'
     +'<div id="joinBox" class="joinBox">'
     +'<div id="logoForm" class="logoForm">'
     +'<p><img src="'+$.img()+'/logo.png" id="logoImg" class="joinLogo"></p>'
     +'</div>'
     +'<div id="joinForm" class="joinForm">'
     +'아이디'
     +'<span id="idInput"><input id="memberId" class="joinInput joinId" type="text" placeholder="아이디" required/></span></br>'
     +'비밀번호'
     +'<input id="pass" type="password" class="joinInput joinPass"  placeholder="비밀번호" required/></br>'
     +'<input id="pass2" type="password" class="joinInput joinPass2" placeholder="비밀번호 재입력" required/></br>'
     +'이름'
     +'<input id="name" class="joinInput joinName" required/><br>'
     +'닉네임'
     +'<input id="nick" class="joinInput joinNick" required/><br>'
     +'생년월일'
     +'<input id="ssn" class="joinInput joinSsn" placeholder="예)920807" required/><br>'
     +'성별'
     +'<span class="joinMan"><input type="radio" name="sex" value="남" checked="checked"/>  남</span>'
     +'<span class="joinWoman"><input type="radio" name="sex" value="여"/>  여</span>'
     +'</br>'
     +'이메일'
     +'<input id="email" class="joinMail" placeholder="이메일 입력" required/> @ '
     +'<select name="domain" class="mailDomain" id="domain">'
        +' <option value="">선택</option>'
        +' <option value="nate.com" selected="selected"> nate.com</option>'
        +' <option value="naver.com"> naver.com</option>'
        +' <option value="daum.net"> daum.net</option>'
        +' <option value="gmail.com"> gmail.com</option>'
        +' <option value="hanmail.net"> hanmail.net</option>'
        +' <option value="yahoo.com"> yahoo.com</option>'
        +' <option value="lycos.co.kr"> lycos.co.kr</option>'
        +' <option value="cyworld.com"> cyworld.com</option>'
        +' <option value="paran.com"> paran.com</option>'
        +' <option value="empal.com"> empal.com</option>'
        +' <option value="dreamwiz.com"> dreamwiz.com</option>'
        +' <option value="korea.com"> korea.com</option>'
        +' <option value="hanmir.com"> hanmir.com</option>'
        +' <option value="hitel.net"> hitel.net</option>'
        +' <option value="freechal.com"> freechal.com</option>'
     +'</select>'
     +'</br>'
     +'휴대폰'
     +'<input id="phone" class="joinInput joinPhone" required/></br>'
     +'</br>'
     +'<p class="inst1">추가 입력 사항</p>'
     +'<p class="inst2">-선호 장르(최대 2개)</p>'
     +'<div class="selectGenre">'
     +'<span class="genre"><input type="checkbox" class="genre" value="발라드" checked="checked" />   발라드 </span>'
     +'<span class="genre"><input type="checkbox" class="genre" value="힙합" />   힙합 </span>'
     +'<span class="genre"><input type="checkbox" class="genre" value="댄스" />   댄스 </span>'
     +'<span class="genre"><input type="checkbox" class="genre" value="트로트" />   트로트 </span>'
     +'</br>'
     +'<span class="genre"><input type="checkbox" class="genre" value="일렉트로닉" />   일렉트로닉 </span>'
     +'<span class="genre"><input type="checkbox" class="genre" value="알앤비소울" />   알앤비/소울 </span>'
     +'</div>'
     +'</br>'
     +'<p class="inst3">-선호 아티스트(최대 3명)</p>'
     +'<div id="selectArtist" class="selectArtist">'
     +'<span class="artist"><input type="checkbox" class="artist" value="선미" checked="checked" />   선미 </span>'
     +'<span class="artist"><input type="checkbox" class="artist" value="빈지노" />   빈지노 </span>'
     +'<span class="artist"><input type="checkbox" class="artist" value="아이유" />   아이유 </span>'
     +'<span class="artist"><input type="checkbox" class="artist" value="임창정" />   임창정 </span>'
     +'</br>'
     +'<span class="artist"><input type="checkbox" class="artist" value="방탄소년단" />   방탄소년단 </span>'
     +'<span class="artist"><input type="checkbox" class="artist" value="에이핑크" />   에이핑크 </span>'
     +'</div>'
     +'</div>'
     /*joinForm end*/
     +'</div> <!-- joinBox end -->'
     +'</div>'
     +'<div class="col-md-3">'
	 +'</div>'
	 +'</div>'
     +'</section>';
var mypage =()=>'<section id="mypageSec" class="joinSec">'
	 +'<div class="container-fluid">'
	 +'<div class="col-md-4">'
	 +'</div>'
	 +'<div class="col-md-5">'
	 +'<div id="joinBox" class="joinBox">'
	 +'<div id="logoForm" class="logoForm">'
	 +'<p><img src="'+$.img()+'/logo.png" id="logoImg" class="joinLogo"></p>'
	 +'</div>'
	 +'<div id="joinForm" class="joinForm">'
	 +'아이디'
	 +'<span id="idInput"><input id="memberId" class="joinInput joinId" type="text" readonly/></span></br>'
	 +'비밀번호'
	 +'<input id="pass" type="password" class="joinInput joinPass"  placeholder="새로운 비밀번호" required/></br>'
	 +'<input id="pass2" type="password" class="joinInput joinPass2" placeholder="비밀번호 재입력" required/></br>'
	 +'</br>'
	 +'이메일'
	 +'<input id="email" class="joinMail" placeholder="이메일 입력" required/> @ '
	 +'<select name="domain" class="mailDomain" id="domain">'
	   +' <option value="">선택</option>'
	   +' <option value="nate.com" selected="selected"> nate.com</option>'
	   +' <option value="naver.com"> naver.com</option>'
	   +' <option value="daum.net"> daum.net</option>'
	   +' <option value="gmail.com"> gmail.com</option>'
	   +' <option value="hanmail.net"> hanmail.net</option>'
	   +' <option value="yahoo.com"> yahoo.com</option>'
	   +' <option value="lycos.co.kr"> lycos.co.kr</option>'
	   +' <option value="cyworld.com"> cyworld.com</option>'
	   +' <option value="paran.com"> paran.com</option>'
	   +' <option value="empal.com"> empal.com</option>'
	   +' <option value="dreamwiz.com"> dreamwiz.com</option>'
	   +' <option value="korea.com"> korea.com</option>'
	   +' <option value="hanmir.com"> hanmir.com</option>'
	   +' <option value="hitel.net"> hitel.net</option>'
	   +' <option value="freechal.com"> freechal.com</option>'
	 +'</select>'
	 +'</br>'
	 +'휴대폰'
	 +'<input id="phone" class="joinInput joinPhone" required/></br>'
	 +'</br>'
	 +'</div>'
	 +'</div>'
	 +'</div>'
	 +'<div class="col-md-3">'
	 +'</div>'
	 +'</div>'
	 +'</section>';
     return {
         ctx : ()=>$ctx,
         js : ()=>$js,
         css : ()=>$css,
         img : ()=>$img,
         w : ()=>w,
         init : init,
         home : home,
         nav : nav,
         banner : banner,
         mainContents : mainContents,
         footer : footer,
         login : login,
         login2 : login2,
         find : find,
         join : join,
         mypage : mypage
      };
})();
sh.service ={
     login : ()=>{
    	 $('#nrcss').remove();
         $(sh.w()).html(sh.login());
          let $memberId =  $('#memberId');
          let $pass = $('#pass');
          let $saveID = $('#saveID');
          if($.cookie('saveID') === 't'){
        	  $memberId.val($.cookie("savedID"));
        	  $pass.val($.cookie("savedPASS"));
        	  $saveID.prop('checked',true);
          }
          let $loginForm = $('#loginForm');
          ui.br({len : 1, at : $loginForm});
          ui.span({ clazz : 'findJoin', at : $loginForm});
          ui.a({ id : 'findIdBtn', clazz : 'findJoinBtn', txt : '아이디/비밀번호 찾기', at : $('.findJoin')})
          .attr({ 'data-tooltip-text' : '미구현 기능입니다. :) '});
          ui.a({ id : 'joinBtn', clazz : 'findJoinBtn', txt : '회원가입', at : $('.findJoin')})
          .click(e=>{
                   sh.service.join();
              });
          ui.br({len : 4, at : $loginForm});
          ui.btn({ id : 'loginConf', clazz : 'loginConf', txt : '로그인', at : $loginForm})
          .click(e=>{
               if(fn.loginValidation({ id : $memberId.val(), pass : $pass.val()})){
                   $.ajax({
                       url : sh.ctx()+'/member/login',
                       method : 'post',
                       contentType : 'application/json',
                       data : JSON.stringify({
                           memberId : $memberId.val(),
                           pass : $pass.val()
                       }),
                       success : d=>{
                           if(d.valid === "admin"){
                        	   sh.service.loginInfo(d);
                        	   nr.init();
                           }
                           else if(d.valid === "user"){
                               sh.service.loginInfo(d);
                               sh.home();
                           }else{
                               alert(d.valid+'가 틀렸습니다.');
                               sh.service.login();
                           }
                       }
                     });
                }
      });
          $('<a/>').attr({id:'kakao-login-btn', href:'/oauth/authorize?client_id={15e9bb1b311247918da5a29ec083b4b1}&redirect_uri={http://localhost/oauth}&response_type=code'}).appendTo($loginForm);
          $('<a/>').attr({href:'http://developers.kakao.com/logout'}).appendTo($loginForm);
   
          Kakao.cleanup();
          Kakao.init('2cc6f2bb03b5c2f7532151a1692ca793');
          
          Kakao.Auth.createLoginButton({
              container: '#kakao-login-btn',
              success: function(authObj) {
            	  Kakao.API.request({
            		  url:'/v1/user/me',
                      success : d=>{
                          $.ajax({
                              url : sh.ctx()+'/member/kakao',
                              method : 'post',
                              contentType : 'application/json',
                              data : JSON.stringify({
                                  KAKAO_ID : d.id,
                                  KAKAO_PASS : d.uuid
                              }),
                              success : x=>{
                            	  if(x.valid === 'Y'){
                            		  $.cookie("loginID",x.memberId);
                            		  sh.home();
                            	  }else{
                            		  alert('카카오톡 최초 로그인시 기존 아이디 로그인이 필요합니다.');
                            		  $(sh.w()).html(sh.login2());
                            		  let $loginForm = $('#loginForm');
                            		  ui.br({len : 4, at : $loginForm});
                                      ui.btn({ id : 'loginConf', clazz : 'loginConf2', txt : '로그인', at : $loginForm})
                                      .click(e=>{
                                    	  e.preventDefault();
                                           if(fn.loginValidation({ id : $('#memberId').val(), pass : $('#pass').val()})){
                                               $.ajax({
                                                   url : sh.ctx()+'/member/login',
                                                   method : 'post',
                                                   contentType : 'application/json',
                                                   data : JSON.stringify({
                                                       memberId : $('#memberId').val(),
                                                       pass : $('#pass').val(),
                                                       KAKAO_ID : x.kId,
                                                       KAKAO_PASS : x.kPass
                                                   }),
                                                   success : f=>{
                                                       if(f.valid === "user"){
                                                    	   $.cookie("loginID",f.memberId);
                                                 		   sh.home();
                                                       }else{
                                                           alert(f.valid+'가 틀렸습니다.');
                                                       }
                                                   }
                                                 });
                                            }
                                  });
                            	  }
                                  
                                  
                              }
                            });
                      }	  
            	  });
              },
              fail: function(err) {
                 alert(JSON.stringify(err));
              }
            });
          
         fn.scroll({ id : $("#wrapper"), len : 0});
         $('#logoImg').click(e=>{
        	  e.preventDefault();
              sh.home();
              fn.scroll({ id : $("#banner"), len : 150});
         });
         
     },
     join : ()=>{
         $(sh.w()).html(sh.join());
         
         let $joinForm = $('#joinForm');
         ui.btn({
        	 clazz : 'dupleCheck',
        	 txt : '중복확인',
             at : $('#idInput')
         })
         .click(e=>{
        	 $.getJSON(sh.ctx()+'/member/'+$('#memberId').val(),d=>{
        		alert(d.valid);
        		
        	 });
         });
         
         ui.btn({
        	 clazz : 'joinConf',
        	 txt : '회원가입',
             at : $joinForm
         })
         .click(e=>{
        	 let memberId = $('#memberId').val();
             let pass = $('#pass').val();
             let name = $('#name').val();
             let nick = $('#nick').val();
             let ssn = $('#ssn').val();
             let email = $('#email').val()+'@'+$('#domain').val();
             let phone = $('#phone').val();
             
        	 if(fn.joinValidation(
                     { id : memberId,
                       pass : pass,
                       pass2 : $('#pass2').val(),
                       name : name,
                       nick : nick,
                       ssn : ssn,
                       email : email,
                       phone : phone
                     })){
                let genres = [];
                $('input:checkbox[class=genre]:checked').each((i,o)=>{
                          genres.push(o.value);
                  });
                let artists = [];
                $('input:checkbox[class=artist]:checked').each((i,o)=>{
                	artists.push(o.value);
                });
                $.ajax({
                    url : sh.ctx()+'/member/member',
                    method : 'post',
                    contentType : 'application/json',
                    data : JSON.stringify({
                        memberId : memberId,
                        pass : pass,
                        name : name,
                        nick : nick,
                        ssn : ssn,
                        sex : $('input[name="sex"]:checked').val(),
                        email : email,
                        phone : phone,
                        genres : JSON.stringify(genres),
                        artists : JSON.stringify(artists)
                    }),
                    success : d=>{
                        alert(d.valid);
                        if(d.valid === '회원가입성공'){
                        	sh.service.login();
                        }
                    }
                  });
            }
         });
         $('#logoImg').click(e=>{
        	  e.preventDefault();
              sh.home();
              fn.scroll({ id : $("#banner"), len : 150});
         });
          $('input:checkbox[class=genre]').click(function() { 
                let genreCnt = $('input:checkbox[class=genre]:checked').length;
                if(genreCnt>2){
                 alert('최대 2개까지 선택 가능합니다.')
                 $(this).prop('checked', false);
                }
                
          });
          $('input:checkbox[class=artist]').click(function() { 
              let artistCnt = $('input:checkbox[class=artist]:checked').length;
              if(artistCnt>3){
               alert('최대 3명까지 선택 가능합니다.')
               $(this).prop('checked', false);
              }
              
        });
     },
     find : ()=>{
    	/* $(sh.w()).html(sh.find());*/
    	
     },
     mypage : ()=>{
         $(sh.w()).html(sh.mypage());
         $('#memberId').val($.cookie('loginID'));
         let $mypageForm = $('#joinForm');
         ui.btn({
        	 clazz : 'dupleCheck',
        	 txt : '정보수정',
             at : $('#idInput')
         }).click(e=>{
        	 let memberId = $('#memberId').val();
        	 let pass = $('#pass').val();
        	 let email = $('#email').val()+'@'+$('#domain').val();
        	 let phone =  $('#phone').val();
        	 if(fn.mypageValidation(
                     { id : memberId,
                       pass : pass,
                       pass2 : $('#pass2').val(),
                       email : email,
                       phone : phone
                     })){
        		 $.ajax({
                     url : sh.ctx()+'/member/member',
                     method : 'put',
                     contentType : 'application/json',
                     data : JSON.stringify({
                         memberId : memberId,
                         pass : pass,
                         email : email,
                         phone : phone,
                     }),
                     success : d=>{
                         alert(d.valid);
                         $.removeCookie("loginID");
                         sh.service.login();
                     }
                   });
            }
         });
         
         ui.btn({
        	 clazz : 'joinConf',
        	 txt : '회원탈퇴',
             at : $mypageForm
         }).click(e=>{
        	 $.ajax({
                 url : sh.ctx()+'/member/'+$.cookie('loginID'),
                 method : 'delete',
                 success : d=>{
                     alert(d.valid);
                     $.removeCookie("loginID");
                     sh.home();
                 }
               });
         });
         
         $('#logoImg').click(e=>{
        	  e.preventDefault();
              sh.home();
              fn.scroll({ id : $("#banner"), len : 150});
         });
         
     },
     removeSec : x=>{
    	 let secs = ['#djSec','#albumSec','#foryouSec','#chartSec','#searchSec','#albumDetailSec'];
    	 let len = secs.length;
    	 for(let i=0;i<len;i++){
    		 //if(secs[i] !== x){
    			 $(secs[i]).remove();
    		 //}
    	 }
     },
     loginInfo : x=>{
    	 $.cookie("loginID",x.memberId);
         if($('input:checkbox[class=saveID]:checked').length == 1){
      	   $.cookie("saveID","t");
      	   $.cookie("savedID",x.memberId);
      	   $.cookie("savedPASS",x.pass);
         }else {
      	   $.cookie("saveID","f");
      	   $.removeCookie("savedID");
      	   $.removeCookie("savedPASS");
         }
     },
     auth : x=>{
		 let res = 0;
    	 $.ajax({
    		 url : sh.ctx()+'/member/auth',
	       	  method : 'get',
	       	  async: false,
	       	  error : m=>{
	       		alert('로그인이 필요한 서비스입니다.');
	       		res=1;
    			sh.service.login();
	       	  }
    	 });
   		 return res;
     }
     
};