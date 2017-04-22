<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
	
   <link href="../css/animate.min.css" rel="stylesheet">
   <link href="../css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
   <script src="../javascript/bootstrap-dropdownhover.min.js"></script>
   <script src="../javascript/agency.js"></script>
   
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/mystyle.css">
	
	<script type="text/javascript">
	$(function() {
		$("#login").on("click" , function() {
			self.location = "/user/login"
		});
		
		$("#productList").on("click" , function() {
			self.location = "/product/listProduct?menu=search"
		});
	});	
	
	$( function() {
		$("a[href='#' ]:contains('회원가입')").on("click" , function() {
			self.location = "/user/addUser"
		});
	});
	
	$( function() {
		$("a[href='#' ]:contains('로 그 인')").on("click" , function() {
			self.location = "/user/login"
		});
	});
	</script>
</head>
	
<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<header>
	<div class="container">
            <div class="intro-text">
                <div class="intro-lead-in">Welcome To Our Market!</div>
                <div class="intro-heading">Let's buy and sell</div>
                <c:if test='${!empty user}'>
               	 	<a class="page-scroll btn btn-xl" id="productList">               
                 	'Go shopping'</a>
                </c:if>
                <c:if test='${empty user}'>
                	<a class="page-scroll btn btn-xl" id="login">               
                 	'Login'</a>
                </c:if>
            </div>
    </div>
   	</header>
   	

</body>

</html>