"use strict";
var jt = jt || {};
jt ={
		search :z=>{ //앞에서 넘어온 map
		
			$.getJSON($.ctx()+'/service/search/'+z+'/'+$.cookie('loginID'),x=>{

  				let art = x.artist;
  				let $cnts = $('#contents');
  				$cnts.empty();
  				let $searchSec = $('<section/>').attr({ id : 'searchSec'});
  				$searchSec.appendTo($cnts);
  				$('<div/>').attr({id : 'jt_search'}).addClass('container').html(art.ARTIST_NAME+' 에 대한 검색결과').appendTo($searchSec);
  				
  				//서치 네비바
  				$('<div/>').attr({id : 'jt_nav-box'}).addClass('container').appendTo($searchSec);
  				$('<ul/>').attr({id : 'jt_nav'}).addClass('nav nav-tabs border-bottom-0').appendTo($('#jt_nav-box'));
  				
  				$('<li/>').attr({id : 'jt_artist'}).addClass('nav-item').appendTo($('#jt_nav'));
  				$('<a/>')
  				.attr({href : '#jt_search_artist'})
  				.addClass('nav-link ').html('아티스트')
  				.appendTo($('#jt_artist'))
  				.click(e=>{
  					$('#jt_artist').addClass('active');
  	                $('#jt_music').removeClass('active');
  	                $('#jt_album').removeClass('active');
  	                $('#jt_mv').removeClass('active');
  	                fn.scroll({ id : $("#jt_search_artist"), len : 150});
  					
  					
  				});
  				
  				
  				$('<li/>').attr({id : 'jt_music'}).addClass('nav-item').appendTo($('#jt_nav'));
  				$('<a/>')
  				.attr({href : '#jt_search_music'})
  				.addClass('nav-link ').html('곡')
  				.appendTo($('#jt_music'))
  				.click(e=>{
  					$('#jt_music').addClass('active');
  	                $('#jt_artist').removeClass('active');
  	                $('#jt_album').removeClass('active');
  	                $('#jt_mv').removeClass('active');
  	                fn.scroll({ id : $("#jt_search_music"), len : 100});
  					
  				})
  				
  				$('<li/>').attr({id : 'jt_album'}).addClass('nav-item').appendTo($('#jt_nav'));
  				$('<a/>')
  				.attr({href : '#jt_search_album'})
  				.addClass('nav-link ').html('앨범')
  				.appendTo($('#jt_album'))
  				.click(e=>{
  					$('#jt_album').addClass('active');
  	                $('#jt_artist').removeClass('active');
  	                $('#jt_music').removeClass('active');
  	                $('#jt_mv').removeClass('active');
  	                fn.scroll({ id : $("#jt_search_album"), len : 100});
  					
  					
  				})
  				
  				$('<li/>').attr({id : 'jt_mv'}).addClass('nav-item').appendTo($('#jt_nav'));
  				$('<a/>')
  				.attr({href : '#jt_search_mv'})
  				.addClass('nav-link ').html('영상')
  				.appendTo($('#jt_mv'))
  				.click(e=>{
  					$('#jt_mv').addClass('active');
  	                $('#jt_album').removeClass('active');
  	                $('#jt_artist').removeClass('active');
  	                $('#jt_music').removeClass('active');
  	                fn.scroll({ id : $("#jt_search_mv"), len : 100});
  					
  				})
  				
  				//페이지내용
  				$('<div/>').attr({id : 'jt_content'}).appendTo($searchSec);
  				
  				//아티스트
  				$('<div/>').attr({id : 'jt_search_artist'}).addClass('container').appendTo($('#jt_content'))
  				$('<h3/>').html('아티스트').appendTo($('#jt_search_artist'));
  				$('<hr/>').appendTo($('#jt_search_artist'));
  				$('<div/>').attr({id : 'jt_search_dt'}).addClass('media').appendTo($('#jt_search_artist'));
  				$('<img/>')
  				.attr({src : $.img()+'/artist/'+art.IMG_NAME+'.'+art.EXT,align : 'left',style:"margin-right:20px"})
  				.addClass('img-rounded')
  				.appendTo($('#jt_search_dt'));
  				$('<div/>').attr({id : 'jt_search_body'}).addClass('media-body').appendTo($('#jt_search_dt'));
  				$('<h4/>').html('아티스트 :'+art.ARTIST_NAME).appendTo($('#jt_search_body'));
  				$('<p/>').html('국적 : '+art.NATION).appendTo($('#jt_search_body'));
  				$('<p/>').html('성별 : '+art.SEX).appendTo($('#jt_search_body'));
  				$('<p/>').html('활동유형 : '+art.GROUP_NAME).appendTo($('#jt_search_body'));
  				$('<p/>').html('생년월일 : '+art.BIRTH).appendTo($('#jt_search_body'));
  				$('<p/>').html('데뷔 : '+art.DEBUT).appendTo($('#jt_search_body'));
  				$('<i/>').html('좋아요').addClass((art.TYPES=='u')?'active':'').attr({id:'jt_artUp'}).addClass('btn btn-brand fa fa-thumbs-up')
  				.click(function(e){
  					jt.updown({thiz:$(this), btn:'like', aSeq:art.ARTIST_SEQ})
  				}).appendTo($('#jt_search_body'));
  				$('<i/>').html('싫어요').addClass((art.TYPES=='d')?'active':'').attr({id:'jt_artDown'}).addClass('btn btn-brand fa fa-thumbs-down')
  				.click(function(e){
  					jt.updown({thiz:$(this), btn:'hate', aSeq:art.ARTIST_SEQ})
  				}).appendTo($('#jt_search_body'));
  				$('<hr/>').appendTo($('#jt_search_artist'));
  				
  				//아티스트 소개글
  	            $('<div/>').attr({id: 'jt_introduce_div'}).addClass('container').appendTo($('#jt_search_artist'));
  	            $('<h3/>').html('아티스트 소개').appendTo($('#jt_introduce_div'));
  	            $('<p/>').attr({id:'jt_artist_introduce'}).html(art.INTRO1).appendTo($('#jt_introduce_div'));
  	            
  	       
  	            $('<button/>').attr({
  	                'type':'button',
  	                'data-toggle':'collapse',
  	                'data-target' : '#jt_demo'
  	            }).addClass('btn btn-light')
  	            .append(
  	                    $('<span/>').addClass('glyphicon glyphicon-menu-down').html('펼치기')
  	            ).appendTo($('#jt_introduce_div'));
  	            $('<div/>').attr({id:'jt_demo','aria-expanded':"false"}).addClass('collapse').appendTo($('#jt_introduce_div'));
  	            $('<br/>').appendTo($('#jt_demo'));
  	            $('<p/>').html(art.INTRO2).appendTo($('#jt_demo'));
  	            $('<hr/>').appendTo($('#jt_introduce_div'));
  				
  				//곡 
  	           jt.music_list(x);
  	           
  				//앨범
  				$('<div/>').attr({id : 'jt_search_album'}).addClass('container').appendTo($('#jt_content'));
  				$('<h3/>').html('앨범'). appendTo($('#jt_search_album'));
  				$('<hr/>').appendTo($('#jt_search_album'));
  				$('<div/>').attr({id : 'jt_album_dt'}).addClass('row media').appendTo($('#jt_search_album'));
  					$.each(x.album,(i,j)=>{
  						$('<div/>').attr({id : j.ALBUM_SEQ}).addClass('col-md-3 jt_album_div').appendTo($('#jt_album_dt'));
  						$('<img/>')
  						.attr({id:'jt_album_img',src :  $.img()+'/album/'+j.IMG_NAME+'.'+j.EXT})
  						.addClass('img-rounded jt_album_detail')
  						.appendTo($('#'+j.ALBUM_SEQ));
  						$('<div/>').attr({id : 'jt_album_body'+i}).appendTo($('#'+j.ALBUM_SEQ));
  						$('<h3/>').html('['+j.ALBUM_TYPE+']').appendTo($('#jt_album_body'+i));
  						$('<p/>').addClass('font-weight-bold jt_album_detail')
  						.html(j.ALBUM_TITLE)
  						.attr({'style':'font-size:20px'})
  						.appendTo($('#jt_album_body'+i));
  						$('<p/>').addClass('text-justify').html(j.ARTIST_NAME).attr({'style':'font-size:15px'}).appendTo($('#jt_album_body'+i));
  						$('<p/>').addClass('text-justify').html(j.ALBUM_GENRE).attr({'style':'font-size:15px'}).appendTo($('#jt_album_body'+i));
  						$('<p/>').addClass('text-justify').html(j.AGENCY_NAME).attr({'style':'font-size:15px'}).appendTo($('#jt_album_body'+i));
  						$('<p/>').addClass('text-justify').html(j.RELEASE_DATE).attr({'style':'font-size:15px'}).appendTo($('#jt_album_body'+i));
  						$('<button/>').appendTo($('#jt_album_body'+i))
  						.addClass('btn btn-light')
  						.append(
  								$('<span/>').addClass('glyphicon glyphicon-play').html('앨범듣기')
  							).click(e=>{
  									jt.album_player(j.ALBUM_SEQ);
  							});
  						$('<br/>').appendTo($('#jt_album_body'+i));
  					})
  				$('<hr/>').appendTo($('#jt_search_album'));
  				
  				//앨범디테일 페이지 이동. 클래스로 접근.
  				$('.jt_album_detail').click(function(e){
  					let albumSeq = $(this).parents('div.jt_album_div').attr('id');
  					jt.album_detail(albumSeq);
  				
  				});
  				
  				//영상
  				$('<div/>').attr({id : 'jt_search_mv'}).addClass('container').appendTo($('#jt_content'));
  				$('<h3/>').html('영상').appendTo($('#jt_search_mv'));
  				$('<hr/>').appendTo($('#jt_search_mv'));
  				$('<ul/>').attr({id:'jt_mv_ul'}).addClass('list-unstyled').appendTo($('#jt_search_mv'));
  				for(var i=0; i<x.mv.length; i++){
  					$('<li/>').attr({id:'jt_mv_li'+i}).addClass('col-md-6').appendTo($('#jt_mv_ul'));
  					$('<iframe allowfullscreen>')
  					.attr({id:'jt_mv_iframe', src : x.mv[i].ytb, 'frameborder':'0',allow:'autoplay; encrypted-media'})
  					.appendTo($('#jt_mv_li'+i));
  					$('<div/>').attr({id:'jt_mv_div'+i}).appendTo($('#jt_mv_li'+i));
  					$('<h3/>').html('<뮤비>'+x.mv[i].MV_TITLE).addClass('mt-0').appendTo($('#jt_mv_div'+i));
  					$('<p/>').addClass('font-weight-bold').html('아티스트 : '+art.ARTIST_NAME).attr({'style':'font-size:15px'}).appendTo($('#jt_mv_div'+i));
  					$('<p/>').html('등록일 : '+x.mv[i].RELEASE_DATE).attr({'style':'font-size:15px'}).appendTo($('#jt_mv_div'+i));
  					$('<hr/>').appendTo($('#jt_mv_li'+i));
  					$('<br/>').appendTo($('#jt_mv_li'+i));	
  				}
  				
  			
			})
			 setTimeout(()=>{
				 fn.scroll({ id : $("#jt_search"), len : 400});
	         },300);
		},
		updown : x=>{ // jt.updown({thiz:$(this), btn:'like'||'hate', aSeq:ARTIST_SEQ})
			let $this = x.thiz;
			let url = (x.btn == 'like')
						?(($this.hasClass('active'))?'delAL':'putAL')
								:(($this.hasClass('active'))?'delAH':'putAH');
			if($.cookie("loginID") == 'sound') $.getJSON($.ctx()+'/foryou/'+url+'/'+x.aSeq,d=>{});
			jt.ud_active($this);
		},
		ud_active : x=>{
			if(x.hasClass('active')){
				x.removeClass('active');
			}else{
				x.addClass('active');
				if(x.siblings('i').hasClass('active')) x.siblings('i').removeClass('active');
			}
			
		},
		
		//곡 차트
		music_list : x=>{
			$('<div/>').attr({id:'jt_search_music'}).addClass('container').appendTo($('#jt_content'));
			$('<h3/>').html('곡').appendTo($('#jt_search_music'));
			$('<div/>')
			.attr({id:'jt_music_btn_toolbar','role':'toolbar'})
			.addClass('btn-toolbar')
			.appendTo($('#jt_search_music'));
			$('<div/>')
			.attr({id:'jt_music_btn_bar1','role':'group'})
			.addClass('btn-group mr-2')
			.appendTo($('#jt_music_btn_toolbar'));
			$('<button/>')
			.attr({'data-toggle':'modal','data-target':'#player'})
			.addClass('btn btn-light ')
			.append(
					$('<span/>').addClass('glyphicon glyphicon-play').html('전체듣기')
					
			).click(e=>{
				let music = '';
				let ckMusic = $('input:checkbox[name=chk]');
				$.each(ckMusic,(i,v)=>{
					music += v.value + ((i < ckMusic.length-1)?',':'');
				});
				jt.music_player(music);
				$('input[name = chk]:checkbox').prop('checked',false);
			}).appendTo($('#jt_music_btn_bar1'));
			
			$('<div/>')
			.attr({id:'jt_music_btn_bar2','role':'group'})
			.addClass('btn-group mr-2')
			.appendTo($('#jt_music_btn_toolbar'));
			$('<button/>')
			.addClass('btn btn-light')
			.append(
					$('<span/>').addClass('glyphicon glyphicon-play').html('선택듣기')
			).click(e=>{
				let music = '';
				let ckMusic = $('input:checkbox[name=chk]:checked');
				$.each(ckMusic,(i,v)=>{
					music += v.value + ((i < ckMusic.length-1)?',':'');
				});
				jt.music_player(music);
				$('input[name = chk]:checkbox').prop('checked',false);
			}).appendTo($('#jt_music_btn_bar2'));			
			$('<br>').appendTo($('#jt_search_music'));
			$('<table/>').addClass("jt_table table jt_table-filter").attr({id :'jt_music_tb'})
			.appendTo($('#jt_search_music'));
			$('<tbody/>').append(
			$('<tr/>').attr({id : 'jt_td_th'}).append(
				$('<td/>').addClass('jt_td_table1')
				.append(
					$('<th/>').attr('width','5%').addClass('jt_ckbox').append(
							$('<input/>').attr({type : 'checkbox', id :'allCheck',style:'width:15px'}),
									$('<label for="allCheck">')	
										)
								),
				   $('<th/>').addClass('jt_td_table2').html('NO'),
				   $('<th/>').addClass('jt_td_table3').html('곡명'),
				   $('<th/>').addClass('jt_td_table4').html('아티스트'),
				   $('<th/>').addClass('jt_td_table5').append(
						 $('<span/>').html('듣기'),
						 $('<span/>').html('하트'),
						 $('<span/>').html('영상'),
						 $('<span/>').html('싫어요')
      				)
		     )		
		).appendTo($('#jt_music_tb'));
				$.each(x.musics,(i,j)=>{
				$('<tr/>').append(
						$('<td/>').addClass('jt_td_table1').append(
								$('<div/>').addClass('jt_ckbox').append(
										$('<input/>').attr({type : 'checkbox', id :'checkbox'+i, name :'chk', value:j.MUSIC_SEQ}),
										$('<label for="checkbox'+i+'">') 
								)
							
						),
						$('<td/>').addClass('jt_td_table2').html(i+1),
						$('<td/>').addClass('jt_td_table3').html(j.MUSIC_TITLE),
						$('<td/>').addClass('jt_td_table4').html(j.ARTIST_NAME),
						$('<td/>').addClass('jt_td_table5').append(
									$('<i/>').addClass('btn btn-brand fa fa-play')
									.click(e=>{
										jt.music_player(j.MUSIC_SEQ);
									}),
									$('<i/>').addClass((j.TYPES == 'u')?'active':'').attr({id : 'jt_up'+i }).addClass('btn btn-brand fa fa-heart')
									.click(function(){
										if(sh.service.auth() == 0 ){
											sj.service.put_ud({thiz:$(this),btn:'like',mSeq:j.MUSIC_SEQ,gSeq:j.GENRE_SEQ});
										}
										
									}),
									$('<i/>').addClass('btn btn-brand glyphicon glyphicon-facetime-video'),
									$('<i/>').addClass((j.TYPES == 'd')?'active':'').attr({id : 'jt_down'+i }).addClass('btn btn-brand fa fa-thumbs-down')
									.click(function(){
										if(sh.service.auth() == 0 ){
											sj.service.put_ud({thiz:$(this),btn:'hate',mSeq:j.MUSIC_SEQ,gSeq:j.GENRE_SEQ});
										}
									})
								
								)
						).appendTo($('.jt_table'));

				});
			
			//전체선택 클릭시
			$('#allCheck').click(()=>{
				if($("#allCheck").is(':checked')){
					$('input[name = chk]:checkbox').prop('checked',true);
				}else{
					$('input[name = chk]:checkbox').prop('checked',false);
				}
			});
		},
		
		//앨범디테일 페이지
		album_detail : z=>{
			$.getJSON($.ctx()+'/detailPg/detail/'+z+'/'+$.cookie('loginID'),x=>{
				let $cnts = $('#contents');
				$cnts.empty();
				let $albumDetailSec = $('<section/>').attr({ id : 'albumDetailSec'});
				$albumDetailSec.appendTo($cnts);
				$('<div/>').attr({id : 'jt_album_dtpage'}).addClass('container').appendTo($albumDetailSec);
				$('<div/>').attr({id : 'jt_content'}).appendTo($('#jt_album_dtpage'));
				$('<h3/>').html('앨범정보').appendTo($('#jt_content'));
				$('<div/>').attr({id : 'jt_album_div'}).addClass('container').appendTo($('#jt_content'));
				$('<hr/>').appendTo($('#jt_album_div'));
				$('<div/>').attr({id : 'jt_album_dt'}).addClass('media').appendTo($('#jt_album_div'));
				$('<img/>')
				.attr({src : $.img()+'/album/'+x.album.IMGNAME+'.'+x.album.EXT, align : 'left',style:"margin-right:10px"})
				.addClass('img-rounded')
				.appendTo($('#jt_album_dt'));
				$('<div/>').attr({id : 'jt_album_body'}).addClass('media-body').appendTo($('#jt_album_dt'));
				$('<h4/>').html('['+x.album.ALBUMTYPE+']').appendTo($('#jt_album_body'));
				$('<p/>').html('앨범명 : '+x.album.ALBUMTITLE).attr({'style':'font-size:20px'}).addClass('font-weight-bold').appendTo($('#jt_album_body'));
				$('<p/>').html('가수명 : '+x.album.ARTISTNAME).attr({'style':'font-size:15px'}).appendTo($('#jt_album_body'));
				$('<p/>').html('발매일 : '+x.album.RELEASEDATE).appendTo($('#jt_album_body'));
				$('<p/>').html('장르 :' +x.album.ALBUMGENRE).appendTo($('#jt_album_body'));
				$('<hr/>').appendTo($('#jt_album_div'));
				
				//앨범소개
				$('<div/>').attr({id: 'jt_introduce_album'}).addClass('container').appendTo($('#jt_content'));
				$('<h3/>').html('앨범소개').appendTo($('#jt_introduce_album'));
				$('<br/>').appendTo($('#jt_introduce_album'));
				$('<button/>').attr({
					'type':'button',
					'data-toggle':'collapse',
					'data-target' : '#jt_album_demo'
				}).addClass('btn btn-light')
				.append(
						$('<span/>').addClass('glyphicon glyphicon-menu-down').html('펼치기')
				).appendTo($('#jt_introduce_album'));
				
				$('<div/>').attr({id:'jt_album_demo','aria-expanded':"false"}).addClass('collapse').appendTo($('#jt_introduce_album'));
				$('<br/>').appendTo($('#jt_album_demo'));
				$('<p/>').html(x.album.INTRO).appendTo($('#jt_album_demo'));
				$('<hr/>').appendTo($('#jt_introduce_album'));
				
				//곡
				$('<div/>').attr({id:'jt_search_music'}).addClass('container').appendTo($('#jt_content'));
				$('<h3/>').html('곡').appendTo($('#jt_search_music'));
				$('<div/>')
				.attr({id:'jt_music_btn_toolbar','role':'toolbar'})
				.addClass('btn-toolbar')
				.appendTo($('#jt_search_music'));
				$('<div/>')
				.attr({id:'jt_music_btn_bar1','role':'group'})
				.addClass('btn-group mr-2')
				.appendTo($('#jt_music_btn_toolbar'));
				$('<button/>')
				.attr({'data-toggle':'modal','data-target':'#player'})
				.addClass('btn btn-light ')
				.append(
						$('<span/>').addClass('glyphicon glyphicon-play').html('전체듣기')
						
				).click(e=>{
					let music = '';
					let ckMusic = $('input:checkbox[name=chk]');
					$.each(ckMusic,(i,v)=>{
						music += v.value + ((i < ckMusic.length-1)?',':'');
					});
						jt.music_player(music);
						$('input[name = chk]:checkbox').prop('checked',false);
				}).appendTo($('#jt_music_btn_bar1'));
				
				$('<div/>')
				.attr({id:'jt_music_btn_bar2','role':'group'})
				.addClass('btn-group mr-2')
				.appendTo($('#jt_music_btn_toolbar'));
				$('<button/>')
				.addClass('btn btn-light')
				.append(
						$('<span/>').addClass('glyphicon glyphicon-play').html('선택듣기')
				).click(e=>{
					let music = '';
					let ckMusic = $('input:checkbox[name=chk]:checked');
					$.each(ckMusic,(i,v)=>{
						music += v.value + ((i < ckMusic.length-1)?',':'');
					});
						jt.music_player(music);
						$('input[name = chk]:checkbox').prop('checked',false);
				}).appendTo($('#jt_music_btn_bar2'));			
				$('<br>').appendTo($('#jt_search_music'));
				
				$('<table/>').addClass("jt_table table jt_table-filter").attr({id :'jt_music_tb'})
				.appendTo($('#jt_search_music'));
				$('<tbody/>').append(
				$('<tr/>').attr({id : 'jt_td_th'}).append(
				$('<td/>').append(
					$('<th/>').addClass('jt_td_table1').addClass('jt_ckbox').append(
							$('<input/>').attr({type : 'checkbox', id :'allCheck',style:'width:15px'}),
									$('<label for="allCheck">')	
										)
								),
				$('<th/>').addClass('jt_td_table2').html('NO'),
				$('<th/>').addClass('jt_td_table3').html('곡명'),
				$('<th/>').addClass('jt_td_table4').html('아티스트'),
				$('<th/>').addClass('jt_td_table5').append(
									$('<span/>').html('듣기'),
									$('<span/>').html('하트'),
									$('<span/>').html('영상'),
									$('<span/>').html('싫어요')
							)
			     )		
			).appendTo($('#jt_music_tb'));
				$.each(x.musics,(i,j)=>{
					$('<tr/>').append(
							$('<td/>').addClass('jt_td_table1').append(
									$('<div/>').addClass('jt_ckbox').append(
											$('<input/>').attr({type : 'checkbox', id :'checkbox'+i, name :'chk', value:j.MUSIC_SEQ}),
											$('<label for="checkbox'+i+'">') 
									)
							),
							$('<td/>').addClass('jt_td_table2').html(i+1),
							$('<td/>').addClass('jt_td_table3').html(j.MUSIC_TITLE),
							$('<td/>').addClass('jt_td_table4').html(j.ARTIST_NAME),
							$('<td/>').addClass('jt_td_table5').append(
									$('<i/>').addClass('btn btn-brand fa fa-play')
									.click(e=>{
										jt.music_player(j.MUSIC_SEQ);
									}),
									$('<i/>').addClass((j.TYPES == 'u')?'active':'').attr({id : 'jt_up'+i }).addClass('btn btn-brand fa fa-heart')
									.click(function(){
										if(sh.service.auth() == 0 ){
											sj.service.put_ud({thiz:$(this),btn:'like',mSeq:j.MUSIC_SEQ,gSeq:j.GENRE_SEQ});
										}
									}),
									$('<i/>').addClass('btn btn-brand glyphicon glyphicon-facetime-video'),
									$('<i/>').addClass((j.TYPES == 'd')?'active':'').attr({id : 'jt_down'+i }).addClass('btn btn-brand fa fa-thumbs-down')
									.click(function(){
										if(sh.service.auth() == 0 ){
											sj.service.put_ud({thiz:$(this),btn:'hate',mSeq:j.MUSIC_SEQ,gSeq:j.GENRE_SEQ});
										}
									})
								)
					).appendTo($('.jt_table'));
				});
				
				//전체선택 클릭시
				$('#allCheck').click(()=>{
					if($("#allCheck").is(':checked')){
						$('input[name = chk]:checkbox').prop('checked',true);
					}else{
						$('input[name = chk]:checkbox').prop('checked',false);
					}
				});
				jt.album_write(x);
				setTimeout(()=>{
					fn.scroll({ id : $('#jt_album_dtpage'), len : 200});
		        },300);
			});
		},
		
		//댓글쓰기
		album_write : x=>{
					$('<div/>').attr({id: 'jt_cmt'}).addClass('container').appendTo($('#jt_content'));
					$('<h3/>').html('댓글').appendTo($('#jt_cmt'));
					$('<hr/>').appendTo($('#jt_cmt'));
					$('<div/>').attr({id: 'jt_cmt_profile'}).addClass('col-md-2').appendTo($('#jt_cmt'));
					$('<img/>')
					.attr({src :  $.ctx()+'/resources/img/user_1.jpg', align : 'left'})
					.addClass('jt_cmt_user')
					.appendTo($('#jt_cmt_profile'));
					$('<div/>').attr({id:'jt_cmt_body'}).addClass('col-md-8').appendTo($('#jt_cmt'));
					$('<textarea/>')
					.attr({id:'msg',rows:"6",cols:"105",placeholder:"내용을 입력해주세요"})
					.addClass('msg')
					.appendTo($('#jt_cmt_body'))
					.click(e=>{
						sh.service.auth();
					});
					$('<div/>').attr({id:'jt_cmt_btn_div'}).addClass('col-md-2').appendTo($('#jt_cmt'));
					$('<button/>')
					.attr({id:'jt_cmt_btn','type':'button'})
					.addClass('btn btn-light btn-lg').html('등록')
					.appendTo($('#jt_cmt_btn_div'))
					.click(e=>{
						$.ajax({
							url:$.ctx()+'/detailPg/write',
							method:'post',
							contentType:'application/json',
							data:JSON.stringify({
								memberId : $.cookie('loginID'),
								seqGroup : x.album.ALBUMSEQ,
								msg : $('#msg').val()
							}),
							success : d=>{
								$('.msg').val('');
								$('#jt_cmt_counts').text('총 댓글수 :'+x.rowCount+1);
								jt.album_read({id:d.seqGroup,pageNo:1,rowCount:x.rowCount+1});
							
							},
							error:(m1,m2,m3)=>{alert(m3);}
						})
					});
					$('<br/>').appendTo($('#jt_content'));
					jt.album_read({id:x.album.ALBUMSEQ, pageNo:1, rowCount:x.rowCount});
		},

		//댓글읽기
		album_read: x=>{
			$('.jt_cmt_count').remove();
			$('.jt_album_row').remove();
			$('.pagination').remove();
			$('<div/>').addClass('jt_cmt_count container').appendTo($('#jt_content'));
			$('<div/>').attr({id:'jt_cmt_div'}).appendTo('.jt_cmt_count');
			$('<span/>').attr({id:'jt_cmt_counts','style':'font-size:15px'})
			.text('총 댓글수 :'+x.rowCount).appendTo($('#jt_cmt_div'));
			$.getJSON($.ctx()+'/detailPg/list/'+x.id+'/'+x.pageNo,d=>{
		                $('<div/>').addClass('row jt_album_row').append(
		                    $('<div/>').addClass('col-md-12').append(
		                            $('<div/>').addClass('blog-comment').attr({id : 'jt_blog-comment'})
		                    
		                    )    
		                ).appendTo($('#jt_content'))
			            for(let i=0 ; i<d.list.length; i++){
			                $('<div/>').addClass('clearfix').append(
			                         $('<img/>').attr({src : $.ctx()+'/resources/img/user_1.jpg'})
			                         .addClass('avatar'),
			                         $('<div/>').attr({id:'jt_post_commets'}).addClass('post-comments').append(
			                                 $('<p>').addClass('meta').html('날짜:'+d.list[i].REGI_DATE).attr({'style':'font-size:15px'}),
			                                 $('<small>').html('ID:' +d.list[i].MEMBER_ID).attr({'style':'font-size:15px'}),
			                                 $('<br/>'),
			                                 $('<p>').addClass('meta').html(d.list[i].MSG).attr({'style':'font-size:20px'})
			                         )
			                    ).appendTo($('#jt_blog-comment'))
			                
			            }
					(ui.page()).appendTo($('#jt_content'));
					let ul = $('.pagination');
					
					for(let i=d.page.beginPage ; i<=d.page.endPage ; i++){
						let ac=(i==d.page.pageNumber)? "active" : ""; 
						$('<li />').addClass("page-item "+ac)
						.append($('<a/>').attr({id:'jt_pagelink'}).addClass("page-link").html(i))
						.appendTo(ul).click(e=>{
							e.preventDefault();
							jt.album_read({id:d.seqGroup , pageNo:i, rowCount :x.rowCount});
						});
					}
					let disp = (d.page.existPrev)? "": "disabled" ;
					let disn = (d.page.existNext)? "": "disabled" ;
					$('<li id="epo" />').addClass("page-item "+disp).append($("<span />").addClass("page-link").html("◀")).prependTo(ul);
					$('<li id="eno" />').addClass("page-item "+disn).append($("<span />").addClass("page-link").html("▶")).appendTo(ul);
					if(d.page.existPrev){$('#epo').click(e=>
							{	
								jt.album_read({id:d.seqGroup , pageNo:parseInt(d.page.beginPage-1),rowCount :x.rowCount});});}
					if(d.page.existNext){$('#eno').click(e=>
							{	
								jt.album_read({id:d.seqGroup , pageNo:parseInt(d.page.endPage+1),rowCount :x.rowCount});});}
				})
				
		},
		// 뮤직 플레이어
		music_player : x=>{
			let memberId = 'shin';
			if($.cookie('loginID') != null){
				memberId = $.cookie('loginID');
			}
			$.getJSON($.ctx()+'/service/player/music/'+x+'/'+memberId,d=>{
				let openWin = window.open(sh.ctx()+'/#SoundLAB_Player',"soundlab","left="+(screen.availWidth-730)/2+",top="+(screen.availHeight-495)/2+","+"width=730,height=495, menubar=no");
				let player = $(openWin.document.getElementById('wrapper')).length;
				if(player == 0){
					openWin.onload =(()=>{
		            	setTimeout(x=>{
		                    let sonWrap = $(openWin.document.getElementById('wrapper'));
		                    sonWrap.empty();
		                    	$('<div/>').attr({id:'jt_playerdt'}).addClass('nowPlaying').appendTo(sonWrap);
		                    	$('<div/>').attr({id:'jt_player'}).appendTo(openWin.document.getElementById('jt_playerdt'));
		                    	$('<div/>').attr({id:'jt_info'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<img/>')
		                    	.attr({id:'jt_logo_img', src:$.img()+'/logo_admin.png'})
		                    	.appendTo(openWin.document.getElementById('jt_info'));
		                    	
		                    	$('<div/>').attr({id:'jt_album_area'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<div/>').attr({id:'jt_album_imgDiv'}).appendTo(openWin.document.getElementById('jt_album_area'));
		                    	for(var i=0; i<d.musics.length;i++){
		                    	$('<iframe allowfullscreen>')
		        				.attr({id:'jt_music_iframe', src : d.musics[i].MUSIC_ADDR, 'frameborder':'0',allow:'autoplay; encrypted-media'})
		        				.appendTo(openWin.document.getElementById('jt_album_imgDiv'));
		                    	}
		                    	$('<div/>').attr({id:'jt_progressControl'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<span/>').attr({id:'jt_timeStart'}).html('00:00').appendTo(openWin.document.getElementById('jt_progressControl'));
		                    	$('<span/>').attr({id:'jt_timeEnd'}).html('04:26').appendTo(openWin.document.getElementById('jt_progressControl'));
		                    	$('<div/>')
		                    	.attr({id:'jt_progressBar'})
		                    	.addClass('progressBar')
		                    	.appendTo(openWin.document.getElementById('jt_progressControl'));
		                    	$('<a/>').attr({id:'jt_a',href:'#'}).appendTo(openWin.document.getElementById('jt_progressBar'));
		                    	$('<span/>').attr({id:'jt_timeBar'}).appendTo(openWin.document.getElementById('jt_a'));
		                    	$('<span/>').attr({id:'jt_timeBarBuffer'}).appendTo(openWin.document.getElementById('jt_timeBar'));
		                    	$('<span/>').attr({id:'jt_timeBarOn'}).appendTo(openWin.document.getElementById('jt_timeBar'));
		                    	$('<span/>').attr({id:'jt_timeSwitch'}).appendTo(openWin.document.getElementById('jt_timeBarOn'));
		                    	$('<div/>').attr({id:'jt_playControl'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<span/>').attr({id:'tooglePlay'}).addClass('btnPlayArea').appendTo(openWin.document.getElementById('jt_playControl'));
		                    	$('<button/>')
		                    	.attr({id:'jt_btnPlay', type:'button' ,title:'재생'})
		                    	.addClass('btnPlay fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-play')	
		                    	)
		                    	.appendTo(openWin.document.getElementById('tooglePlay'));
		                    	$('<button/>')
		                    	.attr({id:'jt_btnPrev',type:'button',title:'이전곡'})
		                    	.addClass('btnPrev fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-fast-backward')
		                    	).appendTo(openWin.document.getElementById('jt_playControl'));
		                    	
		                    	$('<button/>')
		                    	.attr({id:'jt_btnNext',type:'button',title:'다음곡'})
		                    	.addClass('btnNext fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-fast-forward')
		                    	).appendTo(openWin.document.getElementById('jt_playControl'));
		                    	
		                    	$('<span/>').attr({id:'jt_btnRepeatArea'}).appendTo(openWin.document.getElementById('jt_playControl'));
		                    	$('<button/>')
		                    	.attr({id:'jt_btnRepeat',type:'button',title:'반복재생'})
		                    	.addClass('btnRepeat fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-refresh')
		                    	).appendTo(openWin.document.getElementById('jt_btnRepeatArea'));
		                    	$('<div/>')
		                    	.attr({id:'jt_btnVolume'})
		                    	.addClass('slidecontainer')
		                    	.appendTo(openWin.document.getElementById('jt_playControl'));
		                    	$('<a/>').attr({id:'jt_volume',href:'#', title:'볼륨 조절 버튼'})
		                    	.addClass('volume glyphicon glyphicon-volume-up').appendTo(openWin.document.getElementById('jt_btnVolume'));
		                    	$('<input/>')
		                    	.attr({id:'jt_volumebar', type:'range','min':'0','max':'100'
		                    	}).appendTo(openWin.document.getElementById('jt_btnVolume'));
		                    	
		                    	//오른쪽
		                    	let musicCnt = d.musics.length;
		                    	$('<div/>').attr({id:'jt_playerOption'}).addClass('jt_playerOption').appendTo(openWin.document.getElementById('jt_playerdt'));
		                    	$('<ul/>').attr({id:'jt_tabControl'}).addClass('jt_tabControl').appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<li/>').attr({id:'jt_selected'}).addClass('selected').appendTo(openWin.document.getElementById('jt_tabControl'));
		                    	$('<a/>').attr({id:'jt_play_list', herf:'#'}).addClass('jt_play_list').html('재생목록').appendTo(openWin.document.getElementById('jt_selected'));
			                   	$('<li/>').attr({id:'jt_delete'}).appendTo(openWin.document.getElementById('jt_tabControl'));
			                   	$('<a/>')
		                    	.attr({id:'jt_playBtnArea'}).addClass('playBtnArea jt_playckbox').appendTo(openWin.document.getElementById('jt_delete'));
		                    	$('<input/>').attr({type : 'checkbox', id :'play_allCheck' }).appendTo(openWin.document.getElementById('jt_playBtnArea'))
		                    	.click(function(e){
		                    		let $this = $(this);
		                    		if($this.is(':checked')){
		                    			$(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox').prop('checked',true);
		                    		}else{
		                    			$(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox').prop('checked',false);
		                    		}
		                    	});
		                        $('<label for="play_allCheck">').appendTo(openWin.document.getElementById('jt_playBtnArea'));
		                    	$('<a/>').addClass('delete_msg').html('삭제')
		                    	.click(e=>{
		                    		let delLen = $(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox:checked').parents('.jt_mplay_li').length;
		                    		$(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox:checked').parents('.jt_mplay_li').remove();
		                    			let mplay_li = $(openWin.document).find('#jt_playerdt .jt_mplay_li');
		                    			let itemcheck = $(openWin.document).find('#jt_playerdt .itemcheck');
		                    			let itemcheck_chbox = $(openWin.document).find('#jt_playerdt .jt_pp');
		                    			let player_checkbox_label = $(openWin.document).find('#jt_playerdt .player_checkbox_label');
		                    			
		                    			let jt_itemrank = $(openWin.document).find('#jt_playerdt .jt_itemrank');
		                    		    let num = $(openWin.document).find('#jt_playerdt .jt_rank');
		                    		    
		                    		    let jt_itemtitle_div = $(openWin.document).find('#jt_playerdt .jt_itemtitle_div');
		                    		    let jt_itemdt = $(openWin.document).find('#jt_playerdt .jt_itemdt');
		                    		    let jt_titgroup = $(openWin.document).find('#jt_playerdt .jt_titgroup');
		                    		    let jt_titsong = $(openWin.document).find('#jt_playerdt .jt_titsong');
		                    		    let jt_itemem = $(openWin.document).find('#jt_playerdt .jt_itemem');
		                    		    let _jt_artist = $(openWin.document).find('#jt_playerdt ._jt_artist');
		                    	
		                    			for(let i=0;i<num.length;i++){
		                    				mplay_li[i].id = 'jt_mplay_li'+i;
		                    				itemcheck[i].id ='jt_itemcheck'+ i;
		                    				itemcheck_chbox[i].id ='checkbox'+ i;
		                    				$(player_checkbox_label[i]).attr({'for':itemcheck_chbox[i].id});
		                    				
		                    				jt_itemrank[i].id ='jt_itemrank'+ i;
		                    				num[i].id ='jt_rank'+ i;
		                    				num[i].innerHTML = i+1;

		                    				jt_itemtitle_div[i].id ='jt_itemtitle_div'+ i;
		                    				jt_itemdt[i].id ='jt_itemdt'+ i;
		                    				jt_titgroup[i].id ='jt_titgroup'+ i;
		                    				jt_titsong[i].id ='jt_titsong'+ i;
		                    				jt_itemem[i].id ='jt_itemem'+ i;
		                    				_jt_artist[i].id ='jt_artist'+ i;

		                    			}
		                    		musicCnt = $(openWin.document.getElementById('musicCnt')).html() - delLen;
		                    		$(openWin.document.getElementById('musicCnt')).html(musicCnt);
		                    		}).appendTo(openWin.document.getElementById('jt_playBtnArea'));
		                    	  $(openWin.document.getElementById('play_allCheck')).click(e=>{
		          					if($(openWin.document.getElementById('play_allCheck')).is(':checked')){
		          						$('input[name=play_chk]:checkbox').prop('checked',true);
		          					}else{
		          						$('input[name=play_chk]:checkbox').prop('checked',false);
		          					}
		          				});
		                    	$('<span/>').addClass('jt_musicCnt').html('No.').appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<span/>').attr({id:'musicCnt'}).html(musicCnt).appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<div/>').attr({id:'jt_tab_area'}).appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<div/>')
		                    	.attr({id:'jt_mplay_list','style':'position:relative','overflow':'hidden'})
		                    	.addClass('jt_mplay_list')
		                    	.appendTo(openWin.document.getElementById('jt_tab_area'));
		                    	$('<ul>').attr({id:'jt_mplay_ul'}).addClass('jt_mplay_ul').appendTo(openWin.document.getElementById('jt_mplay_list'));
		                    	
		                    	for(var i=0; i<musicCnt;i++){
		                    		$('<li/>').attr({id:'jt_mplay_li'+i}).addClass('jt_mplay_li').appendTo(openWin.document.getElementById('jt_mplay_ul'));
		                        	$('<em/>').attr({id:'jt_itemcheck'+i}).addClass('itemcheck jt_playckbox').appendTo(openWin.document.getElementById('jt_mplay_li'+i));
		                        	$('<input/>').attr({type : 'checkbox', id :'checkbox'+i, name :'play_chk'}).addClass('jt_pp').appendTo(openWin.document.getElementById('jt_itemcheck'+i));
		                        	$('<label for="checkbox'+i+'">').addClass('player_checkbox_label').appendTo(openWin.document.getElementById('jt_itemcheck'+i));
		                        	$('<em/>').attr({id:'jt_itemrank'+i}).addClass('jt_itemrank').appendTo(openWin.document.getElementById('jt_mplay_li'+i));
		                        	$('<span/>').attr({id:'jt_rank'+i}).addClass('rank jt_rank').html(i+1).appendTo(openWin.document.getElementById('jt_itemrank'+i));
		                        	$('<div/>').attr({id:'jt_itemtitle_div'+i}).addClass('jt_itemtitle_div').appendTo(openWin.document.getElementById('jt_mplay_li'+i));
		                        	$('<div/>').attr({id:'jt_itemdt'+i}).addClass('jt_itemdt').appendTo(openWin.document.getElementById('jt_itemtitle_div'+i));
		                        	$('<span/>').attr({id:'jt_titgroup'+i}).addClass('jt_titgroup').appendTo(openWin.document.getElementById('jt_itemdt'+i));
		                        	$('<a/>').attr({id:'jt_titsong'+i}).addClass('jt_titsong').html(d.musics[i].MUSIC_TITLE).appendTo(openWin.document.getElementById('jt_titgroup'+i));

		                        	$('<em/>').attr({id:'jt_itemem'+i}).addClass('jt_itemem').html('|').appendTo(openWin.document.getElementById('jt_itemdt'+i));
		                        	$('<span/>').attr({id:'jt_artist'+i}).addClass('_jt_artist').html(d.musics[i].ARTIST_NAME).appendTo(openWin.document.getElementById('jt_itemdt'+i));
		                        	
		                    	}

		                },110);
		            });
				}else {
					let cnt =$(openWin.document.getElementById('musicCnt')).html()*1;
                	for(var i=0; i<d.musics.length;i++){
                		$('<li/>').attr({id:'jt_mplay_li'+cnt}).addClass('jt_mplay_li').appendTo(openWin.document.getElementById('jt_mplay_ul'));
                    	$('<em/>').attr({id:'jt_itemcheck'+cnt}).addClass('itemcheck jt_playckbox').appendTo(openWin.document.getElementById('jt_mplay_li'+cnt));
                    	$('<input/>').attr({type : 'checkbox', id :'checkbox'+cnt, name :'play_chk'}).addClass('jt_pp').appendTo(openWin.document.getElementById('jt_itemcheck'+cnt));
                    	$('<label for="checkbox'+cnt+'">').addClass('player_checkbox_label').appendTo(openWin.document.getElementById('jt_itemcheck'+cnt));
                    	$('<em/>').attr({id:'jt_itemrank'+cnt}).addClass('jt_itemrank').appendTo(openWin.document.getElementById('jt_mplay_li'+cnt));
                    	$('<span/>').attr({id:'jt_rank'+cnt}).addClass('rank jt_rank').html(cnt+1).appendTo(openWin.document.getElementById('jt_itemrank'+cnt));
                    	$('<div/>').attr({id:'jt_itemtitle_div'+cnt}).addClass('jt_itemtitle_div').appendTo(openWin.document.getElementById('jt_mplay_li'+cnt));
                    	$('<div/>').attr({id:'jt_itemdt'+cnt}).addClass('jt_itemdt').appendTo(openWin.document.getElementById('jt_itemtitle_div'+cnt));
                    	$('<span/>').attr({id:'jt_titgroup'+cnt}).addClass('jt_titgroup').appendTo(openWin.document.getElementById('jt_itemdt'+cnt));
                    	$('<a/>').attr({id:'jt_titsong'+cnt}).addClass('jt_titsong').html(d.musics[i].MUSIC_TITLE).appendTo(openWin.document.getElementById('jt_titgroup'+cnt));
                    	$('<em/>').attr({id:'jt_itemem'+cnt}).addClass('jt_itemem').html('|').appendTo(openWin.document.getElementById('jt_itemdt'+cnt));
                    	$('<span/>').attr({id:'jt_artist'+cnt}).addClass('_jt_artist').html(d.musics[i].ARTIST_NAME).appendTo(openWin.document.getElementById('jt_itemdt'+cnt));
                    	cnt++;
                	}
                	$(openWin.document.getElementById('musicCnt')).html(cnt);
				}
				
	          
			})
	
		},
		//앨범 플레이어
		album_player : x=>{
			let memberId = 'shin';
			if($.cookie('loginID') != null){
				memberId = $.cookie('loginID');
			}
			$.getJSON($.ctx()+'/service/player/album/'+x+'/'+memberId,d=>{
				let openWin = window.open(sh.ctx()+'/#SoundLAB_Player',"soundlab","left="+(screen.availWidth-730)/2+",top="+(screen.availHeight-495)/2+","+"width=730,height=495, menubar=no");
				let player = $(openWin.document.getElementById('wrapper')).length;
				if(player == 0){
					openWin.onload =(()=>{
		            	setTimeout(x=>{
		                    let sonWrap = $(openWin.document.getElementById('wrapper'));
		                    sonWrap.empty();
		                    	$('<div/>').attr({id:'jt_playerdt'}).addClass('nowPlaying').appendTo(sonWrap);
		                    	$('<div/>').attr({id:'jt_player'}).appendTo(openWin.document.getElementById('jt_playerdt'));
		                    	$('<div/>').attr({id:'jt_info'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<img/>')
		                    	.attr({id:'jt_logo_img', src:$.img()+'/logo_admin.png'})
		                    	.appendTo(openWin.document.getElementById('jt_info'));
		                    	
		                    	$('<div/>').attr({id:'jt_album_area'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<div/>').attr({id:'jt_album_imgDiv'}).appendTo(openWin.document.getElementById('jt_album_area'));
		                    	for(var i=0; i<d.albums.length;i++){
		                    	$('<iframe allowfullscreen>')
		        				.attr({id:'jt_music_iframe', src : d.albums[i].MUSIC_ADDR, 'frameborder':'0',allow:'autoplay; encrypted-media'})
		        				.appendTo(openWin.document.getElementById('jt_album_imgDiv'));
		                    	}
		                    	$('<div/>').attr({id:'jt_progressControl'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<span/>').attr({id:'jt_timeStart'}).html('00:00').appendTo(openWin.document.getElementById('jt_progressControl'));
		                    	$('<span/>').attr({id:'jt_timeEnd'}).html('04:26').appendTo(openWin.document.getElementById('jt_progressControl'));
		                    	$('<div/>')
		                    	.attr({id:'jt_progressBar'})
		                    	.addClass('progressBar')
		                    	.appendTo(openWin.document.getElementById('jt_progressControl'));
		                    	$('<a/>').attr({id:'jt_a',href:'#'}).appendTo(openWin.document.getElementById('jt_progressBar'));
		                    	$('<span/>').attr({id:'jt_timeBar'}).appendTo(openWin.document.getElementById('jt_a'));
		                    	$('<span/>').attr({id:'jt_timeBarBuffer'}).appendTo(openWin.document.getElementById('jt_timeBar'));
		                    	$('<span/>').attr({id:'jt_timeBarOn'}).appendTo(openWin.document.getElementById('jt_timeBar'));
		                    	$('<span/>').attr({id:'jt_timeSwitch'}).appendTo(openWin.document.getElementById('jt_timeBarOn'));
		                    	$('<div/>').attr({id:'jt_playControl'}).appendTo(openWin.document.getElementById('jt_player'));
		                    	$('<span/>').attr({id:'tooglePlay'}).addClass('btnPlayArea').appendTo(openWin.document.getElementById('jt_playControl'));
		                    	$('<button/>')
		                    	.attr({id:'jt_btnPlay', type:'button' ,title:'재생'})
		                    	.addClass('btnPlay fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-play')	
		                    	)
		                    	.appendTo(openWin.document.getElementById('tooglePlay'));
		                    	
		                    	$('<button/>')
		                    	.attr({id:'jt_btnPrev',type:'button',title:'이전곡'})
		                    	.addClass('btnPrev fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-fast-backward')
		                    	).appendTo(openWin.document.getElementById('jt_playControl'));
		                    	
		                    	$('<button/>')
		                    	.attr({id:'jt_btnNext',type:'button',title:'다음곡'})
		                    	.addClass('btnNext fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-fast-forward')
		                    	).appendTo(openWin.document.getElementById('jt_playControl'));
		                    	
		                    	$('<span/>').attr({id:'jt_btnRepeatArea'}).appendTo(openWin.document.getElementById('jt_playControl'));
		                    	$('<button/>')
		                    	.attr({id:'jt_btnRepeat',type:'button',title:'반복재생'})
		                    	.addClass('btnRepeat fun-btn')
		                    	.append(
		                    			$('<span/>').addClass('glyphicon glyphicon-refresh')
		                    	).appendTo(openWin.document.getElementById('jt_btnRepeatArea'));
		                    	$('<div/>')
		                    	.attr({id:'jt_btnVolume'})
		                    	.addClass('slidecontainer')
		                    	.appendTo(openWin.document.getElementById('jt_playControl'));
		                    	$('<a/>').attr({id:'jt_volume',href:'#', title:'볼륨 조절 버튼'})
		                    	.addClass('volume glyphicon glyphicon-volume-up').appendTo(openWin.document.getElementById('jt_btnVolume'));
		                    	$('<input/>')
		                    	.attr({id:'jt_volumebar', type:'range','min':'0','max':'100'
		                    	}).appendTo(openWin.document.getElementById('jt_btnVolume'));
		                    	
		                    	//오른쪽
		                    	let musicCnt = d.albums.length;
		                    	$('<div/>').attr({id:'jt_playerOption'}).addClass('jt_playerOption').appendTo(openWin.document.getElementById('jt_playerdt'));
		                    	$('<ul/>').attr({id:'jt_tabControl'}).addClass('jt_tabControl').appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<li/>').attr({id:'jt_selected'}).addClass('selected').appendTo(openWin.document.getElementById('jt_tabControl'));
		                    	$('<a/>').attr({id:'jt_play_list', herf:'#'}).addClass('jt_play_list').html('재생목록').appendTo(openWin.document.getElementById('jt_selected'));
			                   	$('<li/>').attr({id:'jt_delete'}).appendTo(openWin.document.getElementById('jt_tabControl'));
			                   	$('<a/>')
		                    	.attr({id:'jt_playBtnArea'}).addClass('playBtnArea jt_playckbox').appendTo(openWin.document.getElementById('jt_delete'));
		                    	$('<input/>').attr({type : 'checkbox', id :'play_allCheck' }).appendTo(openWin.document.getElementById('jt_playBtnArea'))
		                    	.click(function(e){
		                    		let $this = $(this);
		                    		if($this.is(':checked')){
		                    			$(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox').prop('checked',true);
		                    		}else{
		                    			$(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox').prop('checked',false);
		                    		}
		                    	});
		                        $('<label for="play_allCheck">').appendTo(openWin.document.getElementById('jt_playBtnArea'));
                    			
		                        $('<a/>').addClass('delete_msg').html('삭제')
		                    	.click(e=>{
		                    		let delLen = $(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox:checked').parents('.jt_mplay_li').length;
		                    		
		                    		$(openWin.document).find('#jt_playerdt input[name=play_chk]:checkbox:checked').parents('.jt_mplay_li').remove();
		                    			let mplay_li = $(openWin.document).find('#jt_playerdt .jt_mplay_li');
		                    			let itemcheck = $(openWin.document).find('#jt_playerdt .itemcheck');
		                    			let itemcheck_chbox = $(openWin.document).find('#jt_playerdt .jt_pp');
		                    			let player_checkbox_label = $(openWin.document).find('#jt_playerdt .player_checkbox_label');
		                    			let jt_itemrank = $(openWin.document).find('#jt_playerdt .jt_itemrank');
		                    		    let num = $(openWin.document).find('#jt_playerdt .jt_rank');
		                    		    let jt_itemtitle_div = $(openWin.document).find('#jt_playerdt .jt_itemtitle_div');
		                    		    let jt_itemdt = $(openWin.document).find('#jt_playerdt .jt_itemdt');
		                    		    let jt_titgroup = $(openWin.document).find('#jt_playerdt .jt_titgroup');
		                    		    let jt_titsong = $(openWin.document).find('#jt_playerdt .jt_titsong');
		                    		    let jt_itemem = $(openWin.document).find('#jt_playerdt .jt_itemem');
		                    		    let _jt_artist = $(openWin.document).find('#jt_playerdt ._jt_artist');
		                    			for(let i=0;i<num.length;i++){
		                    				mplay_li[i].id = 'jt_mplay_li'+i;
		                    				itemcheck[i].id ='jt_itemcheck'+ i;
		                    				itemcheck_chbox[i].id ='checkbox'+ i;
		                    				$(player_checkbox_label[i]).attr({'for':itemcheck_chbox[i].id});
		                    				
		                    				jt_itemrank[i].id ='jt_itemrank'+ i;
		                    				num[i].id ='jt_rank'+ i;
		                    				num[i].innerHTML = i+1;
		                    				jt_itemtitle_div[i].id ='jt_itemtitle_div'+ i;
		                    				jt_itemdt[i].id ='jt_itemdt'+ i;
		                    				jt_titgroup[i].id ='jt_titgroup'+ i;
		                    				jt_titsong[i].id ='jt_titsong'+ i;
		                    				jt_itemem[i].id ='jt_itemem'+ i;
		                    				_jt_artist[i].id ='jt_artist'+ i;
		                    			}
		                    		musicCnt = $(openWin.document.getElementById('musicCnt')).html() - delLen;
		                    		$(openWin.document.getElementById('musicCnt')).html(musicCnt);
		                    		}).appendTo(openWin.document.getElementById('jt_playBtnArea'));
		                        
		                    	  $(openWin.document.getElementById('play_allCheck')).click(e=>{
		          					if($(openWin.document.getElementById('play_allCheck')).is(':checked')){
		          						$('input[name=play_chk]:checkbox').prop('checked',true);
		          					}else{
		          						$('input[name=play_chk]:checkbox').prop('checked',false);
		          					}
		          				});
		                    	$('<span/>').addClass('jt_musicCnt').html('No.').appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<span/>').attr({id:'musicCnt'}).html(musicCnt).appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<div/>').attr({id:'jt_tab_area'}).appendTo(openWin.document.getElementById('jt_playerOption'));
		                    	$('<div/>')
		                    	.attr({id:'jt_mplay_list','style':'position:relative','overflow':'hidden'})
		                    	.addClass('jt_mplay_list')
		                    	.appendTo(openWin.document.getElementById('jt_tab_area'));
		                    	$('<ul>').attr({id:'jt_mplay_ul'}).addClass('jt_mplay_ul').appendTo(openWin.document.getElementById('jt_mplay_list'));
		                    	for(var i=0; i<musicCnt;i++){
		                    		$('<li/>').attr({id:'jt_mplay_li'+i}).addClass('jt_mplay_li').appendTo(openWin.document.getElementById('jt_mplay_ul'));
		                        	$('<em/>').attr({id:'jt_itemcheck'+i}).addClass('itemcheck jt_playckbox').appendTo(openWin.document.getElementById('jt_mplay_li'+i));
		                        	$('<input/>').attr({type : 'checkbox', id :'checkbox'+i, name :'play_chk'}).addClass('jt_pp').appendTo(openWin.document.getElementById('jt_itemcheck'+i));
		                        	$('<label for="checkbox'+i+'">').addClass('player_checkbox_label').appendTo(openWin.document.getElementById('jt_itemcheck'+i));
		                        	$('<em/>').attr({id:'jt_itemrank'+i}).addClass('jt_itemrank').appendTo(openWin.document.getElementById('jt_mplay_li'+i));
		                        	$('<span/>').attr({id:'jt_rank'+i}).addClass('rank jt_rank').html(i+1).appendTo(openWin.document.getElementById('jt_itemrank'+i));
		                        	$('<div/>').attr({id:'jt_itemtitle_div'+i}).addClass('jt_itemtitle_div').appendTo(openWin.document.getElementById('jt_mplay_li'+i));
		                        	$('<div/>').attr({id:'jt_itemdt'+i}).addClass('jt_itemdt').appendTo(openWin.document.getElementById('jt_itemtitle_div'+i));
		                        	$('<span/>').attr({id:'jt_titgroup'+i}).addClass('jt_titgroup').appendTo(openWin.document.getElementById('jt_itemdt'+i));
		                        	$('<a/>').attr({id:'jt_titsong'+i}).addClass('jt_titsong').html(d.albums[i].MUSIC_TITLE).appendTo(openWin.document.getElementById('jt_titgroup'+i));
		                        	$('<em/>').attr({id:'jt_itemem'+i}).addClass('jt_itemem').html('|').appendTo(openWin.document.getElementById('jt_itemdt'+i));
		                        	$('<span/>').attr({id:'jt_artist'+i}).addClass('_jt_artist').html(d.albums[i].ARTIST_NAME).appendTo(openWin.document.getElementById('jt_itemdt'+i));
		                    	}

		                },110);
		            });
				}else {
					let cnt =$(openWin.document.getElementById('musicCnt')).html()*1;
                	for(var i=0; i<d.albums.length;i++){
                		$('<li/>').attr({id:'jt_mplay_li'+cnt}).addClass('jt_mplay_li').appendTo(openWin.document.getElementById('jt_mplay_ul'));
                    	$('<em/>').attr({id:'jt_itemcheck'+cnt}).addClass('itemcheck jt_playckbox').appendTo(openWin.document.getElementById('jt_mplay_li'+cnt));
                    	$('<input/>').attr({type : 'checkbox', id :'checkbox'+cnt, name :'play_chk'}).addClass('jt_pp').appendTo(openWin.document.getElementById('jt_itemcheck'+cnt));
                    	$('<label for="checkbox'+cnt+'">').addClass('player_checkbox_label').appendTo(openWin.document.getElementById('jt_itemcheck'+cnt));
                    	$('<em/>').attr({id:'jt_itemrank'+cnt}).addClass('jt_itemrank').appendTo(openWin.document.getElementById('jt_mplay_li'+cnt));
                    	$('<span/>').attr({id:'jt_rank'+cnt}).addClass('rank jt_rank').html(cnt+1).appendTo(openWin.document.getElementById('jt_itemrank'+cnt));
                    	$('<div/>').attr({id:'jt_itemtitle_div'+cnt}).addClass('jt_itemtitle_div').appendTo(openWin.document.getElementById('jt_mplay_li'+cnt));
                    	$('<div/>').attr({id:'jt_itemdt'+cnt}).addClass('jt_itemdt').appendTo(openWin.document.getElementById('jt_itemtitle_div'+cnt));
                    	$('<span/>').attr({id:'jt_titgroup'+cnt}).addClass('jt_titgroup').appendTo(openWin.document.getElementById('jt_itemdt'+cnt));
                    	$('<a/>').attr({id:'jt_titsong'+cnt}).addClass('jt_titsong').html(d.albums[i].MUSIC_TITLE).appendTo(openWin.document.getElementById('jt_titgroup'+cnt));
                    	$('<em/>').attr({id:'jt_itemem'+cnt}).addClass('jt_itemem').html('|').appendTo(openWin.document.getElementById('jt_itemdt'+cnt));
                    	$('<span/>').attr({id:'jt_artist'+cnt}).addClass('_jt_artist').html(d.albums[i].ARTIST_NAME).appendTo(openWin.document.getElementById('jt_itemdt'+cnt));
                    	cnt++;
                	}
                	$(openWin.document.getElementById('musicCnt')).html(cnt);
				}
				
	          
			})
	
		}
};
