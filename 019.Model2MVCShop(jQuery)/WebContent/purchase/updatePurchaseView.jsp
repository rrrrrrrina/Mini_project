<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
	
<head>

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


	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	

	<script type="text/javascript">

	$(function() {
		$('#fix').on("click" , function() {
			$("form").attr("method" , "POST").attr("action", "/purchase/updatePurchase?tranNo="+$(this).next().val()).submit();
		});
	});
	
	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
	$(function() {
		$( "#cancel" ).on("click" , function() {
			 history.go(-1)		
		});
	});
	
	
</script>

<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>구매정보 수정</title>

</head>

<body class="bodycss">
	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보수정</h3>
	    </div>
	    
	    <form class="form-horizontal">
	    <div class="formbg">
	    <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${purchase.buyer.userId}">
		    </div>
		</div>
		
		 <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
		    <select name="paymentOption" 	class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="1" ${purchase.paymentOption=='1' ? "selected" : ""} >현금구매</option>
				<option value="2" ${purchase.paymentOption=='2' ? "" : "selected"} >신용구매</option>
			</select>		    
			</div>
		</div>
		
		<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
				<p><input type="text" id="datepicker" name="divyDate" ></p>
		    </div>
		</div>
		</div>  
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn" id="fix" >수정</button>
		      <input type="hidden" name="tranNo" id="tranNo" value="${purchase.tranNo}">
		      <button type="button" class="btn" id="cancel" >취소</button>
		    </div>
		</div>
		
	</form>
</body>
</html>