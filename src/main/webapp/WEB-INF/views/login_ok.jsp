<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>    
<%
    Boolean flag = (Boolean) request.getAttribute("flag");

    out.println("<script type='text/javascript'>");
    out.println("window.onload = function() {");
    if (flag == true) {
        out.println("location.href='/resList.do';"); // 여기서 세미콜론을 추가해야 합니다.
    } else {
        out.println("Swal.fire(");
        out.println("'로그인 오류',");
        out.println("'아이디/비밀번호가 맞지 않습니다!',");
        out.println("'question'");
        out.println(").then(function() {");
        out.println("history.back();");
        out.println("});"); // 여기서도 세미콜론을 추가해야 합니다.
    }
    out.println("}");
    out.println("</script>");
%>
