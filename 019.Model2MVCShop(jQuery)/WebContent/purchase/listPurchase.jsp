<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매 목록조회</title>
   
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


	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	$(function() {

		$( "#desc" ).on("click" , function() {
			self.location="/purchase/listPurchase?searchCondition=0";
		});
		
		$( "#asc" ).on("click" , function() {
			self.location="/purchase/listPurchase?searchCondition=1";
		});
		
		$( "tbody td:nth-child(2)" ).on("click" , function() {
			self.location="/purchase/getPurchase?tranNo="+$(this).next().val();
		});
		
		$( "tbody td:nth-child(7)" ).on("click" , function() {
			self.location="/purchase/updateTranCodeByProd?prodNo="+$(this).parents('tr').find('input').val().trim()+
					"&proTranCode="+$(this).parents('tr').find('input').next().val().trim();
		});
	 });
	
	$(function() {
		$( "td:contains('정보수정')" ).on("click" , function() {
			self.location="/purchase/getPurchase?tranNo="+$(this).parents('tbody').find('input').val();
		});
	});
	
	$(function() {
		$( "td:contains('물건도착')" ).on("click" , function() {
			self.location="/purchase/updateTranCode?tranNo="+$(this).parents('tbody').find('input').val()+"&tranCode="+$(this).parents('tbody').find('input').next().val();
		});
	});
	
</script>
</head>

<body>
	<form class="form-inline" name="detailForm">
		<jsp:include page="/layout/toolbar.jsp" />
		<div class="container">
			<div class="page-header text-info">
		       <h3>${user.userId} 님의 구매 목록조회.</h3>
			</div>
			<div class="col-md-6 text-left">
				<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <table class="table table-hover table-striped" >
      
		        <thead>
		          <tr>
		            <th align="center">No</th>
		            <th align="left" >상품명</th>
		            <th align="left">받는분성함</th>
		            <th align="left">주문날짜
					<span id=asc>(오래된순▲)</span>
					<span id=desc>(최근순▼)</span></th>
		            <th align="left">배송현황</th>
		          </tr>
		        </thead>
		        
		        <tbody>
		        	<c:set var='i' value='0'/>
						<c:forEach var="purchase" items="${list}">
						<c:set var="i" value="${i+1}"/>
							<td align="center">${i}</td>
							<td align="center">${purchase.purchaseProd.prodName}</td>
							<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}"/>
							<input type="hidden" id="tranCode" name="tranCode" value="${purchase.tranCode.trim()}"/>
							<td align="center">${purchase.receiverName}</td>
							<td align="center">${purchase.orderDate}</td>
							<td align="center">현재
								<c:set var="tranCode" value="구매완료"/>
								<c:if test="${purchase.tranCode.trim()=='2'}">
									<c:set var="tranCode" value="배송중"/>
								</c:if>
								<c:if test="${purchase.tranCode.trim()=='3'}">
									<c:set var="tranCode" value="배송완료"/>
								</c:if>
										${tranCode}
									상태 입니다.
								<c:if test="${purchase.tranCode.trim()=='2'}">
									물건도착
								</c:if>
								<c:if test="${purchase.tranCode.trim()=='1'}">
									정보수정
								</c:if>
							</td>
							<tr/>
						</c:forEach>
		        	</tbody>
      			</table>
			</div>
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<input type="hidden" id="searchCondition" name="searchCondition" value="${! empty search.searchCondition ? search.searchCondition : "4"}"/>
		<jsp:include page="../common/pageNavigator_new.jsp"/>
	</form>
	</body>
</html>