<%@page import="com.example.model.ReservationTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%



	ArrayList<ReservationTO> resList = (ArrayList) request.getAttribute("resList");

	StringBuilder sbHtml = new StringBuilder();
	
	String imageName = null;
	
	for(ReservationTO to : resList) {
		String resId = to.getResId();
		String imagename = "./upload/rimages/" + to.getImage();
		String title = to.getTitle();
		String location = to.getLocation();
		String price = to.getPrice();
		String startRes = to.getStartRes();
		String endRes = to.getEndRes();
		
		
		sbHtml.append("<div class='col-12 mb-4'>"); // 각 border 사이에 20px의 아래쪽 margin 추가
		sbHtml.append("<div class='card'>"); // Bootstrap 카드 스타일 추가
		sbHtml.append("<h4 class='card-header'>" + title + "</h4>");
		sbHtml.append("<div class='"+ title +" card-body'>");
		sbHtml.append("<div class='row no-gutters align-items-center'>");
		sbHtml.append("<div class='col-md-4'>");
		sbHtml.append("<img src='" + imagename + "' alt='' class='card-img' />");
		sbHtml.append("</div>");
		sbHtml.append("<div class='col-md-8'>");
		sbHtml.append("<div class='card-body'>");
		sbHtml.append("<br>");
		sbHtml.append("<p class='card-text'>가격 : "+ price +"</p><br>");
		sbHtml.append("<p class='card-text'>위치 : "+ location +"</p><br>");
		sbHtml.append("<p class='card-text'>이용 가능한 기간 : "+ startRes + "~" + endRes + "</p><br>");
		sbHtml.append("<div class='card-footer p-4 pt-0 border-top-0 bg-transparent' style='position: absolute; bottom: 0; right: 0;'>");
		sbHtml.append("<a class='btn btn-outline-dark align-self-end' href='resView.do?resId=" + resId + "'>예약하기</a>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("</br>");
		


	}
%>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Reservation | popbob</title>
        <!-- Favicon-->
		<link rel="icon" type="image/x-icon" href="assets/eyeglasses.svg" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/list.css" rel="stylesheet" />
        
        <!-- SweetAlert2 library -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
        <!-- Header-->
		<header class="bg-dark py-5" style="background-image: url('https://images.unsplash.com/photo-1468657988500-aca2be09f4c6?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY4MTg1MDA4NQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1920'); background-size: cover;">
  			<div class="container px-4 px-lg-5 my-5">
    			<div class="text-center text-white">
      				<h1 class="display-4 fw-bolder">Reservation</h1>
      					<p class="lead fw-normal text-white-50 mb-0">현재 예약 가능한 장소</p>
    			</div>
  			</div>
		</header>
        <!-- Section-->
        <section class="py-5">
                <div class="container">
     				 <div class="row">
                        <%= sbHtml %>
				</div>
			</div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">popbob &copy; 문의 / 전화  02.538.3644</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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