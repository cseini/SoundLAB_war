<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
 <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>신승호</title>

    <!-- Bootstrap core CSS -->
    <link href="${context}/resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">

    <!-- Custom styles for this template -->
  	<link href="${context}/resources/css/resume.css" rel="stylesheet">
  	
  	<!-- 아이콘 -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous">
  </head>

  <body id="page-top">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <span class="d-block d-lg-none"> </span>
        <span class="d-none d-lg-block">
          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="${context}/resources/img/shinseungho.jpg" alt="">
        </span>
      </a>
        <span class="navbar-toggler-icon"></span>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#about"> - about</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#experience"> - portfolio</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#education"> - EDUCATION</a>
          </li>

         
        </ul>
      </div>
    </nav>

    <div class="container-fluid p-0">

      <section class="resume-section p-3 p-lg-5 d-flex d-column" id="about">
        <div class="my-auto">
          <h2 class="mb-0">신승호
            <span class="text-primary">(Shin Seung Ho)</span>
          </h2>
          <div class="subheading mb-5"> 010-3365-0158 ·
            <a>kanu0158@naver.com</a>
          </div>
          <p class="lead mb-5">    </p>
     
        </div>
        <div class="my-auto">
          <h2 class="mb-5">Skills</h2>

          <div class="subheading mb-3">Programming Languages &amp; Tools</div>
          <ul class="list-inline dev-icons">
              <li class="list-inline-item">
              <i class="fab fa-java"></i>
            </li>
            <li class="list-inline-item">
              <i class="fab fa-html5"></i>
            </li>
            <li class="list-inline-item">
              <i class="fab fa-css3-alt"></i>
            </li>
            <li class="list-inline-item">
              <i class="fab fa-js-square"></i>
            </li>
             <li class="list-inline-item">
              <i class="fab fa-android"></i>
            </li>
          </ul>
			<br><br><br><br><br><br>
          <div class="subheading mb-5">Workflow</div>
          <ul class="ls_fa-ul mb-0">
            <li>
              <i class="fa-li fa fa-check"></i>
              	프로그래밍 언어: Java, Javascript, html5, css3, Jquey, xml, sql(oracle,mysql)
              	</li>
            <li>
              <i class="fa-li fa fa-check"></i>
       	   	    프레임워크 구축: Spring, MyBatis, Tiles, JUnit, Spring Boot, MVC</li>
            <li>
              <i class="fa-li fa fa-check"></i>
          	    데이터베이스: Oracle, MySQL, ANSI SQL, DB모델링</li>
            <li>
              <i class="fa-li fa fa-check"></i>
             	개발자도구: Eclipse, Spring Tool Suite, Visual Studio, 
             Android Studio, Genymotion, Git, SourceTree, 
             Tomcat</li>
             <li>
              <i class="fa-li fa fa-check"></i>
             	구현 기술: jQuery, Ajax, Bootstrap, RESTful, Zen-coding, FTP업로드, Putty</li>
          </ul>
          
        </div>
      </section>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="experience">
          <h2 class="mb-5">portfolio</h2>

          <div class="resume-item d-flex flex-column flex-md-row mb-5">
            <div class="resume-content mr-auto">
              
              <div class="subheading mb-3">음악 스트리밍 사이트</div><br>
          		<a href="${context}/main" class="moveSoundLAB">SoundLAB 이동하기 </a>
		 <p>ㅇ  sound 아이디로 로그인 하면 모든 서비스 이용이 가능합니다.</p>
         <p>ㅇ  관리자페이지는 관리자 아이디로 로그인해야 이용할 수 있습니다.</p>
         <p>&ensp;&ensp;&ensp;사용자페이지 ID [ sound ] , PASS [ sound ]</p>
         <p>&ensp;&ensp;&ensp;관리자페이지 ID [ admin ] , PASS [ admin ]</p>
         <p>ㅇ  웹플레이어 실행을 위해선 팝업차단을 해제해주셔야합니다.</p>
         <p>ㅇ 검색 가능한 아티스트 목록 (Full Name으로 적어주셔야합니다.)</p>
          <p>&ensp;&ensp;&ensp;[선미, 빈지노, 아이유, 임창정, 방탄소년단, 에이핑크, 로꼬, 바이브, 아이콘, 로이킴, 폴킴, 블랙핑크,</p>
          <p>&ensp;&ensp;&ensp;트와이스, 레드벨벳, 10cm, 볼빨간사춘기, 마마무, 박원, 윤종신, 벤, 멜로망스, 먼데이키즈, 박효신, 장범준]</p>
          <br><br>
              <div>
             	  <img  src="${context}/resources/img/soundlab_main.jpg" 
             	   class = "portImg" >
             
             		 <img  src="${context}/resources/img/soundlab_maincontents.jpg" 
             		class = "portImg">
             		
             		<img  src="${context}/resources/img/soundlab_login.jpg" 
             		class = "portImg">
              </div>
              
              <div class = "pfcontent">
              <br>
               <br>
              <p>- 음악 스트리밍을 이용자들이 클릭한 음악 재생을 기준으로 차트가 실시간으로 변화 하도록 하는 것을 목표로 사이트를 구현하였습니다.</p> 
               <p>-  실제 현업에서의 진행과정과 유사한 환경으로 프로젝트를 진행하기 위해 아침에는 팀 회의를 하면서 각자 진행 상황과 오늘 GOAL을 체크하였고 저녁에는 GIT과 SourceTree를 사용하여 팀원들의 브랜치를 머지함으로써 형상관리를 했습니다.  </p> 
                <p>- 메인 툴은 STS 3.9.6 버전을 사용했고 Spring5 와 Tomcat9을 바탕으로 RESTful한 방식으로 서버단을 구현했습니다.  </p> 
                 <p>- Mybatis로 sql문과 java단을 분리하여 Back을 구현했으며 Front는 js, css, Bootstrap, jquery, Ajax를 이용한 비동기 방식으로 SPA를 구현했습니다. Database는 AWS의 Mariadb를 사용하였으며 웹서버는 AWS에 업로드하여 구현했습니다.  </p> 
                  <p>- 프로젝트에서 제가 맡은 직책은 팀장으로서 전반적인 프로젝트 진행 및 취합과 기본 구조 설계, DB 설계 & 관리를 하였고   </p> 
                   <p>- 메인페이지(d3.js, wordcloud, 차트 등)와 권한(interceptor) 및 MEMBER관련 부분을 담당하였습니다. 그리고 Kakao REST API를 활용한 로그인 방법을 추가하였습니다.   </p> 
                    <p>- 팀장으로서 팀 프로젝트를 전반적으로 진행하면서 느낀 점은 크게 두 가지가 있습니다.  </p> 
                     <p>- 첫 번째는 촉박한 일정 속에서도 서로의 의견을 잘 화합하여 빠르게 한 방향으로 나아갈 수 있도록 하려면 명확한 역할 분담을 할 필요가 있다는 점입니다. 담당자가 명확해지면 문제점도 더 빠르게 찾아 해결할 수 있고 그로 인해 일하는 사람과 관리자는 판단을 더 빠르게 할 수 있다는 것을 느꼈습니다. </p> 
                      <p>- 두 번째는 프로젝트를 진행하며 맞닥뜨린 현실적인 문제들에 관한 것입니다.  </p> 
                       <p>- 음악 관련 dummy를 무료로 제공해주는 API를 찾을 수 없었고 그 수 많은 데이터를 다 넣는다는 것은 시간상으로, 물질적으로 불가능하였기 때문에 일부분만을 넣을 수밖에 없었습니다. 그래도 꽤 많은 데이터를 넣어서 저희가 원하는 차트를 관리자페이지에서 뽑아낼 수 있었기에 다행이었지만 아쉬웠습니다.  </p> 
            </div>
          
