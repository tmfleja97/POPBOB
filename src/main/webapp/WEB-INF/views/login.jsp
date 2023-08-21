<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/login.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
<script>
  Kakao.init('0925dfb75cd56df515dd5e62db43892e'); // SDK를 초기화 / 사용할 앱의 JavaScript 키를 설정해야 합니다.
  Kakao.isInitialized(); // SDK 초기화 여부 판단 / true, false
  
  // JavaScript SDK가 정상적으로 초기화된 상태라면, 해당 웹 페이지 실행 시 개발자 도구 콘솔에 true가 출력. false가 출력됐다면 초기화에 사용한 JavaScript 키 값이 올바른지 확인해보기.
  console.log(Kakao.isInitialized()); 
</script>

<!-- 아이디 비밀번호 입력 안했을 때 alert창 -->
<script>
 window.onload = function() {
	 document.getElementById('btn-login').onclick = function() {
		 if(document.lfrm.UserId.value.trim() == '') {
			 alert('아이디를 입력해주세요');
			 return false;
		 }
		 
		 if(document.lfrm.Password.value.trim() == ''){
			 alert('비밀번호를 입력해주세요');
			 return false;
		 }
			 	
	 }
 }
</script>

</head>
<body>

<script>
function kakaoLogin() {
Kakao.Auth.authorize({
	  redirectUri: 'http://localhost:8080/kakao/callback',
	  scope: 'profile_nickname, profile_image, account_email, gender',
	});
}
</script>
<%
	String loginSession = (String) session.getAttribute("loginSession");
	
	if (loginSession == null) {
%>
<div class="container-fluid ps-md-0">
  <div class="row g-0">
    <div class="d-none d-md-flex col-md-4 col-lg-6"><img src="https://images.pexels.com/photos/1115204/pexels-photo-1115204.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" width="2000px;" height="937px" ></div>
    <div class="col-md-8 col-lg-6">
      <div class="login d-flex align-items-center py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-9 col-lg-8 mx-auto">
              <a href="/popbob.do" style="text-decoration: none; color: black;"><h3 class="login-heading mb-4">popbob</h3></a>

              <!-- Sign In Form -->
              <form action="/login_ok.do" method="post" name="lfrm">
                <div class="form-floating mb-3">
                  <input type="text" class="form-control" name="UserId" id="floatingInput" >
                  <label for="floatingInput">아이디</label>
                </div>
                
                <div class="form-floating mb-3">
                  <input type="password" class="form-control" name="Password" id="floatingPassword">
                  <label for="floatingPassword">비밀번호</label>
                </div>

                <div class="d-grid">
                  <button class="btn btn-lg btn-primary btn-login text-uppercase fw-bold mb-2" type="submit" id="btn-login">Login</button>
                  <div class="text-center">
                    <span class="small" style="float:right;">회원가입이 필요하신가요? &nbsp;<a class="small" href="signup.do" style="float:right; text-decoration: none;">회원가입</a> </span>
                  </div>
                </div>
				
				<hr>
				<br>
				
				<img src="./images/kakaoLogin.png" alt="카카오 로그인 버튼" onclick="kakaoLogin()">
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div> 

 <%
	} else if( loginSession != null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='/resList.do'");
		out.println("</script>");
	}
%>
</body>
</html>
