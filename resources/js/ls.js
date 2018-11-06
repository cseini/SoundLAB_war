"use strict";
var ls = ls || {};
ls ={
		chart :x=>{
	
			$.getJSON(sh.ctx()+'/music/top50/'+x+','+$.cookie("loginID"),d=>{
				
				
				 if(!($("#chartSec").length >0)){ 
						let $chartSec = $('<section/>').attr({id:'chartSec'});
						$chartSec.appendTo($('#contents'))
						
						
								// Top100 헤더
								$('<div/>').addClass("ls_char_panel_top Panel panel-dafalt container").append(
										$('<h1/>').html('TOP 50')
								).appendTo($chartSec);
								// 
								$('<div/>').attr({id :'chart_title'}).addClass("container").appendTo($chartSec);
								 $('<div/>').addClass("ls_lineCh Panel panel-dafalt container").append(
						                    
					                     $('<div/>').attr({id :'line_top_x'})
					                ).appendTo($chartSec);
								//nav-sort
								$('<br><br><div/>').attr({id : 'chart-content' }).addClass("ls_char_panel panel panel-dafalt container").append(
										$('<div/>').append(
												 $('<ul/>').addClass("ls_chart_nav nav nav-tabs nav-justified").append(
														 $('<li/>').append(
																 $('<a/>').attr({id : 'liveChr'}).html('일간'))
																 .click(()=>{ 
																	 let realChart = 'realChart';
																		$.getJSON(sh.ctx()+'/music/top50/'+realChart+','+$.cookie("loginID"),d=>{
																			$('#topTable').empty();
																			 ls.top50table(d);
																			 ls.infiSc('realChart');
																	 })
																	 
																 }),
														 $('<li/>').append(
																 $('<a/>').attr({id : 'wklChr'}).html('주간'))
																 .click(()=>{ 
																	 	let weekChart = 'weekChart';
																		$.getJSON(sh.ctx()+'/music/top50/'+weekChart+','+$.cookie("loginID"),d=>{
																			$('#topTable').empty();
																			 ls.top50table(d);
																			 ls.infiSc('weekChart');
																	 })
																	 }),
														 $('<li/>').append(
																$('<a/>').attr({id : 'monthChr'}).html('월간'))
																.click(()=>{ 
																	 let monthChart = 'monthChart';
																		$.getJSON(sh.ctx()+'/music/top50/'+monthChart+','+$.cookie("loginID"),d=>{
																			$('#topTable').empty();
																			 ls.top50table(d);
																			 ls.infiSc('monthChart');
																	 })
																	})

												 )
										)
								).appendTo($chartSec);

								$('<div/>').attr({id : 'chart-top50' }).addClass("ls_char_panel Panel panel-dafalt container")
								.appendTo($chartSec);
						
									$('<div/>').attr({id :'ls_panel'}).addClass("ls_char_panel panel panel-default").append(
										
													$('<div/>').addClass("pull-left").attr({id :'pull-left'}).append(
															$('<div/>').addClass("btn-group").append(
																	$('<button/>').attr({id : 'listenChoose'})
																	.addClass("btn btn-default btn-filter").html('선택듣기')
														 .click(e=>{ 
															
															 let ck = $('input[name=al_chkBox]:checkbox:checked');
																let seqs = '';
																$.each(ck,(i,v)=>{
																	seqs += v.value + ((i < ck.length-1)?',':'');
																    
																});
																jt.music_player(seqs)
															   $('input[name = al_chkBox]:checkbox').prop('checked',false);
														}),
																	$('<button/>').attr({id : 'listenAll'})
																	.addClass("btn btn-default btn-filter").html('전체듣기')
																	.click(e=>{
																		let ck = $('input[name=al_chkBox]:checkbox');
																		let seqs = '';
																		$.each(ck,(i,v)=>{
																			seqs += v.value + ((i < ck.length-1)?',':'');
																		});
																		jt.music_player(seqs);
																		$('input[name = al_chkBox]:checkbox').prop('checked',false);
																	 }),
																	$('<button/>').attr({id : 'addToList'})
																	.addClass("btn btn-default btn-filter").html('담기')
																	.click(()=>{ 
																		 let ck = $('input[name=al_chkBox]:checkbox:checked');
																			let seqs = '';
																			$.each(ck,(i,v)=>{
																				seqs += v.value + ((i < ck.length-1)?',':'');
																			});
																			jt.music_player(seqs);
																			$('input[name = al_chkBox]:checkbox').prop('checked',false);
																		 })
															)
											)
					).appendTo($('#chart-top50')),
					ls.tHeader(),
					ls.top50table(d),
					ls.infiSc('realChart');
					$('#allCheck').click(()=>{
		                if($('#allCheck').is(':checked')){
		                    $('input[name = al_chkBox]:checkbox').prop('checked',true);
		                }else{
		                    $('input[name = al_chkBox]:checkbox').prop('checked',false);
		                }
		            })
					
		            
		            //-------------차트-----------------
		            
		           $.getJSON(sh.ctx()+'/music/top50lineChart',d=>{	
		        	   			let vd = [];
		        	   			let ttl = [];
		        	   			let strm = [];
		        	   			let arti = [];
		        	   			let sq = [];
		        	   			let per = [];
		        	   			let sum;
		        	   			for(let i=0;i<21;i=i+3){
		        	   				vd.push(d[i].날짜);
		        	   				vd.push(d[i+1].날짜);
		        	   				vd.push(d[i+2].날짜);
		        	   				ttl.push(d[i].TITLE);
		        	   				ttl.push(d[i+1].TITLE);
		        	   				ttl.push(d[i+2].TITLE);
		        	   				strm.push(d[i].스트리밍);
		        	   				strm.push(d[i+1].스트리밍);
		        	   				strm.push(d[i+2].스트리밍);
		        	   				arti.push(d[i].가수);
		        	   				arti.push(d[i+1].가수);
		        	   				arti.push(d[i+2].가수);
		        	   				sq.push(d[i].SEQ);
		        	   				sq.push(d[i+1].SEQ);
		        	   				sq.push(d[i+2].SEQ);
		        	   				sum = strm[i]+strm[i+1]+strm[i+2];
		        	   				per.push((strm[i]/sum)*100);
		        	   				per.push((strm[i+1]/sum)*100);
		        	   				per.push((strm[i+2]/sum)*100);
		        	   			}
							 	google.charts.load('current', {'packages':['line']});
					 			google.charts.setOnLoadCallback(drawChart1);
					 			
					 		
					 			
							    function drawChart1() {
							    	  var data = new google.visualization.DataTable();
							    	  data.addColumn('string', 'day');
						        	  data.addColumn('number', '1위    '+arti[18]+'/'+ttl[18]);
						         	  data.addColumn('number', '2위    '+arti[19]+'/'+ttl[19]);
						         	  data.addColumn('number', '3위    '+arti[20]+'/'+ttl[20]);
							
						         	 let trans=x=>{
											let day=new Date(x).getDate();
									
											return day+"일";
										};
							          for(let i=0; i <21; i=i+3){	
							        	  
							          data.addRows([
							            [trans(new Date(vd[i])),  per[i], per[i+1], per[i+2]]
							           
							          ]);
							          }
							         
							          let options = {
							        	        fontSize : 16,
							        	        width: 1100,
							        	        height: 350,
							        	        axes: {
							        	          x: {
							        	            0: {side: 'bottom'}
							        	          }
							        	        }
							        	      };
							          
							          var lineChart = new google.charts.Line(document.getElementById('line_top_x'));
							          lineChart.draw(data, google.charts.Line.convertOptions(options));
							  }		
							  
      
      
      $('<div/>').append(
				$('<div/>').addClass('ls_fa-line-chart fa fa-line-chart').html('실시간 점유율'),
				$('<div/>').addClass('ls_chart_time').html('현재시간 : '+new Date().toLocaleString()),
				$('<div/>').addClass('rank_time').append(
						$('<ul/>').append(
								$('<li/>').addClass('lank01').append(
										$('<span/>').addClass('none').html('1위'),
										$('<em/>').html(per[18].toFixed(1)+'%')
										
								),
								$('<li/>').addClass('lank02').append(
										$('<span/>').addClass('none').html('2위'),
										$('<em/>').html(per[19].toFixed(1)+'%')
								),
								$('<li/>').addClass('lank03').append(
										$('<span/>').addClass('none').html('3위'),
										$('<em/>').html(per[20].toFixed(1)+'%')
								)
						)
				)
		).appendTo('#chart_title');
})
			
		     	
		     	
					
					}
	        	});
		},
				
		album :x=>{
		
			$.getJSON($.ctx()+'/album/newAl/'+x,d=>{
				if(!($("#albumSec").length >0)){ 
					let $albumSec = $('<section/>').attr({id:'albumSec'});
					$albumSec.appendTo($('#contents'))
							// 앨범헤더
							$('<div/>').addClass("ls_album_panel container").append(
									$('<h1/>').html('최신앨범')
							).appendTo($albumSec);
							// 앨범 캐러셀
							$('<div/>').addClass('container').append(
									$('<div/>').addClass('row').append(
											$('<div/>').addClass('col-xs-12').append(
													$('<h2/>').attr('style','margin-left: 1.2rem;').addClass('my-4'),
													$('<div/>').attr({id : 'alCarousel'}).addClass('carousel slide ls_featured-shows-slides')
													.on('click','.item>div',function(e){
														jt.album_detail($(this).attr('id'));
													})
											)
									)
							).appendTo($albumSec);
							ls.alCarousel();
							
							
							  
							// 앨범 정렬
							$('<br><br><div/>').attr({id : 'album-content' }).addClass("ls_album_panel container").append(
									$('<div/>').append(
											 $('<ul/>').addClass("ls_album_nav nav nav-tabs nav-justified").append(
													 $('<li/>').attr({id : 'ali1'}).append(
															 $('<a/>').attr({href:'#',id : 'ls_alDateSort'}).html('발매일'))
														.click(()=>{ 
																	$.getJSON(sh.ctx()+'/album/newAl/'+'newAl_recent',d=>{
																	
																		ls.new_alList(d);
																	})
									 
															 }),
													 $('<li/>').attr({id : 'ali2'}).append(
															 $('<a/>').attr({href:'#', id : 'ls_alUpSort'}).html('좋아요'))
															 .click(()=>{ 
																 $.getJSON(sh.ctx()+'/album/newAl/'+'newAl_like',d=>{
																		ls.new_alList(d);
																	})
															 })		
											 )
									)
							).appendTo($albumSec);
							
							//컨텐츠
							$('<div/>').attr({id : 'album-Table' }).addClass("ls_album_panel container").append(
									$('<div/>').attr({id : 'ls_newAlLe'}),
									$('<div/>').attr({id : 'ls_newAlRi'})
							).appendTo($albumSec);
							
							ls.new_alList(d);
							ls.al_comments();
			}
			})
			
			
		},
		 tHeader :()=>{
				$('<section/>').addClass("ls_topTable table-container").append(
						$('<table/>').addClass("ls_table table ls_table-`filter").attr({id :'topHeader'})
				).appendTo($('#pull-left'));
				$('<tbody/>').append(
						$('<tr/>').addClass('ls_table-filter').append(
										$('<th/>').attr({style : 'width:5%'}).append(
												$('<input/>').attr({type : 'checkbox', id :'allCheck' }).attr({style : 'width:15px'}),
												$('<label for="allCheck">')
								),
								$('<th/>').attr('width','5%').html('NO'),
								$('<th/>').attr('width','10%').html('앨범사진'),
								$('<th/>').attr('width','30%').html('제목'),
								$('<th/>').attr('width','10%').html('아티스트'),
								$('<th/>').attr('width','10%').html('앨범명'),
								$('<th/>').attr('width','40%').html('')
							
						)
				).appendTo($('#topHeader'));
		 },
	
		 top50table :d=>{
			
				$('<section/>').addClass("ls_topTable table-container").append(
						$('<table/>').addClass("ls_table table ls_table-filter").attr({id :'topTable'})
				).appendTo($('#pull-left'));
		
				
		
					$.each(d,(i,v)=>{
								
						$('<tr/>').append(
								$('<td/>').attr({id : 'tableTd1'}).append(
										$('<div/>').addClass('ckbox').append(
												$('<input/>').attr({type : 'checkbox', id : v.NO , name :'al_chkBox',value :v.MUSIC_SEQ}),
												$('<label for='+v.NO+'>') 
										)
								),
								$('<td/>').attr({id : 'tableTd2'}).html(v.NO),
								$('<td/>').attr({id : 'tableTd3'}).append(
												$('<img/>').attr({
													src : $.ctx()+'/resources/img/album/'+v.IMG,
													id : 'ls_album_photo'
												}).click(()=>{
														jt.album_detail(v.ALBUM_SEQ);
												})
								),
								$('<td/>').attr({id : 'tableTd4'}).html(v.MUSIC_TITLE)
								.attr({style : 'text-overflow: ellipsis'}),
								$('<td/>').attr({id : 'tableTd5'}).html(v.ARTIST_NAME).click(()=>{
										jt.search(v.ARTIST_NAME);
								}),
								$('<td/>').attr({id : 'tableTd6'}).html(v.ALBUM_TITLE).click(()=>{
										jt.album_detail(v.ALBUM_SEQ);
								}),
								$('<td/>').attr({id : 'tableTd7'}).append(
										$('<i/>').addClass('ls_fa fa fa-play')
										.click(()=>{
												jt.music_player(v.MUSIC_SEQ);
										}),
										$('<i/>').addClass((v.TYPES == 'u')?'active':'').attr({id : 'ls_up'+v.NO }).addClass('ls_fa fa fa-heart')
										.click(function(e){
											if(sh.service.auth() == 0 ){
												sj.service.put_ud({thiz:$(this),btn:'like',mSeq:v.MUSIC_SEQ ,gSeq:v.GENRE_SEQ});
											}
										}),
										$('<i/>').addClass('ls_fa glyphicon glyphicon-facetime-video')
										.click(()=>{
												jt.album_detail(v.MUSIC_SEQ);
										
										}),
										$('<i/>').addClass((v.TYPES == 'd')?'active':'').attr({id : 'ls_down'+v.NO })
										.addClass('ls_fa fa fa-thumbs-down')
										.click(function(e){
											if(sh.service.auth() == 0 ){
												sj.service.put_ud({thiz:$(this),btn:'hate',mSeq:v.MUSIC_SEQ ,gSeq:v.GENRE_SEQ});
											}
										})
								)
								
							
				).appendTo($('#topTable'));
				 
			 
		
				
					})
			
		},
		
		
		infiSc : p =>{
			
			var bool_sw = true;
			//무한 스크롤
			let no= 31;
		
			$(window).on("scroll", function() {
 	
    		var scrollHeight = $(document).height();
    		var scrollPosition = $(window).height() + $(window).scrollTop();		

    		$("#scrollHeight").text(scrollHeight);
    		$("#scrollPosition").text(scrollPosition);
    		$("#bottom").text(scrollHeight - scrollPosition);
    		
    
    		if ( scrollPosition > scrollHeight - 100) {
    			if(bool_sw){ 
		     		sendData(); //실행 
		     		} 
		     		function sendData(){ 
		     		bool_sw = false;
		     		
		     			$.getJSON($.ctx()+'/music/infiSc/'+no+','+$.cookie("loginID")+','+p,d=>{
		     				if(no <= 50){
        					ls.top50table(d);
        						no=no+20;
        						  setTimeout(function(){bool_sw = true;},500) 
		     		} 
		     			})
		     		}
    		}
    	});

		},
		new_alList :d=>{
			$('#ls_newA').empty();
			$('<ul/>').addClass('ls_cards').attr({id : 'ls_newA'}).appendTo($('#ls_newAlLe'));
			
			$.each(d,(i,v)=>{
						$('<ul/>').addClass('ls_cards__item').append(
								$('<div/>').addClass('ls_card').append(
										$('<div/>').addClass('ls_card__image').append(
												
												$('<img/>').attr({src : $.ctx()+'/resources/img/album/'+v.IMG})
												.addClass('ls_alimg').click(()=>{ 
														jt.album_detail(v.ALBUM_SEQ);
												 })
										),
										$('<div/>').addClass('ls_card__content').append(
												$('<div/>').addClass('ls_card__title')
												.html(v.ARTIST_NAME+' / '+v.ALBUM_TITLE),
												$('<div/>').addClass('ls_card__div').append(
														$('<div/>').addClass('ls_card__text').html(v.REGI_DATE),
														$('<div/>').addClass('glyphicon glyphicon-thumbs-up')
														.html(v.SUMCNT)
												),
												
												$('<div/>').append(
														$('<button/>').addClass('ls_btn btn--block card__btn').html('앨범듣기')

														.click(()=>{ 
																jt.album_player(v.ALBUM_SEQ);
															
														 })
												)
										)
						)
						).appendTo($('#ls_newA'));
		
			
		
				
			})
				
				
				
				
			},
			 //캐러셀
		alCarousel:()=>{
			
			$.getJSON(sh.ctx()+'/album/carousel/',d=>{
	
		
			  let item = $('<div/>').addClass('carousel-inner')
			  item.appendTo($('#alCarousel'));
			  
			 $.each(d,(i,v)=>{ $('<div/>').addClass('item'+((i===0)?' active':'')).append(
					  $('<div/>').addClass('col-md-3 col-sm-6 col-xs-12 ls-dj-item')
					  .attr({id : v.ALBUM_SEQ}).append( 
							  $('<img/>').attr({src : $.ctx()+'/resources/img/album/'+v.IMG})
							  .addClass('img-responsive')
							,
							  $('<div/>').attr({style :'height ="40%"'}).addClass('ls-dj-item-content').append(
									  $('<div/>').addClass('ls-dj-content-txt').append( 
											  $('<h4/>').html(v.ARTIST_NAME), 
											  $('<p/>').html(v.MUSIC_TITLE), 
											  $('<div/>').addClass('bg-gradients') ) ) ) )
											  .appendTo(item)
													
											});
			 
			
	
			  	$('<a/>')
				.attr({href:'#alCarousel', 'data-slide':'prev'})
				.addClass('left carousel-control')
				.append(
						$('<i/>').addClass('glyphicon glyphicon-chevron-left')
				).appendTo($('#alCarousel'));
				$('<a/>')
				.attr({href:'#alCarousel', 'data-slide':'next'})
				.addClass('right carousel-control')
				.append(
						$('<i/>').addClass('glyphicon glyphicon-chevron-right')
				).appendTo($('#alCarousel'));
				
				$('#alCarousel').carousel({
					  interval: 2000
					})
		
					$('#alCarousel .item').each(function () {
				        var next = $(this).next();
				        if (!next.length) {
				            next = $(this).siblings(':first');
				        }
				        next.children(':first-child').clone().appendTo($(this));

				    	for (var i=0;i<2;i++) {
							next=next.next();
							if (!next.length) {
								next = jQuery(this).siblings(':first');
							}
							next.children(':first-child').clone().appendTo($(this));
						}
				    });
				
			
			})
			
			
		
			
			
			
		
		},
			
	
			
		//댓글
		al_comments :()=>{
			let arr1 = ['신난 ','감동받은 ','졸린 ','반가운 '];
			let arr2 = ['라이언','무지','어피치','프로도','네오','튜브','제이지','콘'];
			
			let nic1 = Math.floor(Math.random()*3);
			let nic2= Math.floor(Math.random()*7);
			 for(let i =0; i < 1;i++){
				 $('<div/>').append(
							$('<div/>').addClass('row').append(
								$('<div/>').addClass('col-md-12').append(
										$('<div/>').addClass('blog-comment').attr({id : 'blog-comment'}).append(
												$('<div/>').addClass('clearfix').append(
														 $('<div/>').addClass('post-comments-add').append(
																 new Date().toLocaleString(),
																 $('<p>').html(arr1[nic1]+arr2[nic2]),
																 $('<i>').addClass('pull-right'),
																 $('<input/>').attr({type : 'text',id : 'alcommentText'}).addClass('alInputText'),
																 $('<a/>').addClass('alCommentBtn').html('확인')
																 .click(()=>{
																	$.ajax({
																		url : $.ctx()+'/album/alComment',
																		method : 'post',
																		contentType: 'application/json',
																		//member_id,seq_group,msg
																		data : JSON.stringify({
																			memberId: arr1[nic1]+arr2[nic2],
																			seqGroup : '-1',
																			msg : $('#alcommentText').val()
																		}),
																		success : ()=>{
																			 ls.viewComment();
																			 $('#alcommentText').val('');
																		}
																		
																	})
																 })        
														 )
													)
										),
										$('<hr/>')
										
								)	
							)
						).appendTo($('#ls_newAlRi'))
			 }
			 $('<div/>').addClass('blog-comment').attr({id : 'blog-comment'})	
			 
			ls.viewComment();
				
			
			
			
		},
		viewComment:()=>{
			$('#ls_comments').empty();
			
			$('<div/>').attr({id :'ls_comments'}).appendTo($('#blog-comment'))
			$.getJSON($.ctx()+'/album/viewComment',d=>{
				for(let i=0 ; i<d.length; i++){
					if(i==6){
						break;
					}
					$('<div/>').addClass('clearfix').append(
							 $('<img/>').attr({src : $.ctx()+'/resources/img/user_1.jpg'})
							 .addClass('avatar'),
							 $('<div/>').addClass('post-comments').append(
									 $('<p>').addClass('meta').html(d[i].REGI_DATE),
									 $('<p>').addClass('meta').html('닉네임 : ' +d[i].MEMBER_ID),
									 $('<i>').addClass('pull-right'),
									 $('<p>').addClass('meta').html(d[i].MSG)
							 )
						).appendTo($('#ls_comments'))
					
				}
				
			})
		
					
				}
		
		
}