</div>
         
         
         
         
        </div>
        <br> <br> <br> <br> <br>
			 <div class = "pfContent2">			 
			 <p> [ 사용 기술  ] </p>
			 <p> - OS 및 DB : MySQL </p>
			 <p> - 사용 Tool : sts </p>
			 <p> - 프로그래밍 언어 : JAVA, Servlet, JSP</p>
			 <p> - 웹 표준 기술 : HTML5, CSS, JAVAScript, JQuery,Ajax</p>
			 <p> - 프레임 워크 : Spring, MyBatis, IBatis, Bootstrap, google Chart</p>
			 </div>
      </section>

      <hr class="m-0">

      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="education">
        <div class="my-auto">
          <h2 class="mb-5">Education</h2>

          <div class="resume-item d-flex flex-column flex-md-row mb-5">
            <div class="resume-content mr-auto">
             <h3 class="mb-0">비트 캠프</h3>
              <h3 class="mb-0">UI/UX 기반의 자바개발자 양성과정</h3>
            </div>
            <div class="resume-date text-md-right">
              <span class="text-primary">May - November 2018</span>
            </div>
          </div>
          <div class = "edContent">
           <p>[ 교육 이수 현황 ]</p>
				 <p>프로그래밍 언어: Java, Javascript, html5, css3</p>
				  <p> - Java</p>
				 <p>Java의 기본 문법과 객체지향적 특징 숙지, 자료구조인 Map, LIst등을 자유롭게 사용 가능.</p>
				 <p>Java 디자인 패턴 중 중요한 팩토리, 템플릿 메소드, 데코레이션, 싱글톤 패턴 등 실무 적용 가능.</p>
				 <p>Java 8 가능 (lambda)</p>
				 <p>aop기반 callback 처리 가능</p>
				 <p>  - JavaScript</p>
				 <p>JavaScript 를 객체화 시켜서 재활용 및 함수 호출에 맞게 운용 가능.</p>
				 <p>기본 JavaScript 보다 발전된 함수형 프로그래밍이 가능.</p>
				   <p>- HTML5</p>
				 <p>예전 방식인 XHTML 방식을 탈피하여, 새로운 흐름인 HTML5 방식으로 UI 를 구성 가능. </p>
				 <p>  - CSS</p>
				 <p>HTML5 에 호환성을 가지는 CSS3 버전을 구현 가능.</p>
				 <p>웹퍼블리싱에 필요한 기본적인 기술 보유.</p>
				
			 <p>	프레임워크 구축: Spring, MyBatis, Tiles, JUnit, Spring Boot, MVC</p>
				 <p>  - Spring</p>
			 <p>	STS를 사용하여 표준 스프링 프레임워크를 직접 설정 가능.</p>
			 <p>	추가 플러그인 구현., 연동 프레임워크와 호환성에 맞게 구축 가능.</p>
			 <p>	  - MyBatis</p>
			 <p>	mybatis 설정에서 중요한 datasource 개념을 알고 있으며, 각종 mapper 의 설정도 직접 처리 가능. </p>
			 <p>	인터페이스 고도화를 통한 MapperImpl 을 생략하고 직접 서비스단과 연결하여 처리 함.</p>
			 <p>	그에 따른 코드의 수를 줄이고 생산성을 높일 수 있음.</p>
			 <p>	동적 SQL  실무 적용 가능.</p>
			 <p>	  - tiles</p>
			 <p> 	타일즈 설정 및 운영 방식을 정확하게 이해, 직접 구현하여 사용 가능.</p>
			 <p>	타일즈의 definition 상속 기능을 활용 및 응용 가능.</p>
				
			 <p>	데이터베이스: Oracle, MySQL, ANSI SQL, DB모델링</p>
			 <p>	  - Oracle</p>
			 <p>	DB를 직접 설치 및 설정 가능.</p>
			 <p>	사용 툴인 TOAD 와 SQL developer 사용 가능.</p>
			 <p>	MySQL로 마이그레이션 가능.</p>
			 <p>	  - MySQL</p>
			 <p>	DB를 직접 설치 및 설정 가능,</p>
			 <p>	사용 툴인 TOAD, SQL developer 사용 가능. </p>
			 <p>	  - ANSI SQL</p>
			 <p>	CRUD 관련 쿼리는 기본적으로 구현 가능.</p>
			 <p>	JOIN 에 대한 다양한 문법 사용 가능.</p>
			 <p>	복잡한 페이징 쿼리, 통계 쿼리 같은 복잡한 쿼리도 구현 가능.</p>
			 <p>	  - DB 모델링</p>
			 <p>	다른 데이터 모델 간 엔티티 맵핑 관계를 정의하고, 교차 엔티티 구현 가능.</p>
				
			 <p>	개발자도구: Eclipse, Spring Tool Suite, Visual Studio, Android Studio, </p>
			<p> Notepad++, Genymotion, Git, SourceTree, Tomcat 8, WebStorm, tomcat 9.0</p>
				
			 <p>	구현 기술: jQuery, Ajax, Bootstrap, RESTful, Zen-coding, FTP업로드, Putty</p>
				 <p>  - jQuery</p>
			 <p>	jQuery 문법과 활용법을 숙지하였으며, 다양한 응용 가능. UI를 구성함에 jQuery-ui  활용 가능.</p>
				 <p>  - Bootstrap</p>
			 <p>	빠르고 쉬운 웹 화면개발 프레임워크인 부트스트랩 설정 및 활용 가능.</p>
			 <p>	반응형 요소를 구현 가능, 사용자 정의를 하기 위한 HTML5 와 CSS 추가적인 활용 가능.</p>
			 <p>	  - Ajax</p>
			 <p>	비동기 데이터 처리방식인 Ajax를 이해하고, 이를 통한 자바 컨트롤러와 통신을 통해 URL 과 값 전달 가능.</p>
			 <p>	JSON 의 개념을 이해하고, 데이터 타입으로서 JSON의 활용을 자유롭게 구현 가능.</p>
			 <p>	  - RESTful</p>
			 <p>	웹 2.0 의 폭발적인 발전에 따라 전통적인 SOAP 기반의 웹 서비스 대안으로 떠오른 RESTful 방식 구현 가능</p>
			 <p>	이에 필요한 XML 설정도 가능하며 부가적인 @(annotation)사용 가능.</p>
			 <p>	  - Zen-coding</p>
			 <p>	이클립스에 플러그인을 설치하고, 단축키를 통해 HTML 코딩을 빠르게 전개 할 수 있음.</p>
			 <p>	  - FTP 업로드</p>
		    <p>  완성된 프로젝트 war 파일을 네트워크를 통해 서버 호스팅에 올릴 수 있는 FTP 를 사용할 수 있으며, 로딩된 소스 편집 가능</p>
			 <p>	  - PuTTy</p>
			 <p>	텔넷 접속 프로그램 중 가장 유명한 PuTTy 를 통해, 웹에서 구동하는 데이터베이스 제어 가능.
			
     
          </div>
			

        </div>
      </section>

    

      <hr class="m-0">

      

    </div>

  </body>

</html>