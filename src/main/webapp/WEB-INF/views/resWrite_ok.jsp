<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- sweetalert 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
<%
	int flag = (Integer) request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	out.println("window.onload = function() {");
	if (flag == 0) {
		out.println("Swal.fire({");
		out.println("position: 'center',");
		out.println("icon: 'success',");
		out.println("title: '예약 성공!',");
		out.println("showConfirmButton: false,");
		out.println("timer: 1500");
		out.println("}).then(function() {");
		out.println("location.href='resList.do';");
		out.println("});");
	} else {
		out.println("alert('예약 실패');");
		out.println("history.back();");
	}
	out.println("}");
	out.println("</script>");
%>
