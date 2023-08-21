<%@page import="com.example.model.ReservationTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	ReservationTO resTO = (ReservationTO) request.getAttribute("resTO");

	String resId = resTO.getResId();
	String imagename = "./upload/rimages/" + resTO.getImage();
	String title = resTO.getTitle();
	String location = resTO.getLocation();
	String price = resTO.getPrice();
	String xLoc = resTO.getXLoc();
	String yLoc = resTO.getYLoc();
%>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>예약 | popbob</title>

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


<!-- SweetAlert2 library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>



<!-- insert 경고문 -->
<script type="text/javascript">
	const numberRegExp = /^01(?:0|1|[6-9])\d{8}$/; 
	
	window.onload = function() {

		document.getElementById('rbtn').onclick = function() {

			if (document.getElementById('number').value.trim() == '') {
				alert('전화번호를 입력해주세요!');
				return false;
			} else if (!numberRegExp
					.test(document.getElementById('number').value)) {
				alert('올바른 전화번호 형식이 아닙니다!');
				return false;
			}

			if (document.getElementById('startDate').value.trim() == '') {
				alert('예약 시작날을 선택해주세요!');
				return false;
			}

			if (document.getElementById('endDate').value.trim() == '') {
				alert('예약 마지막날을 선택해주세요!');
				return false;
			}

			document.rfrm.submit();

		};
	};

	
	//전화번호 정규식 경고문
	$(document).ready(function() {
		$('#number').keyup(function() {
			let number = $(this).val();

			if (number != '') {
					if (!numberRegExp.test(number)) {
						$('#number_result').text('전화번호 형식을 확인해주세요.').css('color', 'red');
				} else {
						$('#number_result').text('');
				}
			}
		});
	});
</script>


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
	String cpName = (String) request.getAttribute("cpName");
	String cpEmail = (String) request.getAttribute("cpEmail");
	String kakaoNickname = (String) session.getAttribute("kakaoNickname");
	String kakaoEmail = (String) session.getAttribute("kakaoEmail");
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
					<li class="nav-item active"><a class="nav-link active" href="resList.do">Reservation</a></li>
					<li class="nav-item"><a class="nav-link" href="calendar.do">OverView</a></li>
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

	<!-- 이미지 / 상세 정보 -->
	<section class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					<img class="card-img-top mb-5 mb-md-0" src="<%=imagename%>"
						alt="..." /><br> <br>
					<div class="d-flex" style="text-align: center">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-outline-dark flex-shrink-0" id="openModal"
							data-toggle="modal" data-target="#myModal">
							<i class="bi bi-map"></i> 상세지도
						</button>
						&nbsp;&nbsp;&nbsp;
							<a href="/chatgpt.html">
								<button class="btn btn-outline-dark flex-shrink-0" type="button">
									<i class="bi bi-chat-dots"></i> Chat
								</button>
							</a>
					</div>
				</div>
				<div class="col-md-6">
					<h2 class="display-5 fw-bolder text-center"><%=title%></h2>
					<br>
					<div class="fs-5 mb-5 text-center">
						<span>가격 : <%=price%></span>
					</div>
					
					<!-- 예약 form  -->
					<form action="resWriteOk.do" name="rfrm" method="post">
						<div class="container">
							<div class="row frame">
								<!-- 예약 정보 -->
								<div class="form-group mb-4 box">
									장소 <input type="text" class="form-control inp mb-3 text-center"
										id="title" name="title" value="<%=title%>" readonly
										autocomplete="off">
								</div>
								<!-- 예약 정보 -->
								<div class="form-group mb-4 box">
								<% if(cpName != null) {%>
									회사명 <input type="text" class="form-control inp mb-3 text-center"
										id="cpName" name="cpName" value="<%=cpName %>" readonly
										autocomplete="off">
								<% } else if(cpName == null) { %>
									회사명 <input type="text" class="form-control inp mb-3 text-center"
										id="cpName" name="cpName" value="기타" readonly
										autocomplete="off">
								<% } %>
								</div>
								
								<div class="form-group mb-4 box">
								<% if(cpEmail != null) {%>
									이메일 <input type="text" class="form-control inp mb-3 text-center"
										id="email" name="email" value="<%=cpEmail %>" readonly
										autocomplete="off">
								<% } else if(cpEmail == null) { %>
									이메일 <input type="text" class="form-control inp mb-3 text-center"
										id="email" name="email" value="<%=kakaoEmail %>" readonly
										autocomplete="off">
								<% } %>
								</div>
								
								
								<div class="form-group mb-4 box">
									전화번호 <input type="text" class="form-control inp mb-3"
										id="number" name="number" placeholder="(-미포함) 전화번호를 입력해주세요."
										autocomplete="off">
										<label for="number"></label> 
										<span id="number_result">&nbsp;</span>
								</div>
					
								<div style="display: flex;">
								  <div class="form-group mb-4 box" style="flex: 1; margin-right: 10px;">
								    시작 날짜  <input type="date" class="form-control inp mb-3" id="startDate" name="startDate" placeholder="입력" autocomplete="off">
								  </div>
								  <div class="form-group mb-4 box" style="flex: 1; margin-left: 10px;">
								    마지막 날짜  <input type="date" class="form-control inp mb-3" id="endDate" name="endDate" placeholder="입력" autocomplete="off">
								  </div>
								</div>
								<!-- create form until element here -->

								<sapn><?= message ?></sapn>

								<div class="form-group mt-4 mb-4 text-center">
									<input type="submit" id="rbtn"
										class="btn btn-outline-dark flex-shrink-0" name="submit"
										value="예약하기" /><br>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	
	<!-- 마지막 날짜 조정 -->
