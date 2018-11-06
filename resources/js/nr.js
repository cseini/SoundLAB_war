"use strict";
var nr = nr || {};
nr = (()=>{
	var $ctx,$js,$css,$img, w, $page, $cnts;

	var init =()=>{
        
        let nr = document.createElement('link');
        	nr.rel = 'stylesheet';
        	nr.href = $.ctx()+'/resources/css/nr.css';
        	nr.id = 'nrcss';
			document.head.appendChild(nr);
		
        $ctx = $.ctx();
        $js = $.js();
        $css = $.css();
        $img = $.img();
        w = $('#wrapper');
        w.empty();
        $page = $('<div/>').attr({id:'page'}).addClass('page');
        w.append(nav(),
        		$page.append(
        				hdr(),
        				$('<div/>').attr({id : 'cnts'}),
						ftr()
        		)
    	);
        $cnts = $('#cnts');
        home();
        
    	//버튼=========================================
    	$('#toggle-btn').click(e=>{
             e.preventDefault();
             if ($(window).outerWidth() > 1194) {
                 $('nav.side-navbar').toggleClass('shrink');
                 $('.page').toggleClass('active');
             } else {
                 $('nav.side-navbar').toggleClass('show-sm');
                 $('.page').toggleClass('active-sm');
             }
        });
    	$('#mainBtn').click(()=>{
            nr.init();
       });
    	$('#visitBtn').click(()=>{
            home();
       });
    	$('#prefBtn').click(()=>{
            pref();
       });
    	$('#artistBtn').click(()=>{
            artist();
       });
    	$('#hashBtn').click(()=>{
            hash();
       });
    }; 

    // ============================= 페이지 ============================
    var home =()=>{
    	$cnts.empty();
    	section().addClass("dashboard-counts section-padding").appendTo($cnts);
    	cnt({src:"https://static.thenounproject.com/png/1892501-200.png",
    		strong:"New Clients",
    		span:"오늘의 새로운 고객 수",
    		id:"new_user"
    		}).appendTo($("#row"));
    	cnt({src:"https://static.thenounproject.com/png/738103-200.png",
    		strong:"Streaming count",
    		span:"스트리밍 수 ",
    		id:"streaming"
    		}).appendTo($("#row"));
    	
    	section2().addClass("d-flex align-items-md-stretch").appendTo($cnts);
    	card({size:"12", title:"일주일 간의 방문통계", id:"visiterChart",style:"height:500px"}).appendTo($("#row2"));
    	
    	$.getJSON($.ctx()+'/admin/visit',d=>{
			$('<p/>').html(d.nu).appendTo($("#new_user"));
			$('<p/>').html(d.st.strm).appendTo($("#streaming"));
			
			let data=[["date","남","여","합계"]];
			$.each(d.vcha, (k,v)=>{
				let trans=x=>{
					let month=new Date(x).getMonth()+1;
					let day=new Date(x).getDate();
					return month+"월 "+day+"일";
				};
				data.push([trans(new Date(v.date)), v.mVisit*1, v.fVisit*1, v.mVisit+v.fVisit]);
			});
			
			google.charts.load('current', {'packages':['corechart']});
		    google.charts.setOnLoadCallback(()=>{
		    	let dataTbl = google.visualization.arrayToDataTable(data);
		    	let options = {
				          hAxis: {title: '방문 일자',  titleTextStyle: {color: '#333'}},
				          vAxis: {minValue: 0}
				        };
		    	let chart = new google.visualization.AreaChart(document.getElementById('visiterChart'));
		        chart.draw(dataTbl, options);
		    });
		});
    };
    
    var pref=()=>{
    	$('nav.side-navbar').toggleClass('show-sm');
        $('.page').toggleClass('active-sm');
    	
        $cnts.empty();
        section().addClass("forms").appendTo($cnts);
    	card({size:"3", title:"10대 장르 선호도", id:"donutchart1",style:""}).appendTo($("#row"));
    	card({size:"3", title:"20대 장르 선호도", id:"donutchart2",style:""}).appendTo($("#row"));
    	card({size:"3", title:"30대 장르 선호도", id:"donutchart3",style:""}).appendTo($("#row"));
    	card({size:"3", title:"40대 장르 선호도", id:"donutchart4",style:""}).appendTo($("#row"));
    	card({size:"12", title:"연령별 아티스트 선호도 TOP3", id:"columnchartAA",style:"height:400px"}).appendTo($("#row"));
    	card({size:"6", title:"성별 장르 선호도", id:"barChartSG",style:""}).appendTo($("#row"));
    	card({size:"6", title:"성별 아티스트 선호도", id:"barChartSA",style:""}).appendTo($("#row"));
    	
    	nr.chart.age_genre(1);
    	nr.chart.age_genre(2);
    	nr.chart.age_genre(3);
    	nr.chart.age_genre(4);
    	nr.chart.age_artist();
    	nr.chart.sex_artist();
    	nr.chart.sex_genre();
    	nr.chart.toplist();
    };
    var artist=()=>{
    	$cnts.empty();
    	section().addClass("forms").appendTo($cnts);
    	$('<div/>').addClass("form-group row").append(
    			$('<label/>').addClass("col-sm-2 form-control-label").html("아티스트 선택"),
				$('<form/>').append(
					$('<div/>').addClass("col-sm-3 mb-3").append(
    					$('<select/>').addClass("form-control").attr({id:"artist_name" ,name:"account"}).append(
	    					$('<option/>').html("방탄소년단"),
	    					$('<option/>').html("트와이스"),
	    					$('<option/>').html("레드벨벳")
	    					)
    					),
    				$('<button/>').addClass("nr-btn nr-btn-primary").html("선택").attr({id:"artiBtn", style:"font-size:1.4rem"})
    					.click(e=>{
    						e.preventDefault();
    						$('#arti_area').empty();
    						card({size:"12", title:$('#artist_name').val()+" 분석", id:"artiCha", style:"height:500px"}).appendTo($("#arti_area"));
    						card({size:"6", title:$('#artist_name').val()+"의 성별 선호도", id:"arti_mf",style:""}).appendTo($("#arti_area"));
    						card({size:"6", title:$('#artist_name').val()+"의 연령 선호도", id:"arti_age",style:""}).appendTo($("#arti_area"));
    						nr.arti.stats();
    					})
				)
				).appendTo($("#row"));
    	$('<div/>').attr({id:"arti_area"}).appendTo($('#row'));
    };
    var hash=()=>{
    	$cnts.empty();
    	section().addClass("forms").appendTo($cnts);
    	$('<div/>').attr({id:"treemap"}).appendTo($("#row"));

    	$.getJSON($.ctx()+'/admin/hash',d=>{
    		 google.charts.load('current', {'packages':['treemap']});
        	 google.charts.setOnLoadCallback(()=>{
        		let data=new google.visualization.DataTable();
        		data.addColumn('string', '2차 해시태그');
       	     	data.addColumn('string', '1차해시태그');
       	     	data.addColumn('number', '스트리밍 수');
       	     	data.addRow(['해시태그', null, 0]);
       	     	let hash_theme=['뮤직스타일','상황&장소','감정&기분'];
	       		for(let i=0;i<hash_theme.length;i++){
	       			data.addRow([hash_theme[i],'해시태그',null]);
	       		}
	       		for(let i=0;i<hash_theme.length;i++){
	       			$.each(d.hs, (k,v)=>{
	   	    			if(v.hashSeq>=(i+1)*5-4 && v.hashSeq<=(i+1)*5){
	   	    				data.addRow([v.hash, hash_theme[i], v.countView]);
	   	    			}
	       			});
	       		}
	       		let tree = new google.visualization.TreeMap(document.getElementById('treemap'));
	       		let options = {
         		           highlightOnMouseOver: true,
         		           fontSize: 25,
         		           maxDepth: 1,
         		           maxPostDepth: 2,
         		           minColor: '#edf8fb',
         		           midColor: '#9ebcda',
         		           maxColor: '#8c6bb1',
         		           headerHeight: 15,
         		           showScale: true,
         		           height: 500,
         		           useWeightedAverageForAggregation: true
         		         };
         		 tree.draw(data, options);
        	 });
    	});
    };
    
    
 // ============================= 구성 ============================
    var table=x=>{
    	//nr.table({thead:["순위","곡명","가수","좋아요수"],row, ms, an, count});

    	let tbl = $('<table/>').addClass("table table-striped table-hover");
    	let thead = $('<thead/>').appendTo(tbl);
    	let tr1 = $('<tr/>').appendTo(thead);
    	let tbody = $('<tbody/>').appendTo(tbl);
    	
    	for(let i=0;i<x.thead.length;i++){
    		let th= $('<th/>').html(x.thead[i]).appendTo(tr1);
    	};
    	for(let i=0;i<x.count.length;i++){
    		let tr2 = $('<tr/>').appendTo(tbody);
    		let row =$('<th scope="row"/>').html(x.row[i]).appendTo(tr2);
    		let td1 = $('<td/>').html(x.ms[i]).appendTo(tr2);
    		let td2 = $('<td/>').html(x.an[i]).appendTo(tr2);
    		let td3 = $('<td/>').html(x.count[i]).appendTo(tr2);
    	};
    	
    	let tdiv=$('<div/>').addClass("col-lg-6").append(
    			$('<div/>').addClass("card").append(
    					$('<div/>').addClass("card-header").append(
    							$('<h4/>').html(x.title)),
						$('<div/>').addClass("card-body").append(
								$('<div/>').attr({id:"tblRes"}).addClass("table-responsive").append(tbl))
					)
				);
    	if($("#arti_area").length==1){
    		tdiv.appendTo($("#arti_area"));
    	}else {
    		tdiv.appendTo($("#row"));
    	}
    	return tdiv;
    };
    var section=()=>{
		return $('<section/>').append(
					$('<div/>').addClass("container-fluid").append(
						$('<div/>').attr({id:"row"}).addClass("row")));
	};
	var section2=()=>{
		return $('<section/>').append(
					$('<div/>').addClass("container-fluid").append(
						$('<div/>').attr({id:"row2"}).addClass("row")));
	};

    var cnt=x=>$('<div/>').addClass("col-md-6").append(
			$('<div/>').addClass("wrapper count-title d-flex").append(
					$('<div/>').addClass("col-md-3").append(
						$('<img/>').addClass("nr-cnt-img").attr({src:x.src})
					),
					$('<div/>').addClass("name col-md-3").append(
						$('<strong/>').addClass("text-uppercase").html(x.strong),
						$('<br/>'),
						$('<span/>').attr({id:"cnt_date"}).html(x.span),
						$('<div/>').addClass("count-number").attr({id:x.id})
					)
			));
    
	var visit=()=>{
		let visit=
			$('<div/>').addClass("col-lg-12 flex-lg-last flex-md-first align-self-baseline").append(
				$('<div/>').addClass("card sales-report").append(
					$('<h2/>').addClass("display h4").html("방문자 통계"),
					$('<p/>').html("차트를 입력해주세요"),
					$('<div/>').attr({id:"visiterChart"})
				)
			);
		return visit;
	};
	
	var card=x=>{
		let card=$('<div/>').addClass("col-lg-"+x.size).append(
				$('<div/>').addClass("card line-chart-example").append(
				$('<div/>').addClass("card-header d-flex align-items-center").append(
						$('<h4/>').html(x.title)
						),
				$('<div/>').addClass("card-body").append(
						$('<div/>').attr({id:x.id, style:x.style}))
				)
			);
		return card;
	};

	var nav = ()=>{
		let $nav = $('<nav/>');
		 $($nav).addClass("side-navbar").append(
					$('<div/>').addClass("side-navbar-wrapper").append(
							$('<div/>').addClass("sidenav-header d-flex align-items-center justify-content-center").append(
								$('<div/>').addClass("sidenav-header-inner text-center").append(
									$('<img/>')
									.attr({
										src:$.img()+"/logo_admin.png",
										alt:"SoundLAB 로고",
										style:"resize: both"
									}).click(e=>{
										nr.init();
									})
								),
								$('<div/>').addClass("sidenav-header-logo").append(
									$('<a/>').addClass("brand-small text-center").attr({href:"#"})
								)
							),
							$('<div/>').addClass("main-menu").append(
									$('<h5/>').addClass("sidenav-heading").html("MAIN"),
									$('<ul/>').addClass("side-menu list-unstyled").attr({id:"side-main-menu"}).append(
										$('<li/>').append(
											$('<a/>').attr({id:"visitBtn", href:"#"}).append(
												$('<i/>').addClass("fa fa-bar-chart").html('  방문통계'))),
										$('<li/>').append(
											$('<a/>').attr({id:"prefBtn", href:"#"}).append(
												$('<i/>').addClass("fa fa-bar-chart").html('  선호도'))),
										$('<li/>').append(
											$('<a/>').attr({id:"artistBtn", href:"#"}).append(
												$('<i/>').addClass("fa fa-bar-chart").html('  아티스트'))),
										$('<li/>').append(
											$('<a/>').attr({id:"hashBtn", href:"#"}).append(
												$('<i/>').addClass("fa fa-bar-chart").html('  해시태그')))
									)
								)
						)		
		);
		return $nav;
	};
	var hdr =()=>{
		let $header =$('<header/>').addClass("header");
		let $nav = $('<nav/>').appendTo($header);
		$nav.addClass("navbar").append(
			$('<div/>').addClass("container-fluid").append(
				$('<div/>').addClass("navbar-holder d-flex align-items-center justify-content-between").append(
					$('<div/>').addClass("navbar-header").append(
						$('<a/>').addClass("menu-btn").attr({id:"toggle-btn",href:"#"}).append(
							$('<i/>').addClass("fa fa-bars")).attr({style:"font-size:20px"}),
						$('<a/>').addClass("navbar-brand").attr({href:"#"}).append(
							$('<div/>').addClass("brand-text d-none d-md-inline-block").append(
								$('<span/>').html("ADMIN"),
								$('<strong/>').addClass("text-primary").html("SoundLAB").click(e=>{
									nr.init();
									})))
					),
					$('<ul/>').addClass("nav-menu list-unstyled d-flex flex-md-row align-items-md-center").append(
						$('<li/>').addClass("nav-item").append(
							$('<a/>').addClass("nav-link logout").attr({id:"logoutBtn",href:"#",style:"float:right"}).append(
								$('<span/>').addClass("d-none d-sm-inline-block").html("Logout")
								.click(e=>{
									$('#nrcss').remove();
									$.removeCookie("loginID");
								   setTimeout(()=>{
									   sh.service.login(); 
									},1);
								}),
								$('<i/>').addClass("fa fa-sign-out")
							)))
				)
			)
		);
		return $header;
	};
	
	var ftr=()=>{
		let $footer = $('<footer/>').addClass("nr-footer").append(
				$('<div/>').addClass("container-fluid").append(
						$('<div/>').addClass("row").append(
								$('<div/>').addClass("col-sm-6").append(
										$('<p/>').html("2018")
								),
								$('<div/>').addClass("col-sm-6 text-right").append(
										$('<p/>').html("SoundLAB")
								)
						)
				)
			);
		 
		return $footer;
	}
	return {
		init : init,
		table : table
	};
})();

