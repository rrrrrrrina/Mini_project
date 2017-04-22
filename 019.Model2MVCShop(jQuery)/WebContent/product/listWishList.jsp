<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<html>
<head>
<title>찜한목록조회</title>

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


	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listWishList").submit();	
	}
	
	function fncAddPurchase() {
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView").submit();	
	}
	
	function fncDeleteWishes() {     
		$("form").attr("method" , "POST").attr("action" , "/product/deleteWishList").submit();		
	}
	
	$(function() {
		$( "#desc" ).on("click" , function() {
			self.location="/product/listWishList?orderByPrice=2&menu="+$('#menu').val();
		});
		
		$( "#asc" ).on("click" , function() {
			self.location="/product/listWishList?orderByPrice=1&menu="+$('#menu').val();
		});
		
		$( "td:nth-child(2)" ).on("click" , function() {
			self.location="/product/getProduct?prodNo="+$(this).next().val()+"&menu="+$('#menu')+"&proTranCode="+$(this).next().next().val();
		});
		
		$( "#order" ).on("click" , function() {
			fncAddPurchase();
		});
		
		$( "#delete" ).on("click" , function() {
			fncDeleteWishes();
		});
		
	});
</script>

</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
		<input type="hidden" id="menu" value='${menu}'/>
     	 
		<div class="container">
		<div class="page-header text-info">
	       <h3>찜한목록조회</h3>
		</div>
		<div class="row">
			<div class="col-md-6 text-left">
				<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
			
			<form class="form-inline" name="detailForm">
			<table class="table table-hover table-striped" >
      			
	        <thead>
	          <tr>
	            <th align="center">No</th>
	            <th align="left" >상품명</th>
	            <th align="left">가격
				<span id=asc>(▲)</span>
				<span id=desc>(▼)</span></th>
	            <th align="left">상품정보</th>
	            <th align="left">찜한날짜</th>
	            <th align="left">찜한사람 수</th>
	            <th align="left">현재상태</th>
	            <th align="left">주문하기</th>
	            <th align="left">삭제하기</th>
	          </tr>
	        </thead>
	        
	      <tbody>
		  <c:set var="i" value="0" />
		  <c:forEach var="wishList" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="center">${wishList.wishedProd.prodName}</td>
			  <input type="hidden" id="prodNo" name="prodNo" value="${wishList.wishedProd.prodNo}"/>
			  <input type="hidden" id="proTranCode" name="proTranCode" value='${wishList.wishedProd.proTranCode.trim()}'/>
			  <td align="center">${wishList.wishedProd.price}</td>
			  <td align="center">${wishList.wishedProd.prodDetail}</td>
			  <td align="center">${wishList.wishedDate}</td>
			  <td align="center">${wishList.likeCount}</td>
			  <c:set var="tranCode" value="재고없음"/>
				<c:if test="${wishList.wishedProd.proTranCode.trim()=='0'}">
					<c:set var="tranCode" value="판매중"/>
				</c:if>
			  <td align="center">${tranCode}</td>
			  <c:if test="${wishList.wishedProd.proTranCode.trim()=='0'}">          
				<td align="center"><input type="checkbox" name="chbox" value="${wishList.wishedProd.prodNo}"></td>
			  </c:if>
			  <c:if test="${wishList.wishedProd.proTranCode.trim()!='0'}">
				<td align="center"><input type="checkbox" name="chbox"  disabled="disabled" value="${wishList.wishedProd.prodNo}"></td>
			  </c:if>
			  <td align="center"><input type="checkbox" name="chbox" value="${wishList.wishedProd.prodNo}"></td>      
			  </tr>
         	 </c:forEach>
     		<input type="hidden" id="currentPage" name="currentPage" value=""/>
      	  </tbody>
     	 </table>
     	 </form>
     	 <div align="right">
     	 <button type="button" class="btn btn-default" id="order">주문하기</button>
     	 <button type="button" class="btn btn-default" id="delete">삭제하기</button>
    	</div>
	</div>
	<jsp:include page="../common/pageNavigator_new.jsp"/>
</body>
</html>
