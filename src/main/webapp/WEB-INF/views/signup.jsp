<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up</title>
<link rel="stylesheet" type="text/css" href="css/signup.css">
<link rel="stylesheet" type="text/css" href="css/all.min.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<script type="text/javascript" src="./js/jquery-3.7.0.js"></script>

<!-- 정규식과 회원가입 입력에 대한 설정 -->
<script>

//정규 표현식 객체
const idRegExp = /^[a-zA-Z0-9]{6,12}$/; // 문자와 숫자로만 구성, 길이는 6 ~ 12 사이

// 영문 숫자 특수기호 조합 8자리 이상
const passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;

//이메일 정규식 / 이메일 주소는 영문 대소문자, 숫자, 특수문자(._%+-)로 구성, "@" 포함, "." 기호로 구분된 최소 2자 이상의 영문 대소문자로 된 도메인
const emailRegExp = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/; 


// 내가 가입창에 입력한 값
let idBox;
let passBox;
let emailBox;

window.onload=function() {
	document.getElementById('btn-signup').onclick = function() {
		
		// 회사명
		if(document.getElementById('floatingDropdown').value == '선택') {
			alert('회사명을 선택해주세요.');
			return false;
		}
		
		// 아이디
		idBox = document.getElementById('floatingId'); // idBox에 입력된 id값을 넣어줌.
		
		if(idBox.value.trim() == '') {
			alert('아이디를 입력해주세요.');
			return false;
		} else if(!idRegExp.test(idBox.value)) { // idBox에 있는값이 정규식과 맞지 않으면 alert문구 띄우기
			alert('아이디를 영문자 / 영문자와 숫자로 6 ~ 12자 사이로 작성해주세요.');
			return false;
		}
		
		// 비밀번호
		passBox = document.getElementById('floatingPassword');
		
		if(passBox.value.trim() == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		} else if(!passRegExp.test(passBox.value)) {
			alert('비밀번호를 영문 숫자 특수기호 조합 8자리 이상 입력해주세요.');
			return false;
		}
		
		// 비밀번호 확인
		if(document.getElementById('check_floatingPassword').value.trim() == '') {
			alert('비밀번호 확인을 입력해주세요.');
			return false;
		} else if(document.getElementById('floatingPassword').value.trim() != document.getElementById('check_floatingPassword').value.trim()) {
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}
		
		// 이메일
		emailBox = document.getElementById('floatingEmail');
		
		if(document.getElementById('floatingEmail').value.trim() == '') {
			alert('이메일을 입력해주세요.');
			return false;
		} else if(!emailRegExp.test(emailBox.value)) {
			alert('이메일 형식을 확인해주세요.');
			return false;
		}
		
		
	}
}

</script>

<!-- 비동기 중복확인 및 안내문구 -->
<script>
const koreanRegExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 아이디에 한글 안들어가게 하기위한 한글 정규식

