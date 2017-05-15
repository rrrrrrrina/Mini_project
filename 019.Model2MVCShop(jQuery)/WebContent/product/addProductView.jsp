
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<html>
<head>
<title>상품등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <script src="/javascript/agency.js"></script>
   
   
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/mystyle.css">

	<script type="text/javascript">


	function fncAddProduct(){
		//Form 유효성 검증
	 	var name = $("input[name='prodName']").val();
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
		alert($("#fileName").val());
		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	
	}
	
	$(function() {
		$( "#enroll" ).on("click" , function() {
			fncAddProduct();
		});
	});	
	
	$(function() {
		 $( "#cancel" ).on("click" , function() {
				$("form")[0].reset();
		});
	});	
	
	
	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
	
</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
   	
   	<div class="container">
		<div class="page-header">
		    <h3 class=" text-info">상품등록</h3>
		</div>	
	    <div class="formbg">

		<form class="form-horizontal" enctype="multipart/form-data">
		
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="text" name="prodName"></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		 	<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="text" name="prodDetail"/></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
		    <div class="col-xs-8 col-md-4"><p><input type="text" id="datepicker" name="manuDate" ></p></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="text" name="price">&nbsp;원</div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="file" name="images" id="fileName" multiple/></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="enroll">등록</button>
			 <button type="button" class="btn btn-primary" id="cancel">취소</button>
		    </div>
		  </div>
		  </form>
		  </div>
		</div>
</body>
</html>