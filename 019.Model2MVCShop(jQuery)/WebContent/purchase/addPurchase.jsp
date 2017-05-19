<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>상품등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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



	$(function() {
		$( "#confirm" ).on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
		});
	});
	
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
   		
		<div class="container">
			<div class="page-header">
		       <h3 class=" text-info">다음과 같이 구매가 되었습니다.</h3>
		    </div>	
		<div class="page-header">
	       <h3 class=" text-info">구매정보</h3>
	    </div>	
   			<form class="form-horizontal">
			<table class="table table-hover table-striped" >
		        <thead>
		          <tr>
		            <th align="center">No</th>
		            <th align="left" >상품이미지</th>
		            <th align="left">상품명</th>
		            <th align="left">배송주소</th>
		            <th align="left">받으실 분 성함</th>
		            <th align="left">요청사항</th>
		            <th align="left">주문희망날짜</th>
		          </tr>
		        </thead>
		        
				<tbody>
				  <c:set var="i" value="0" />
				  <c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
					  <td align="center">${ i }</td>
					  <td align="center"><img src="/images/uploadFiles/${product.fileName}" width="50" height="50"/>
					  <td align="center">${product.prodName}</td>
					  <td align="center">${purchase.divyAddr}</td>
					  <td align="center">${purchase.receiverName}</td>
					  <td align="center">${purchase.divyRequest}</td>
					  <td align="center">${purchase.divyDate}</td>
		          </c:forEach>
		        </tbody>
		      </table>
		     	<div class="form-group">
				   	<div class="col-sm-offset-4  col-sm-4 text-center">
				    	<button type="button" class="btn" id="confirm">확인</button>
				    </div>
				</div>
		     </form>
			</div>
		</body>
	</html>