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
   
   
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/mystyle.css">

	<script type="text/javascript">


	$(function() {
		
	
		$("#cancel").on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/product/deleteWishList").submit();
		}); 
		
		$("#wishList").on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/product/addWishList").submit();
		}); 
		
		$("#purchase").on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView?prodNo=${product.prodNo}").submit();
		}); 
		
		$("#back").on("click" , function() {
			history.go(-1);
		});
	});
</script>
</head>

<body class="bodycss">
	
	<jsp:include page="/layout/toolbar.jsp" />
	<form>
	
	
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	    </div>	
	    <div class="formbg">
		<input type="hidden" value="${product.prodNo}" name="productNo"/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			<img src = "/images/uploadFiles/${product.fileName}"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}"</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}"</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}"</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}"</div>
		</div>
		<hr/>
		</div>
		
		<div class=formbg>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>${user.userId}</strong></div>
				<div class="col-xs-8 col-md-6"><input type="text" id="contents" name="contents" size="40" value="댓글을 남겨주세요."/><br/>
				<td align="center">비밀글<input type="checkbox" name="chbox" value="${comment.isPrivate}"></td>
				<button class="search btn-default" id="confirm" >확인</button></div>
					<%-- <c:set var="i" value="0" />
		  			<c:forEach var="comment" items="${list}">
					<c:set var="i" value="${ i+1 }" /> --%>
						<tr>
							<%-- <td>${ i }</td> --%>
							<td id="commenterId">${comment.commenterId}</td>
							<td id="contents">${comment.contents}</td>
						</tr>
			</div>
		</div>
		
		<div class=formbg>
			<div class="row">
		  		<div class="col-md-12 text-center ">
		  			<c:if test='${isDuplicate}'>
		  				<button class="btn" id="cancel" >찜하기취소</button>
		  			</c:if>
		  			<c:if test='${!isDuplicate}'>
		  				<button class="btn" id="wishList" >찜하기</button>
		  			</c:if>
		  			<c:if test='${product.proTranCode==0}'>
		  				<button class="btn" id="purchase" >구매</button>
		  			</c:if>
		  			<button class="btn" id="back" >이전</button>
		  		</div>
			</div>
		</div>
		
	  <br/>
 	</div>
 	</form>
</body>
</html>

