"use strict";
var sj = sj || {};
sj ={
		dj : ()=>{
			if(!($("#djSec").length >0)){   //exist
		
				let $djSec = $('<section/>').attr({id:'djSec'}).appendTo($('#contents'));
				
				$('<div/>').addClass('container').appendTo($djSec).append(
						$('<div/>').addClass('row text-center').append(
								$('<h4/>').attr({'style':'font-weight: bold;'}).addClass('col-xs-offset-3 col-xs-2').html('스타일'),
								$('<h4/>').attr({'style':'font-weight: bold;'}).addClass('col-xs-2').html('상황&장소'),
								$('<h4/>').attr({'style':'font-weight: bold;'}).addClass('col-xs-2').html('감정&기분')
						),
						$('<div/>').addClass('row').append(
								$('<div/>').attr({id : 'hb1','data-toggle':'buttons'}).addClass('col-xs-offset-3 col-xs-2 btn-group-vertical'),
								$('<div/>').attr({id : 'hb2','data-toggle':'buttons'}).addClass('col-xs-2 btn-group-vertical'),
								$('<div/>').attr({id : 'hb3','data-toggle':'buttons'}).addClass('col-xs-2 btn-group-vertical')
						),
						$('<div/>').attr({id:'dj-ls','style':'margin-top: 5rem'}).addClass('container')
				);
				let arr = [
					{at:'1',hash:['신나는','차분한','어쿠스틱','트로피칼','부드러운']},
					{at:'2',hash:['드라이브','휴식','편집숍&카페','헬스','클럽']},
					{at:'3',hash:['스트레스','이별','사랑&고백','새벽감성','위로']}
					];
				$.each(arr,(i,v)=>{
					$.each(v.hash,function(){
						$('<button/>')
						.attr({'style': 'z-index: 0;'})
						.addClass('btn sj-hash-btn')
						.html(this)
						.append(
								$('<input/>')
								.attr({
									type : 'checkbox',
									value : this
								})
						).appendTo($('#hb'+v.at));
					})
				});
				
				$('input[type="checkbox"]').change(function(){
					$('#sj-dj-detail').remove();
					
					let $this = $(this);
					$('input[type="checkbox"]:not(:checked)')
					.parents('button.sj-hash-btn')
					.prop('disabled'
							,($('input[type="checkbox"]:checked').length===3)
								? true : false );
					let s = '';
					let ckHash = $('input[type="checkbox"]:checked');
					for(let i of ckHash){
						s += i.value+',';
					}
					sj.service.dj_pl((s == '')?'first':s.slice(0,-1));
				});
				
				sj.service.dj_pl('first');
				
			}
		},
		
		forYou : ()=>{
			if(!($("#foryouSec").length >0)){   //exist
					let $foryouSec = $('<section/>').attr({id:'foryouSec'}).appendTo($('#contents'));
					
					$('<div/>')
					.attr({id:'sj-loading',style:'height:300px;text-align:center;'})
					.append(
							$('<img/>').attr({src:$.img()+'/loading.gif', style:'width:15rem;'})
					)
					.appendTo($foryouSec);

					$.getJSON($.ctx()+'/foryou/'+$.cookie("loginID"),d=>{
						
						$('#sj-loading').remove();
						
						let fmsA = [], fmsB = [], fal = [], fat = [], ald = [];
						let genreA = d.fy[0].msGenreA, genreB = d.fy[0].msGenreB;
						$.each(d.fy,(i,v)=>{
							if(v.msRankA <= 5){
								let u = {
										musicSeq : v.msSeqA,
										musicTitle : v.msTitleA,
										genreSeq : v.msGenreSeqA,
										artistSeq : v.msArtistA,
										artistName : v.msArtistNameA,
										albumSeq : v.msAlbumA,
										albumTitle : v.msAlbumTitleA
								};
								fmsA.push(u);
								
							}
							if(v.msRankB <= 5){
								let w = {
										musicSeq : v.msSeqB,
										musicTitle : v.msTitleB,
										genreSeq : v.msGenreSeqB,
										artistSeq : v.msArtistB,
										artistName : v.msArtistNameB,
										albumSeq : v.msAlbumB,
										albumTitle : v.msAlbumTitleB
								};
								fmsB.push(w);
							}
							if(v.alRank <= 5){
								let x = {
										albumSeq : v.alSeq,
										albumTitle : v.alTitle,
										artistSeq : v.alArtist,
										artistName : v.alArtistName,
										imgName : v.alImgName,
										ext : v.alImgExt
								};
								fal.push(x);
							}
							if(v.atRank <= 5){
								let y = {
										artistSeq : v.atArtistSeq,
										artistName : v.atArtistName,
										imgName : v.atImgName,
										ext : v.atImgExt
								};
								fat.push(y);
							}
							if(v.mSeq > 0){
								let z = {
										musicSeq : v.musicSeq,
										musicTitle : v.musicTitle,
										genreSeq : v.genreSeq,
										artistName : v.artistName,
										albumSeq : v.albumSeq,
										albumTitle : v.albumTitle,
										type : v.type
								};
								ald.push(z);
							}
						});
						
						
					$('<div/>')
					.addClass('clearfix')
					.attr({id:'for-music', 'style':'margin-bottom:0px;'})
					.append(
							$('<div/>').addClass('container').append(
									$('<div/>').addClass('row').append(
											$('<div/>').addClass('col-xs-12').append(
													$('<div/>').addClass('sj-music-content sj-d-flex sj-flex-wrap').attr({'style':'height:400px'}).append(
															$('<div/>').addClass('sj-music-content-songs sj-h-100').attr({'style':'flex:none; width:100%; max-width:100%;padding-top:7.5rem;'}).append(
																	$('<p/>')
																	.attr({'style':'top:5%;'})
																	.addClass('sj-foryou-theme').html('Music <span style="color:#F6B352;">For</span> You'),
																	$('<div/>').addClass('sj-music-songs-info sj-mb-10 sj-d-flex sj-flex-wrap sj-align-items-center').append(
																			$('<div/>').addClass('sj-songs-info-title').attr({'style':'width:100%;'}).append(
																							$('<div/>').addClass('sj-foryou-switch row')
																							.attr({'style':'margin: 10px 0;'})
																							.append(
																									$('<strong/>').html(genreA),
																									$('<input/>')
																									.attr({id:'genreSwt', type:'checkbox'})
																									.click(function(e){
																										$('input[name=allCheckMusic]:checkbox').prop('checked',false);
																										if($(this).is(':checked')){
																											sj.service.fy_music_li(fmsB);
																										}else{
																											sj.service.fy_music_li(fmsA);
																										}
																									}),
																									$('<label/>').attr({'for':'genreSwt'}),
																									$('<strong/>').html(genreB)
																							)
																			)
																	),
																	$('<div/>').addClass('sj-songs-meta').append(
																			$('<label/>').addClass('check-con').append(
																					$('<input/>').attr({type:'checkbox',name:'allCheckMusic'})
																					.click(function(e){
																						let $this = $(this);
																						$('.sj-music-item .check-con input[name=musicCk]:checkbox').prop('checked',($this.is(':checked')?true:false));
																					}),
																					$('<span/>').addClass('sj-checkmark')
																			),
																			$('<div/>').addClass('sj-fym-title').append($('<p/>').html('제목')),
																			$('<div/>').addClass('sj-fym-artist').append($('<p/>').html('아티스트')),
																			$('<div/>').addClass('sj-fym-album').append($('<p/>').html('앨범')),
																			$('<button/>').addClass('btn').html('전체듣기')
																			.click(e=>{
																				sj.service.music_player($('.sj-music-item .check-con input[name=musicCk]:checkbox'));
																			}),
																			$('<button/>').addClass('btn').html('선택듣기')
																			.click(e=>{
																				let chkBox = $('.sj-music-item .check-con input[name=musicCk]:checkbox:checked');
																				sj.service.music_player(chkBox);
																				chkBox.prop('checked',false);
																				$('input[name=allCheckMusic]').prop('checked',false);
																			})
																	),
																	$('<div/>').addClass('sj-music-list-area sj-pl-scroll').attr({id:'fy-music-list','style':'height:60%;'})
															)
													)
											)
									)
							)
					).appendTo($foryouSec);
					
					sj.service.fy_music_li(fmsA);
					
					// for - album		
					
					$('<div/>')
					.addClass('clearfix')
					.attr({id:'for-album', 'style':'margin-bottom:0px;'})
					.append(
							$('<div/>').addClass('container').append(
									$('<div/>').addClass('row').append(
											$('<div/>').addClass('col-xs-12').append(
													$('<div/>')
													.attr({'style':'padding:8rem 0rem 2.5rem 5rem;border:1px solid #EEEEEE;'})
													.addClass('sj-music-content sj-d-flex sj-flex-wrap').append(
															$('<p/>').addClass('sj-foryou-theme').html('Album <span style="color:#F6B352;">For</span> You'),
															$('<div/>').attr({id:'for-album-li'}),
															$('<div/>').addClass('sj-music-content-songs sj-h-100')
															.attr({id:'for-album-dt'})
													)
											)
									)
							)
					).appendTo($foryouSec);
					
					if(fal.length === 0){
						$('#for-album-li').remove();
						$('#for-album-dt').remove();
						$('#for-album p.sj-foryou-theme').after(function(){
							return $('<p/>').attr({'style':'margin-left:300px;'}).html('좋아하는 장르의 앨범이 없습니다.');
						});
						$('#for-album .sj-music-content').css('height','200px');
					}else{
						let $li = $('<div/>').addClass('list-group').attr({'style':'margin:0;'}).appendTo('#for-album-li');
						
						$.each(fal,(i, v)=>{
							$('<div/>')
							.addClass('sj-for-album-item sj-bg-img')
							.attr({'style':'background-image:url('+$.ctx()+'/resources/img/album/'+v.imgName+'.'+v.ext+');'})
							.append(
									$('<div/>').addClass('sj-for-album-eff').append(
											$('<h4/>').html(v.albumTitle),
											$('<h6/>').html(v.artistName)
									)
							)
							.appendTo($li)
							.click(function(e){
								let $this = $(this);
								$this.siblings('.sj-for-album-item.active').removeClass('active');
								$this.addClass('active');
								$.getJSON($.ctx()+'/foryou/albums/'+v.albumSeq,d=>{
									sj.service.fy_album_dt(d.albumDt);
								})
							});
						});
						
						$('.sj-for-album-item:first').addClass('active');
						
						sj.service.fy_album_dt(ald);
					}
					
					// for - artist
					
					$('<div/>')
					.addClass('clearfix')
					.attr({id:'for-artist-con', 'style':'margin-bottom:0px;'})
					.append(
							$('<div/>').addClass('container').append(
									$('<div/>').addClass('row').append(
											$('<div/>').addClass('col-xs-12').append(
													$('<div/>')
													.attr({'style':'padding:8rem 5rem 5rem;align-items:center;border:1px solid #EEEEEE;'})
													.addClass('sj-music-content sj-d-flex sj-flex-wrap').append(
															$('<p/>').addClass('sj-foryou-theme').html('Artist <span style="color:#F6B352;">For</span> You'),
															$('<div/>').attr({id:'for-artist'}).addClass('accordian')
													)
											)
									)
							)
					).appendTo($foryouSec);
											
					if(fat.length === 0){
						$('#for-artist').remove();
						
						$('#for-artist-con p.sj-foryou-theme').after(function(){
							return $('<p/>').attr({'style':'margin-left:300px;'}).html('추천할 아티스트가 없습니다.');
						});
						$('#for-artist-con .sj-music-content').css('height','200px');
						
					}else{
						
						let $accUl = $('<ul/>').appendTo($('#for-artist'));
						$.each(fat,(i,v)=>{
							$('<li/>').append(
									$('<div/>')
									.addClass('sj-bg-img')
									.attr({'style':'background-image:url('+$.ctx()+'/resources/img/artist/'+v.imgName+'.'+v.ext+');'}),
									$('<div/>').addClass('sj-acc-img-cnt')
									.append(
										$('<p/>').html(v.artistName)
									)
							)
							.hover(function(){$(this).css("cursor","pointer")})
							.click(e=>{
								jt.search(v.artistName);
							})
							.appendTo($accUl);
						});
						
					}
					
				});
			}
		}
};

