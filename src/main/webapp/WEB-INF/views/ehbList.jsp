<%@page import="com.example.model.InformationTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%



	ArrayList<InformationTO> infoList = (ArrayList) request.getAttribute("infoList");

	StringBuilder sbHtml = new StringBuilder();
	
	String imageName = null;
	
	for(InformationTO to : infoList) {
		String infoId = to.getInfoId();
		String title = to.getTitle();
		String period = to.getPeriod();
		String imagename = "./upload/eimages/" + to.getImage1();
		
		
		 sbHtml.append("<div class='col mb-5'>");
		 sbHtml.append("<div class='card h-100'>");
		 sbHtml.append("<!-- Sale badge-->");
		 sbHtml.append("<div class='badge bg-dark text-white position-absolute' style='top: 0.5rem; right: 0.5rem'>Exhibition</div>");
		 sbHtml.append("<!-- Product image-->");
		 sbHtml.append("<img class='card-img-top' src='"+ imagename +"' alt='...' />");
		 sbHtml.append("<!-- Product details-->");
		 sbHtml.append("<div class='card-body p-4'>");
		 sbHtml.append("<div class='text-center'>");
		 sbHtml.append("<!-- Product name-->");
		 sbHtml.append("<h5 class='fw-bolder'>"+ title +"</h5>");
		 sbHtml.append("<!-- Product reviews-->");
		 sbHtml.append("<div class='d-flex justify-content-center small text-warning mb-2'>");
		 sbHtml.append("</div>");
		 sbHtml.append("<!-- Product price-->");
		 sbHtml.append("<span class='text-muted' style='font-size:17px'>"+ period +"</span>");
		 sbHtml.append("</div>");
		 sbHtml.append("</div>");
		 sbHtml.append("<div class='card-footer p-4 pt-0 border-top-0 bg-transparent'>");
		 sbHtml.append("<div class='text-center'><a class='btn btn-outline-dark mt-auto' href='ehbView.do?infoId=" + infoId +"'>View</a></div>");
		 sbHtml.append("</div>");
		 sbHtml.append("</div>");
		 sbHtml.append("</div>");
	      

	}
%>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition | POPBOB</title>
        <!-- Favicon-->
		<link rel="icon" type="image/x-icon" href="assets/eyeglasses.svg" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/list.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/popbob.do">POPBOB</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="/popbob.do">Home</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Information</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item active" href="ehbList.do">Exhibition</a></li>
                                <li><a class="dropdown-item" href="popList.do">Pop Up Store</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Header-->
		<header class="bg-dark py-5" style="background-image: url('https://images.unsplash.com/photo-1533134486753-c833f0ed4866?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYzMDQzMTk4OQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1920'); background-size: cover;">
  			<div class="container px-4 px-lg-5 my-5">
    			<div class="text-center text-white">
      				<h1 class="display-4 fw-bolder">Exhibition</h1>
      					<p class="lead fw-normal text-white-50 mb-0">진행 중인 전시회</p>
    			</div>
  			</div>
		</header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
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
    </body>
</html>