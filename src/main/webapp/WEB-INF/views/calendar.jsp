<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.model.CheckTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	ArrayList<CheckTO> cal = (ArrayList<CheckTO>) request.getAttribute("cal");

	String title = "";
	String cpName = "";
	String startDate = "";
	String endDate = "";

	StringBuilder sbHtml = new StringBuilder();

	for(CheckTO to : cal) {
		 title = to.getTitle();
		 cpName = to.getCpName();
		 startDate = to.getStartDate();
		 endDate = to.getEndDate();
		 
		 
	// endDate에 하루를 더해주는 로직 추가
	try {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date parsedStartDate = dateFormat.parse(startDate);
        Date parsedEndDate = dateFormat.parse(endDate);		
        Calendar calendar = Calendar.getInstance();
		calendar.setTime(parsedEndDate);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		endDate = dateFormat.format(calendar.getTime());
		
	
	} catch (ParseException e) {
		e.printStackTrace();
	}
		 
		 sbHtml.append("{");
		 sbHtml.append("title: '" + cpName + " : " + title + "',");
		 sbHtml.append("start: '" + startDate +"',");
		 sbHtml.append("end: '" + endDate + "'");
		 sbHtml.append("},");

	}
	
	

%>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>예약 현황 | popbob</title>

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/eyeglasses.svg" />

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
	
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/views.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- jQuery 로드 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- 부트스트랩 JavaScript 로드 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d191922c66fdb09c41a4feae5ada7e0"></script>
<base target="_top">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
crossorigin="anonymous">

  <!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <!-- jquery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- fullcalendar CDN -->
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

  <!-- SweetAlert2 library -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
  /* body 스타일 */
  html, body {
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }
  /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
  .fc-header-toolbar {
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
  }
</style>

<script type="text/javascript">
    function logout() {
        Swal.fire({
            title: '로그아웃 하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire(
                    '로그아웃 되었습니다!',
                    '다시 로그인해주세요.',
                    'success'
                ).then(() => {
                    // 아래는 예시로 간단히 페이지를 리다이렉트하는 코드
                    location.href = '/logout.do'; // 로그아웃 처리 후 이동할 페이지
                });
            }
        });
    }
</script>
</head>
<body>
<%
	String loginSession = (String) session.getAttribute("loginSession");
	String userId = (String) request.getAttribute("userId");
	System.out.println("UserId : " + userId);
	String kakaoNickname = (String) session.getAttribute("kakaoNickname");
	if (loginSession != null) {
%>
	<!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container px-4 px-lg-5">
            <a class="navbar-brand" href="/popbob.do">popbob</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <li class="nav-item"><a class="nav-link" aria-current="page" href="/popbob.do">Home</a></li>
					<li class="nav-item"><a class="nav-link " href="resList.do">Reservation</a></li>
					<li class="nav-item"><a class="nav-link active" href="calendar.do">OverView</a></li>
                </ul>
                <% if(userId != null) { %>
                <span style="font-family: 'NanumSquareNeo-Variable'">환영합니다 <%=userId%>님 ! &nbsp;</span>
                <% } else if(userId == null) { %>
                <span style="font-family: 'NanumSquareNeo-Variable'">환영합니다 <%=kakaoNickname%>님 ! &nbsp;</span>
                <% } %>
                 <form class="d-flex" action="" method="post">
                    <button class="btn btn-outline-dark" type="button" onclick="logout()">
						<i class="bi bi-box-arrow-in-right"></i>
                        Logout
                    </button>
                </form>
            </div>
        </div>
    </nav>
    <!-- Header-->
		<header class="bg-dark py-5" style="background-image: url('https://images.unsplash.com/photo-1468657988500-aca2be09f4c6?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY4MTg1MDA4NQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1920'); background-size: cover;">
  			<div class="container px-4 px-lg-5 my-5">
    			<div class="text-center text-white">
      				<h1 class="display-4 fw-bolder">OverView</h1>
      					<p class="lead fw-normal text-white-50 mb-0">예약 현황</p>
    			</div>
  			</div>
		</header>

	<!-- 이미지 / 상세 정보 -->
	<section class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div id='calendar-container'>
    <div id='calendar'></div>
  </div>
   <script>
  (function(){
    $(function(){
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
        // 해더에 표시할 툴바
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        initialDate: '2023-07-01', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
          console.log(obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log(obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log(obj);
        },
        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          var title = prompt('Event Title:');
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        // 이벤트
        events: [
			<%=sbHtml%>  
      	]
      });
      // 캘린더 랜더링
      calendar.render();
    });
  })();
</script>
		</div>
	</section>
	

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<%
		} else {
			out.println("<script type='text/javascript'>");
			out.println("alert('로그인이 필요합니다.')");
			out.println("location.href='/login.do'");
			out.println("</script>");
		}
	%>
</body>
</html>