sj.service = {
		dj_pl : x=>{
			$('#sj-dj-csl').remove();
			$.getJSON($.ctx()+'/dj/'+x, d=>{
				
				$('<div/>')
				.attr({id:'sj-dj-csl'})
				.addClass('container').append(
						$('<div/>').addClass('row').append(
								$('<div/>')
								.addClass('col-xs-12 sj-dj-carousel').append(
										$('<h2/>').attr('style','margin-left: 1.2rem;').addClass('my-4').html('DJ PLAYLIST'),
										$('<div/>').attr({id : 'djCarousel'}).addClass('carousel slide')
								).on('click','.sj-dj-item',function(e){
									if(sh.service.auth() == 0 ){
										$('#djCarousel').carousel('pause');
										let $this = $(this);
										if($this.find('h4').text() != $('#sj-dt-container .sj-songs-info-title>h4').text()){
											$('#sj-dj-detail').empty();
											sj.service.dj_pld($this.attr('id'));
											$.getJSON($.ctx()+'/dj/hashs/'+$.cookie('loginID')+'/'+$this.children('label').html(),d=>{});
										}else{
											$('#sj-dj-detail').remove();
										}  
									}
								})
						)
				).appendTo($('#djSec'));
				
				let djArr = d.djlist; 
				
				if(djArr.length === 0){
				
					$('<div/>').attr({'style':'margin-left:1.2rem;'}).addClass().html('검색된 플레이리스트가 없습니다.').appendTo($('#djCarousel'));
					
				}else if(djArr.length >= 3){
					let $item = $('<div/>').addClass('carousel-inner').appendTo($('#djCarousel'));
					
					$.each(djArr,(i,v)=>{
						$('<div/>')
						.addClass('item'+((i===0)?' active':'')).append(
								$('<div/>')
								.attr({id:v.articleSeq})
								.addClass('col-md-4 col-sm-6 col-xs-12 sj-dj-item').append(
										$('<label/>').attr({'style':'display:none;'}).html(v.hash),
										$('<div/>')
										.addClass('sj-bg-img img-responsive')
										.attr({
											'style':'height:100%;background-image: url('+$.ctx()+'/resources/img/'+v.imgName+'.'+v.ext+');'
										}),
										$('<div/>').addClass('sj-dj-item-content').append(
												$('<div/>').addClass('sj-dj-content-txt').append(
														$('<h4/>').html(v.title),
														$('<p/>').html(v.memberId),
														$('<p/>').html(v.hashtag),
														$('<div/>').addClass('bg-gradients')
												)
										)
								)
						).appendTo($item);
					});
					
					$('<a/>')
					.attr({href:'#djCarousel', 'data-slide':'prev'})
					.addClass('left carousel-control')
					.append(
							$('<i/>').addClass('glyphicon glyphicon-chevron-left')
					).appendTo($('#djCarousel'));
					$('<a/>')
					.attr({href:'#djCarousel', 'data-slide':'next'})
					.addClass('right carousel-control')
					.append(
							$('<i/>').addClass('glyphicon glyphicon-chevron-right')
					).appendTo($('#djCarousel'));
					
					// Carousel jqeury
					
					$('#djCarousel .carousel-control').click(e=>{
						$('#djCarousel').carousel('cycle');
					});
					$('#djCarousel').carousel({
						  interval: 4000
						})
					$('#djCarousel .item').each(function(){
					  var next = $(this).next();
					  if (!next.length) {
					    next = $(this).siblings(':first');
					  }
					  next.children(':first-child').clone().appendTo($(this));

					  if (next.next().length>0) {
					    next.next().children(':first-child').clone().appendTo($(this));
					  }
					  else {
					    $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
					  }
					});
					
				}else{
					
					$('#djCarousel').removeClass('carousel slide');
					let $item = $('<div/>').appendTo($('#djCarousel'))
					
					$.each(djArr,(i,v)=>{
						$('<div/>').append(
								$('<div/>')
								.attr({id:v.articleSeq})
								.addClass('col-md-4 col-sm-6 col-xs-12 sj-dj-item').append(
										$('<label/>').attr({'style':'display:none;'}).html(v.hash),
										$('<div/>')
										.addClass('sj-bg-img img-responsive')
										.attr({
											'style':'height:100%;background-image: url('+$.ctx()+'/resources/img/'+v.imgName+'.'+v.ext+');'
										}),
										$('<div/>').addClass('sj-dj-item-content').append(
												$('<div/>').addClass('sj-dj-content-txt').append(
														$('<h4/>').html(v.title),
														$('<p/>').html(v.memberId),
														$('<p/>').html(v.hashtag),
														$('<div/>').addClass('bg-gradients')
												)
										)
								)
						).appendTo($item);
					});
					
				}
				
			}); // getJSON end
			
		},
		dj_pld : x=>{
			
			if(!$('#djSec').has('div[id=sj-dj-detail]').length) $('<div/>').attr({id:'sj-dj-detail'}).appendTo($('#djSec'));
			
			$.getJSON($.ctx()+'/dj/'+x+'/musics/'+$.cookie("loginID"), d=>{
				
				let djInfo = d.mlist[0];
				$('<div/>')
				.addClass('sj-padding-5r clearfix')
				.attr({id:'sj-dt-container', 'style':'margin-bottom:0px;'})
				.append(
						$('<div/>').addClass('container').append(
								$('<div/>').addClass('row').append(
										$('<div/>').addClass('col-xs-12').append(
												$('<div/>').addClass('sj-music-content sj-d-flex sj-flex-wrap').append(
														$('<div/>')
														.addClass('sj-music-content-img sj-h-100 sj-bg-img')
														.attr({'style':'background-image: url('+$.ctx()+'/resources/img/'+djInfo.imgName+'.'+djInfo.ext+');'}),
														$('<button/>').addClass('close')
														.attr({'aria-label':'Close','style':'position: absolute; right: 5px; z-index: 11; color:#383A3F; font-size:2.5em'})
														.html('<span aria-hidden="true">&times;</span>')
														.click(e=>{
															$('#sj-dj-detail').remove();
														}),
														$('<div/>').addClass('sj-music-content-songs sj-h-100').append(
																$('<div/>').addClass('sj-music-songs-info sj-mb-10 sj-d-flex sj-flex-wrap sj-align-items-center sj-justify-content-between').append(
																		$('<div/>').addClass('sj-songs-info-title').append(
																				$('<h4/>').html(djInfo.title),
																				$('<h6/>').html(djInfo.memberId),
																				$('<h6/>').html(djInfo.hashtag)
																		)
																),
																$('<div/>').addClass('sj-songs-meta').append(
																		$('<label/>').addClass('check-con').append(
																				$('<input/>').attr({type:'checkbox',name:'allCheck'})
																				.click(function(e){
																					let $this = $(this);
																					$('.sj-music-item .check-con input:checkbox').prop('checked',($this.is(':checked')?true:false));
																				}),
																				$('<span/>').addClass('sj-checkmark')
																		),
																		$('<div/>').addClass('sj-dj-title').append($('<p/>').html('제목')),
																		$('<div/>').addClass('sj-dj-artist').append($('<p/>').html('아티스트')),
																		$('<button/>').addClass('btn').html('전체듣기')
																		.click(e=>{
																			sj.service.music_player($('.sj-music-item .check-con input:checkbox'));
																		}),
																		$('<button/>').addClass('btn').html('선택듣기')
																		.click(e=>{
																			let chkBox = $('.sj-music-item .check-con input:checkbox:checked');
																			sj.service.music_player(chkBox);
																			chkBox.prop('checked', false);
																			$('input[name=allCheck]').prop('checked',false);
																		})
																),
																$('<div/>').addClass('sj-music-list-area sj-pl-scroll').attr({id:'dj-playlist-d'})
														)
												)
										)
								)
						)
				).appendTo($('#sj-dj-detail'));
				
				
				let $pl = $('<div/>').addClass('sj-music-playlist').appendTo($('#dj-playlist-d'));
				
				$.each(d.mlist,(i, v)=>{
					$('<div/>').addClass('single-music').append(
							$('<div/>').addClass('sj-music-item').append(
									$('<label/>').addClass('check-con').append(
											$('<input/>').attr({type:'checkbox', value:v.musicSeq, name:'musicCk'})
											.click(e=>{
												$('.check-con input[name=allCheck]:checkbox')
												.prop('checked',
														$('.sj-music-item .check-con input:checkbox').length
																=== $('.sj-music-item .check-con input:checked').length
																? true : false);
											}),
											$('<span/>').addClass('sj-checkmark')
									),
									$('<div/>').addClass('sj-dj-title sj-text-crop').append($('<span/>').html(v.musicTitle)),
									$('<div/>').addClass('sj-dj-artist sj-text-crop').append(
											$('<span/>').html(v.artistName)
											.hover(function(){$(this).css("cursor","pointer");})
											.click(e=>{
												jt.search(v.artistName);
											})
									),
									$('<div/>').addClass('btn-group').append(
											$('<button/>').addClass('btn ').append(
													$('<span/>').addClass('fa fa-play')
											).click(e=>{
												jt.music_player(v.musicSeq);
											}),
											$('<button/>').addClass('btn '+((v.type == 'u')?'active':'')).append(
													$('<span/>').addClass('fa fa-heart')
											).click(function(e){
												sj.service.put_ud({thiz:$(this), btn:'like', mSeq:v.musicSeq, gSeq:v.genreSeq});
											}),
											$('<button/>').addClass('btn '+((v.type == 'd')?'active':'')).append(
													$('<span/>').addClass('fa fa-thumbs-down')
											).click(function(e){
												sj.service.put_ud({thiz:$(this), btn:'hate', mSeq:v.musicSeq, gSeq:v.genreSeq});
											})
									)
							)
					).appendTo($pl)
				});
			}); // getJSON end
		},
		fy_album_dt : x=>{
			$('#for-album-dt').empty();
			$('<div/>').addClass('sj-music-songs-info sj-mb-10 sj-d-flex sj-flex-wrap sj-align-items-center sj-justify-content-between').append(
					$('<div/>').addClass('sj-songs-info-title').append(
							$('<h4/>').html(x[0].albumTitle)
							.hover(function(){$(this).css("cursor","pointer")})
							.click(e=>{
								jt.album_detail(x[0].albumSeq);
							}),
							$('<h6/>').html(x[0].artistName)
							.hover(function(){$(this).css("cursor","pointer")})
							.click(e=>{
								jt.search(x[0].artistName);
							})
					)
			).appendTo($('#for-album-dt'));
			$('<div/>').addClass('sj-songs-meta').append(
					$('<label/>').addClass('check-con').append(
							$('<input/>').attr({type:'checkbox',name:'allCheckAlbumDt'})
							.click(function(e){
								let $this = $(this);
								$('.sj-music-item .check-con input[name=albumCk]:checkbox').prop('checked',($this.is(':checked')?true:false));
							}),
							$('<span/>').addClass('sj-checkmark')
					),
					$('<div/>').addClass('sj-fya-title').append($('<p/>').html('제목')),
					$('<div/>').addClass('sj-fya-artist').append($('<p/>').html('아티스트')),
					$('<button/>').addClass('btn').html('전체듣기')
					.click(e=>{
						sj.service.music_player($('.sj-music-item .check-con input[name=albumCk]:checkbox'));
					}),
					$('<button/>').addClass('btn').html('선택듣기')
					.click(e=>{
						let chkBox = $('.sj-music-item .check-con input[name=albumCk]:checkbox:checked');
						sj.service.music_player(chkBox);
						chkBox.prop('checked',false);
						$('input[name=allCheckAlbumDt]').prop('checked',false);
					})
			).appendTo($('#for-album-dt'));
			$('<div/>').addClass('sj-music-list-area sj-pl-scroll').attr({id:'fy-al-dtmusic'}).appendTo($('#for-album-dt'));
			let $pl = $('<div/>').addClass('sj-music-playlist').appendTo($('#fy-al-dtmusic'));
			$.each(x,(i,v)=>{
				
				$('<div/>').addClass('single-music').append(
						$('<div/>').addClass('sj-music-item row').append(
								$('<label/>').addClass('check-con').append(
										$('<input/>').attr({type:'checkbox',name:'albumCk',value:v.musicSeq}).click(e=>{
											$('.check-con input[name=allCheckAlbumDt]:checkbox')
											.prop('checked',
													$('.sj-music-item .check-con input[name=albumCk]:checkbox').length
															=== $('.sj-music-item .check-con input[name=albumCk]:checked').length
															? true : false);
										}),
										$('<span/>').addClass('sj-checkmark')
								),
								$('<div/>').addClass('sj-fya-title sj-text-crop').append($('<p/>').html(v.musicTitle)),
								$('<div/>').addClass('sj-fya-artist sj-text-crop').append(
										$('<p/>').html(v.artistName)
										.hover(function(){$(this).css("cursor","pointer")})
										.click(e=>{
											jt.search(v.artistName);
										})
								),
								$('<div/>').addClass('btn-group').append(
										$('<button/>').addClass('btn').append(
												$('<span/>').addClass('fa fa-play')
										).click(e=>{
											jt.music_player(v.musicSeq);
										}),
										$('<button/>').addClass('btn '+((v.type == 'u')?'active':'')).append(
												$('<span/>').addClass('fa fa-heart')
										).click(function(e){
											sj.service.put_ud({thiz:$(this), btn:'like', mSeq:v.musicSeq, gSeq:v.genreSeq});
										}),
										$('<button/>').addClass('btn '+((v.type == 'd')?'active':'')).append(
												$('<span/>').addClass('fa fa-thumbs-down')
										).click(function(e){
											sj.service.put_ud({thiz:$(this), btn:'hate', mSeq:v.musicSeq, gSeq:v.genreSeq});
										})
								)
						)
				).appendTo($pl)
			});
		},
		fy_music_li : x=>{
			$('#fy-music-list').empty();
				
			let $pl = $('<div/>').addClass('sj-music-playlist').appendTo($('#fy-music-list'));
			
			if(x.length === 0){
				
				$('<div/>').addClass('single-music').append(
						$('<div/>').addClass('sj-music-item row').append(
								$('<p/>').attr({'style':'margin-left:300px;'}).html('해당 장르의 추천 곡이 없습니다.')
						)
				).appendTo($pl);
				
				
			}
			
			$.each(x,(i,v)=>{
				
				$('<div/>').addClass('single-music').append(
						$('<div/>').addClass('sj-music-item row').append(
								$('<label/>').addClass('check-con').append(
										$('<input/>').attr({type:'checkbox',name:'musicCk',value:v.musicSeq}).click(e=>{
											$('.check-con input[name=allCheckMusic]:checkbox')
											.prop('checked',
													$('.sj-music-item .check-con input[name=musicCk]:checkbox').length
															=== $('.sj-music-item .check-con input[name=musicCk]:checked').length
															? true : false);
										}),
										$('<span/>').addClass('sj-checkmark')
								),
								$('<div/>').addClass('sj-fym-title sj-text-crop').append($('<p/>').html(v.musicTitle)),
								$('<div/>').addClass('sj-fym-artist sj-text-crop').append(
										$('<p/>').html(v.artistName)
										.hover(function(){$(this).css("cursor","pointer")})
										.click(e=>{
											jt.search(v.artistName);
										})
								),
								$('<div/>').addClass('sj-fym-album sj-text-crop').append(
										$('<p/>').html(v.albumTitle)
										.hover(function(){$(this).css("cursor","pointer")})
										.click(e=>{
											jt.album_detail(v.albumSeq);
										})
								),
								$('<div/>').addClass('btn-group').append(
										$('<button/>').addClass('btn').append(
												$('<span/>').addClass('fa fa-play')
										).click(e=>{
											jt.music_player(v.musicSeq);
										}),
										$('<button/>').addClass('btn').append(
												$('<span/>').addClass('fa fa-heart')
										).click(function(e){
											sj.service.put_ud({thiz:$(this), btn:'like', mSeq:v.musicSeq, gSeq:v.genreSeq});
										}),
										$('<button/>').addClass('btn').append(
												$('<span/>').addClass('fa fa-thumbs-down')
										).click(function(e){
											sj.service.put_ud({thiz:$(this), btn:'hate', mSeq:v.musicSeq, gSeq:v.genreSeq});
										})
								)
						)
				).appendTo($pl);
			
			});
			
		},
		music_player:x=>{
			let seqs = '';
			$.each(x,(i,v)=>{
				seqs += v.value + ((i < x.length-1)?',':'');
			});
			jt.music_player(seqs);
		},
		l_or_h:x=>{
			if(x.hasClass('active')){
				x.removeClass('active');
			}else{
				x.addClass('active');
				if(x.siblings().hasClass('active')) x.siblings().removeClass('active'); 
			}
		},
		put_ud:x=>{
			//x = {thiz:$(this), btn : like || hate, mSeq:v.musicSeq, gSeq:v.genreSeq}
			let $this = x.thiz;
			let ms = x.mSeq, gs = x.gSeq;
			let url = (x.btn == 'like')
				? (($this.hasClass('active'))?'del':'put')+'ML/'+ms+'/'+gs
						:(($this.hasClass('active'))?'del':'put')+'MH/'+ms+(($this.siblings().hasClass('active'))?'/'+gs:'');
			if($.cookie("loginID")=='sound') $.getJSON($.ctx()+'/foryou/'+url,d=>{});
			sj.service.l_or_h($this);
		}
};


