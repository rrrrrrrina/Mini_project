<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
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
	
	$(function(){
		
		$( "#purchase" ).on("click" , function() {
				$("form").attr("method","POST").attr("action","/purchase/addPurchase").submit();
		});
			
		$( "#cancel" ).on("click" , function() {
				history.go(-1);
		});
	});	

</script>
</head>

<style>
.bodycss{
	text-align:left;
}
</style>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
	
   	
   	<div class="container">
	   	<div class="page-header">
	   		<h3 class="text-info">여러가지 상품구매</h3>
	   	</div>
		<form class="form-horizontal">
			<table class="table table-hover table-striped" >
		        <thead>
		          <tr>
		            <th align="center">No</th>
		            <th align="left" >상품이미지</th>
		            <th align="left">상품명</th>
		            <th align="left">가격</th>
		            <th align="left">상품정보</th>
		            <th align="left">등록날짜</th>
		          </tr>
		        </thead>
		        
		        <tbody>
				  <c:set var="i" value="0" />
				  <c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
					  <td align="center">${ i }</td>
					  <td align="center"><img src="/images/uploadFiles/${product.fileName}" width="50" height="50"/>
					  <td align="center" id="name">${product.prodName}</td>
					  <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
					  <input type="hidden" id="proTranCode" name="proTranCode" value='${product.proTranCode.trim()}'/>
					  <td align="center" id="name">${product.price}</td>
					  <td align="center">${product.prodDetail}</td>
					  <td align="center">${product.regDate}</td>
		          </c:forEach>
		        </tbody>
		      </table>
		      <br/><br/>
		      
		      <div class="formbg">
					<div class="form-group">
						<div class="row">
							<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
							<div class="col-xs-8 col-md-4">${user.userId}</div>
						</div>
					</div>
					
					<div class="form-group">
				    	<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
						    <div class="col-sm-4">
								<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 28px; color:black" maxLength="20">
									<option style="color:black" value="1" selected="selected">현금구매</option>
									<option style="color:black" value="2">신용구매</option>
								</select>
						    </div>
				    </div>
				  
				  	<div class="form-group">
					    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
						    <div class="col-sm-4">
								<input type="text" name="receiverName" class="ct_input_g" 
											style="width: 200px;" maxLength="13" value="${user.userName}"/>  
						    </div>
				    </div>
				    
				    <div class="form-group">
					    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
						    <div class="col-sm-4">
								<input type="text" name="receiverPhone" class="ct_input_g" 
											style="width: 200px;" maxLength="13" value="${user.phone}"/>  
						    </div>
				    </div>
				    
				    <div class="form-group">
					    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
						    <div class="col-sm-4">
								<input type="text" name="divyAddr" class="ct_input_g" 
											style="width: 400px;" maxLength="13" value="${user.addr}"/>  
						    </div>
				    </div>
				    
				    <div class="form-group">
					    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
						    <div class="col-sm-4">
								<input type="text" name="divyRequest" class="ct_input_g" 
											style="width: 500px;" maxLength="13" value=""/>  
						    </div>
				    </div>
				    
				    <div class="form-group">
				   		<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
				    		<div class="col-sm-4">
				    			<p><input type="text" id="datepicker" name="divyDate" ></p>
				    		</div>
				  	</div>
				  </div>
				  <br/>	
				  	
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