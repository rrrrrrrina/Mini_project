<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
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
   
   
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/mystyle.css">

	<script type="text/javascript">


	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
	$(function() {
		 $( "#purchase" ).on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
		});
	});	
	
	$(function() {
		 $( "#cancel" ).on("click" , function() {
			 history.go(-1)		
		});
	});	
	
</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">상품구매</h3>
	    </div>
   	
		<form class="form-horizontal formbg">
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
			</div>
			
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
					<div class="col-xs-8 col-md-4">${product.prodNo}</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
					<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
					<div class="col-xs-8 col-md-4">${product.manuDate}</div>
				</div>
			</div>
				
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
			</div>	
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
					<div class="col-xs-8 col-md-4">${product.regDate}</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
					<div class="col-xs-8 col-md-4">${user.userId}</div>
				</div>
			</div>
			
			<div class="form-group">
		    	<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
				    <div class="col-sm-4">
						<select name="paymentOption" style="width: 120px; height: 30px; color:black" maxLength="20">
							<option value="1" selected="selected">현금구매</option>
							<option value="2">신용구매</option>
						</select>
				    </div>
		    </div>
		  
		  	<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
				    <div class="col-sm-4">
						<input type="text" name="receiverName" class="ct_input_g" 
									style="width: 200px; height: 30px" maxLength="13" value="${user.userName}"/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
				    <div class="col-sm-4">
						<input type="text" name="receiverPhone" class="ct_input_g" 
									style="width: 200px; height: 30px" maxLength="13" value="${user.phone}"/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
				    <div class="col-sm-4">
						<input type="text" name="divyAddr" class="ct_input_g" 
									style="width: 200px; height: 30px" maxLength="13" value="${user.addr}"/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				    <div class="col-sm-4">
						<input type="text" name="divyRequest" class="ct_input_g" 
									style="width: 200px; height: 30px" maxLength="13" value=""/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
		   		<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    		<div class="col-sm-4">
		    			<input type="text" id="datepicker" class="ct_input_g" name="divyDate" >
		    		</div>
		  	</div>
		  	
		  	<div class="form-group">
		   		<div class="col-sm-offset-4  col-sm-4 text-center">
		    		<button type="button" class="btn" id="purchase">구매</button>
		    		<button type="button" class="btn" id="cancel">취소</button>
		    	</div>
		  	</div>
		</form>
	</div>
</body>
</html>