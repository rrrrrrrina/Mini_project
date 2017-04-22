<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   <script src="/javascript/agency.js"></script>
   
   
   <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
   
   
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/mystyle.css">

	<script type="text/javascript">


	function fncAddProduct(){
		//Form 유효성 검증
	 	var name = $("input[name='name']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
	
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();

	}
	
	$(function(){
		$("img[src='../images/ct_icon_date.gif']").on("click" , function() {
			show_calendar('document.detailForm.manuDate', $("input[name='manuDate']").val());
		});
	});	
	
	$(function() {
		$( "#fix" ).on("click" , function() {
			fncAddProduct();
		});
	});
	
	$(function() {
		$( "#cancel" ).on("click" , function() {
			 history.go(-1);
		});
	});	
	
	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	<input type="hidden" name="prodNo" value="${product.prodNo}">

	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">상품수정</h3>
	    </div>
		
		<form class="form-horizontal">
		
			<div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
			    <div class="col-sm-4">
					<p>Date: <input type="text" id="datepicker" name="manuDate" ></p>
				</div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
			    <div class="col-sm-4">
			      <input type="file" class="form-control" id="fileName" name="fileName" value="${product.fileName}">
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary" id="fix">수정</button>
				  <a class="btn btn-primary btn" id="cancel">취소</a>
			    </div>
		    </div>
		  </form>
   	   </div>
   </body>
</html>