<script>
  // 시작 날짜 변경 이벤트 처리
  document.getElementById('startDate').addEventListener('change', function() {
    let startDateValue = new Date(this.value);
    let endDateInput = document.getElementById('endDate');

    // 시작 날짜의 다음 날을 최솟값으로 설정
    let minEndDate = new Date(startDateValue);

    // 마지막 날짜 필드의 최솟값 설정
    endDateInput.min = formatDate(minEndDate);
    
    // 선택된 마지막 날짜가 최솟값보다 작을 경우 초기화
    let selectedEndDate = new Date(endDateInput.value);
    if (selectedEndDate < minEndDate) {
      endDateInput.value = '';
    }
  });

  // 날짜를 'YYYY-MM-DD' 형식으로 포맷하는 함수
  function formatDate(date) {
   let year = date.getFullYear();
   let month = ('0' + (date.getMonth() + 1)).slice(-2);
   let day = ('0' + date.getDate()).slice(-2);
    
   return year + '-' + month + '-' + day;
  }
</script>


	<!-- 지도, 모달 -->
	<div id="myModal" class="modal" tabindex="-1" data-backdrop="static"
		style="border-radius: 10px;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">지도</h5>
					<button type="button" class="btn-close" data-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div id="map"
						style="width: 100%; height: 400px; border-radius: 10px;"></div>
				</div>
			</div>
		</div>
	</div>

	<script>
		// 모달이 열릴 때 지도 생성
		$('#myModal').on('shown.bs.modal', function() {
			// 지도가 표시될 HTML element
			let container = document.getElementById('map');
			let options = {
				// 중심 좌표 설정
				center : new kakao.maps.LatLng(
	<%=xLoc%>
		,
	<%=yLoc%>
		),
				level : 3
			// 지도의 확대 수준을 설정함 (0~14)
			};

			let map = new kakao.maps.Map(container, options);

			// 지도에 표시될 마크 위치 설정
			let markerPosition = new kakao.maps.LatLng(
	<%=xLoc%>
		,
	<%=yLoc%>
		);
			let marker = new kakao.maps.Marker({
				position : markerPosition
			});

			marker.setMap(map);
		});

		// 모달 닫힐 때 지도 제거
		$('#myModal').on('hidden.bs.modal', function() {
			let container = document.getElementById('map');
			container.innerHTML = '';
		});

		$('#resBtn').on('click', function() {
			alert('해당 기능은 아직 준비중 입니다!');
		})
	</script>

	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">popbob &copy; 문의 / 전화  02.538.3644</p>
		</div>
	</footer>
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
