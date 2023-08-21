<%@page import="java.util.ArrayList"%>
<%@page import="com.example.model.InformationTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	InformationTO infoTO = (InformationTO) request.getAttribute("infoTO");

	ArrayList<InformationTO> infoPopList = (ArrayList) request.getAttribute("infoPopList");

	
	String infoId = infoTO.getInfoId();
	String title = infoTO.getTitle();
	String content = infoTO.getContent().replaceAll("\n", "<br/>");
	String price = infoTO.getPrice();
	String xLoc = infoTO.getXLoc();
	String yLoc = infoTO.getYLoc();
	
	String imagename1 = "./upload/pviewimages/" + infoTO.getImage2();
	String imagename2 = "./upload/pviewimages/" + infoTO.getImage3();
	String imagename3 = "./upload/pviewimages/" + infoTO.getImage4();
	
	StringBuilder sbHtml = new StringBuilder();
	
	
	for(InformationTO to : infoPopList) {
		
		String subInfoId = to.getInfoId();
		String subTitle = to.getTitle();
		String subperiod = to.getPeriod();
		
		String image1 = "./upload/pimages/" + to.getImage1();
		
		sbHtml.append("<div class='col mb-5'>");
		sbHtml.append("<div class='card h-100'>");
		sbHtml.append("<img class='card-img-top' src='"+ image1 +"' alt='...'/>");
		sbHtml.append("<div class='card-body p-4'>");
		sbHtml.append("<div class='text-center'>");
		sbHtml.append("<h5 class='fw-bolder'>"+ subTitle +"</h5>");
		sbHtml.append(subperiod);
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("<div class='card-footer p-4 pt-0 border-top-0 bg-transparent'>");
		sbHtml.append("<div class='text-center'>");
		sbHtml.append("<a class='btn btn-outline-dark mt-auto' href='/popView.do?infoId="+subInfoId +"'>View options</a>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
	}
%>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Pop Up Store View | popbob</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/eyeglasses.svg" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/views.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 로드 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> <!-- 부트스트랩 JavaScript 로드 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d191922c66fdb09c41a4feae5ada7e0"></script>
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/popbob.do">popbob</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/popbob.do">Home</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">Information</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="ehbList.do">Exhibition</a></li>
							<li><a class="dropdown-item active" href="popList.do">Pop
									Up Store</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Product section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					<div id="carouselExampleIndicators" class="carousel slide"
						data-bs-ride="carousel">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#carouselExampleIndicators"
								data-bs-slide-to="0" aria-label="Slide 1" class="active"
								aria-current="true"></button>
							<button type="button" data-bs-target="#carouselExampleIndicators"
								data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
							<button type="button" data-bs-target="#carouselExampleIndicators"
								data-bs-slide-to="2" aria-label="Slide 3" class=""></button>
						</div>
						<div id="carousel-image" class="carousel-inner">
							<div class="carousel-item active">
								<img src="<%=imagename1%>" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item">
								<img src="<%=imagename2%>" class="d-block w-100" alt="...">
							</div>
							<div class="carousel-item">
								<img src="<%=imagename3%>" class="d-block w-100" alt="...">
							</div>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
					</div>
					<div class="col-md-6">
						<h2 class="display-5 fw-bolder"><%=title%></h2><br>
						<div class="fs-5 mb-5">
							<span>가격 : <%=price%></span>
						</div>
						<p class="lead" style="font-size : 18px"><%=content%></p>
						<div class="d-flex">
							<button class="btn btn-outline-dark flex-shrink-0" id="openModal" data-toggle="modal" data-target="#myModal">
								<i class="bi bi-map"></i> 상세지도
							</button> &nbsp;&nbsp;&nbsp;
							<a href="/chatgpt.html">
								<button class="btn btn-outline-dark flex-shrink-0" type="button">
									<i class="bi bi-chat-dots"></i> Chat
								</button>
							</a>
						</div>
					</div>
				</div>
			</div>
	</section>


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
				center : new kakao.maps.LatLng( <%=xLoc%>, <%=yLoc%> ),
				level : 3
			// 지도의 확대 수준을 설정함 (0~14)
			};

			let map = new kakao.maps.Map(container, options);

			// 지도에 표시될 마크 위치 설정
			let markerPosition = new kakao.maps.LatLng( <%=xLoc%>, <%=yLoc%> );
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
	</script>


	<!-- Related items section-->
	<section class="py-5 bg-light">
		<div class="container px-4 px-lg-5 mt-5">
			<h2 class="fw-bolder mb-4">팝업 스토어 최신 목록</h2>
			<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<%=sbHtml %>
			</div>
		</div>
	</section>
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
</body>
</html>