$(document).ready(function() {
	
	// 아이디 비동기 처리 및 안내문구
    $('#floatingId').keyup(function() {
        let id = $(this).val();
        
        if (id != '') {
            if (koreanRegExp.test(id)) {
                $('#id_result').text('영문/숫자로 입력해주세요').css('color', 'red');
            } else if (!idRegExp.test(id)) {
                $('#id_result').text('영문자 / 영문자와 숫자로 6 ~ 12자 사이로 작성해주세요').css('color', 'red');
            } else {
                $.ajax({
                    type: 'get',
                    url: '/id_check',
                    async: true,
                    data: { id: id },
                    success: function(result) { 
                        if (result == 0) {  
                            $('#id_result').text('사용 가능한 아이디').css('color', 'blue');
                        } else if (result == 1) {
                            $('#id_result').text('중복된 아이디').css('color', 'red');
                        }
                    },
                    error: function(e) {
                        alert('[에러] : ' + e.status);
                    }
                });
            }
        } else {
            $('#id_result').text('아이디를 입력해주세요 !').css('color','blue');
        }
    });
    
	// 비밀번호 안내문구
    $('#floatingPassword').keyup(function() {
    	let password = $(this).val();
    	
    	if (password != '') {
            if (!passRegExp.test(password)) {
                $('#password_result').text('영문 숫자 특수기호 조합 8자리 이상 입력해주세요').css('color', 'red');
            } else if (passRegExp.test(password)) {
            	$('#password_result').text('사용가능한 비밀번호').css('color', 'blue');
            } 
    	} else {
        	$('#password_result').text('비밀번호를 입력해주세요 !').css('color','blue');
        }
    })
    
    // 비밀번호 확인 안내문구
    $('#check_floatingPassword').keyup(function() {
    	let check_password = $(this).val();
    	let password = $('#floatingPassword').val();
    	
    	if(check_password != '') {
    		if(check_password != password) {
        		$('#password_check_result').text('비밀번호가 맞지 않습니다.').css('color', 'red');
        	} else {
        		$('#password_check_result').text('비밀번호 확인').css('color', 'blue');
        	}
    	} else {
        	$('#password_check_result').text('비밀번호 확인을 입력해주세요 !').css('color','blue');
        }
    	 
    })
    

    // 이메일 중복처리
    $('#floatingEmail').keyup(function() {
        let email = $(this).val();
        
        if (email != '') {
            if (!emailRegExp.test(email)) {
                $('#email_result').text('이메일 형식을 확인해주세요.').css('color', 'red');
            } else {
                $.ajax({
                    type: 'get',
                    url: '/email_check',
                    async: true,
                    data: { email: email },
                    success: function(result) { 
                    	console.log(result);
                        if (result == 0) {  
                            $('#email_result').text('사용 가능한 이메일').css('color', 'blue');
                        } else if (result == 1) {
                            $('#email_result').text('중복된 이메일').css('color', 'red');
                        }
                    },
                    error: function(e) {
                        alert('[에러] : ' + e.status);
                    }
                });
            }
        } else {
            $('#email_result').text('이메일을 입력해주세요 !').css('color','blue');
        }
    });
    
	$('#btn-signup').click(function() {
		if($('#id_result').text() != '사용 가능한 아이디' || $('#email_result').text() != '사용 가능한 이메일') {
			alert('아이디 또는 이메일 중복확인을 확인하세요.');
			return false;
		}
	})
    
});



</script>

</head>
<!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->

<body class="body">

  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto" >
          <div class="card-body p-4 p-sm-5">
             <a href="/popbob.do" style="text-decoration: none;"><h1 class="card-title text-center mb-5 fw-light" style="color:white;">Sign Up</h1></a>
            
            <form action="signup_ok.do" method="post" name="sfrm" >
              <div class="form-floating mb-3" >
                <select class="form-select" name="CpName" id="floatingDropdown" aria-label="Floating dropdown" >
                	<option selected disabled>선택</option>
                	<option value="(주)회사1">(주)회사1</option>
                	<option value="(주)회사2">(주)회사2</option>
                	<option value="(주)회사3">(주)회사3</option>
                	<option value="(주)회사4">(주)회사4</option>
                </select>
                <label for="floatingDropdown">회사명</label>
                 <span id="CpName_result">&nbsp;</span>
              </div>
        
              <div class="form-floating mb-3">
                <input type="text" class="form-control" name="UserId" id="floatingId" >
                <label for="floatingId">아이디</label>
                <span id="id_result">&nbsp;</span>
              </div>
     
    		  <div class="form-floating mb-3">
      			  <input type="password" class="form-control" name="Password" id="floatingPassword" >
      			  <label for="floatingPassword">비밀번호 </label>
      			  <span id="password_result">&nbsp;</span>
    		  </div>
    		     
              <div class="form-floating mb-3">
                <input type="password" class="form-control" id="check_floatingPassword">
                <label for="check_floatingPassword">비밀번호 확인</label>
                <span id="password_check_result">&nbsp;</span>
              </div>
              
              <div class="form-floating mb-3">
                <input type="email" class="form-control" name="CpEmail" id="floatingEmail">
                <label for="floatingEmail">이메일</label>
                <span id="email_result">&nbsp;</span>
              </div>
			  	
              <div class="d-grid">
                <button class="btn btn-login text-uppercase fw-bold" type="submit" id="btn-signup" style="background:grey"><span style="color:white;">Sign Up</span></button>
              </div>
              <hr class="my-4">
     
            </form>
            
          </div>
        </div>
    
    </div>
  </div>

</body>
</html>