nr.chart={
		age_genre:x=>{
				$.getJSON($.ctx()+'/admin/pref',d=>{
					let data=[['장르','선호도']];
	    	    	$.each(d.AG, (k,v)=>{
	    	    		if(v.ageGroup==x+"0대"){
	    	    			data.push([v.genreName, v.sumGood]);
	    	    		}
	    	    	});
					google.charts.load("current", {packages:["corechart"]});
		    	    google.charts.setOnLoadCallback(()=>{
		    	    	let datas = google.visualization.arrayToDataTable(data);
		    	    	let options =  {
		    	    			chartArea:{left:10,top:20,width:"85%",height:"85%"},
		    	    		    pieHole: 0.3,
		    			        };
		    	    	let chart = new google.visualization.PieChart(document.getElementById('donutchart'+x));
				        chart.draw(datas, options); 
		    	    
		    	    });
				});
    	},
		age_artist:()=>{
			$.getJSON($.ctx()+'/admin/pref',d=>{
				
				let data =[],key=["연령"],g10=["10대"],g20=["20대"],g30=["30대"],g40=["40대"];
				$.each(d.AA,(k,v)=>{
					key.push(v.artistName);
				});
				let unique = key.reduce(function(i,j){
					if(i.indexOf(j)<0) i.push(j);
					return i;
				},[]);
				$.each(d.AA, function(k,v){
					if(v.ageGroup=="10대"){
						g10.push(v.sumGood);
					}else if(v.ageGroup=="20대"){
						g20.push(v.sumGood);
					}else if(v.ageGroup=="30대"){
						g30.push(v.sumGood);
					}else if(v.ageGroup=="40대"){
						g40.push(v.sumGood);
					}
				});
				
					data.push(unique,g10,g20,g30,g40);
					google.charts.load('current', {'packages':['bar']});
					google.charts.setOnLoadCallback(()=>{
		    	    	let dataTbl = google.visualization.arrayToDataTable(data);
		    	    	let options = {
		    	  	        };
		    	    	let chart = new google.charts.Bar(document.getElementById('columnchartAA'));
			  	        chart.draw(dataTbl, google.charts.Bar.convertOptions(options));
		    	    });
			});
		},
		sex_genre:()=>{
			$.getJSON($.ctx()+'/admin/pref',d=>{
				let data =[];
				let key=["장르"];
				let male=["남"];
				let female=["여"];
				$.each(d.SG,(k,v)=>{
					key.push(v.genreName);
				});
				let unique = key.reduce(function(i,j){
					if(i.indexOf(j)<0) i.push(j);
					return i;
				},[]);
				$.each(d.SG,(k,v)=>{
					if(v.MF==="M"){
						male.push(v.sumGood);
					}else if(v.MF==="F"){
						female.push(v.sumGood);
					}
				});
				data.push(unique,male,female);
				google.charts.load("current", {packages:["corechart"]});
			    google.charts.setOnLoadCallback(()=>{
			    	let dataTbl = google.visualization.arrayToDataTable(data);
			    	let options = {
			    	          isStacked: 'percent',
			    	          height: 300,
			    	          legend: {position: 'top', maxLines: 3},
			    	          hAxis: {
			    	            minValue: 0,
			    	            ticks: [0, .3, .6, .9, 1]
			    	          }
			    	        };
			    	let chart = new google.visualization.BarChart(document.getElementById("barChartSG"));
			        chart.draw(dataTbl, options);
			    
			    });
			});
		},
		sex_artist:()=>{
			$.getJSON($.ctx()+'/admin/pref',d=>{
				let data =[];
				let key=["아티스트"];
				let male=["남"];
				let female=["여"];
				$.each(d.SA,(k,v)=>{
					key.push(v.artistName);
				});
				
				let unique = key.reduce(function(i,j){
					if(i.indexOf(j)<0) i.push(j);
					return i;
				},[]);
				$.each(d.SA,(k,v)=>{
					if(v.MF==="M"){
						male.push(v.sumGood);
					}else if(v.MF==="F"){
						female.push(v.sumGood);
					}
				});
				data.push(unique,male,female);
				
				google.charts.load("current", {packages:["corechart"]});
			    google.charts.setOnLoadCallback(()=>{
			    	let dataTbl = google.visualization.arrayToDataTable(data);
			    	let options = {
			    	          isStacked: 'percent',
			    	          height: 300,
			    	          legend: {position: 'top', maxLines: 3},
			    	          hAxis: {
			    	            minValue: 0,
			    	            ticks: [0, .3, .6, .9, 1]
			    	          }
			    	        };
			    	let chart = new google.visualization.BarChart(document.getElementById("barChartSA"));
			        chart.draw(dataTbl, options);
			    });
			});
		},
		toplist:()=>{
			$.getJSON($.ctx()+'/admin/pref',d=>{
				let row = [];
				let ms=[];
				let an=[];
				let count=[];
				
				let bms=[];
				let ban=[];
				let bcount=[];
				
				for(let i=1;i<=5;i++){
					row.push(i);
				};
				$.each(d.goodlist, (k,v)=>{
					ms.push(v.musicTitle);
					an.push(v.artistName);
					count.push(v.sumGood);
				});
				$.each(d.badlist, (k,v)=>{
					bms.push(v.musicTitle);
					ban.push(v.artistName);
					bcount.push(v.sumBad);
				});
		    	nr.table({title:"전체 사용자의  좋아요 TOP 5",thead:["순위","곡명","가수","좋아요수"],row, ms, an, count});
				nr.table({title:"전체 사용자의  싫어요 TOP 5",thead:["순위","곡명","가수","싫어요수"],row, ms:bms, an:ban, count:bcount});
			});
		}
},
nr.arti={
		stats:()=>{
			$.getJSON($.ctx()+'/admin/artist/'+$('#artist_name').val(),d=>{
		//아티스트 관계 차트			
				let artiGS = [['곡 명','스트리밍 수','좋아요 수','앨범 명','스트리밍*좋아요']];
				let tempS=30000;
				$.each(d.GS, function(k, v){
					artiGS.push([v.musicTitle, v.sumStr+tempS, v.sumGood*10, v.albumTitle, 
						(v.sumStr+tempS)*(v.sumGood)]);
					tempS=tempS-30;
				});
				google.charts.load("current", {packages:["corechart"]});
				google.charts.setOnLoadCallback(()=>{
					let data = google.visualization.arrayToDataTable(artiGS);
					let options = {
				        title: $('#artist_name').val()+'의 스트리밍 수와 좋아요 수 상관관계 ',
				        hAxis: {title: '스트리밍 수'},
				        vAxis: {title: '좋아요 수'},
				        bubble: {
				          textStyle: {
				            fontSize: 12,
				            color: 'green',
				            bold: true,
				            italic: true
				          }
				        }
				      };
					let chart = new google.visualization.BubbleChart(document.getElementById('artiCha'));
				      chart.draw(data, options);
				});
				
		//아티스트 성별 차트			
				let data_mf =[["아티스트","남자","여자"],
						      [d.mf.artistName, d.mf.m, d.mf.f]];
				
				google.charts.setOnLoadCallback(()=>{
					let data=google.visualization.arrayToDataTable(data_mf);
					let view = new google.visualization.DataView(data);
				      view.setColumns([0, 
				    	  				1,{ calc: ()=>{
				    	  					let p = (100*d.mf.m/(d.mf.m+d.mf.f)).toFixed(2)+'%'
				    	  					return {v:'percent', f:p};
				    	  					},
				                         sourceColumn: 1,
				                         type: "string",
				                         role: "annotation"},
				                        2,{ calc: ()=>{
				    	  					let p = (100*d.mf.f/(d.mf.m+d.mf.f)).toFixed(2)+'%'
				    	  					return {v:'percent', f:p};
				    	  					},
				                         sourceColumn: 2,
				                         type: "string",
				                         role: "annotation"}]);
					let options = {
							 annotations: {
								    textStyle: {
								      fontSize: 18,
								      bold: true,
								      italic: true,
								    }
								  },
			    	          isStacked: 'percent',
			    	          legend:'none',
			    	          hAxis: {textPosition : 'none'},
			    	          vAxis: {textPosition : 'none'}
						};
					let chart = new google.visualization.BarChart(document.getElementById("arti_mf"));
			        chart.draw(view, options);
				});
		//아티스트 나이 차트	
				let data_age=[["연령","남","여"]];
				$.each(d.artiAG,(k,v)=>{
					data_age.push([v.ageGroup,v.m,v.f]);
				});
				
				google.charts.load('current', {'packages':['bar']});
				google.charts.setOnLoadCallback(()=>{
					let data =google.visualization.arrayToDataTable(data_age);
					let options = {
						};
					let chart = new google.charts.Bar(document.getElementById('arti_age'));
			  	        chart.draw(data, google.charts.Bar.convertOptions(options));
				});
				
				//테이블
				let row = [];
				let ms=[];
				let an=[];
				let count=[];
				let bms=[];
				let ban=[];
				let bcount=[];
				
				for(let i=1;i<=5;i++){
					row.push(i);
				};
				$.each(d.goodlist, (k,v)=>{
					ms.push(v.musicTitle);
					an.push(v.artistName);
					count.push(v.sumGood);
				});
				$.each(d.badlist, (k,v)=>{
					bms.push(v.musicTitle);
					ban.push(v.artistName);
					bcount.push(v.sumBad);
				});
				
		    	nr.table({title:$('#artist_name').val()+"의  좋아요 TOP 5",thead:["순위","곡명","가수","좋아요수"],row, ms, an, count});
				nr.table({title:$('#artist_name').val()+"의  싫어요 TOP 5",thead:["순위","곡명","가수","싫어요수"],row, ms:bms, an:ban, count:bcount});
			}); 
		}
}
