<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>보낸쪽지함</title>

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
		$("form").attr("method" , "POST").attr("action" , "/user/listMessage").submit();	
	}
	
	function fncDeleteMessage() {
		$("form").attr("method" , "POST").attr("action" , "/user/deleteMessage").submit();
	}
	
	$(function() {
		$( "#desc" ).on("click" , function() {
			self.location=self.location="/user/listMessage?searchCondition=0&searchMenu="+$("#searchMenu").val();
		});
		
		$( "#asc" ).on("click" , function() {
			self.location=self.location="/user/listMessage?searchCondition=1&searchMenu="+$("#searchMenu").val();
		});
		
		$( "#number" ).on("click" , function() {
			fncGetUserList(1);
		});
		
		$( "tbody td:nth-child(6n+1)" ).on("click" , function() {
			self.location="/user/getMessage?messageNo="+$($("input:checkbox")[$(this).text().trim()-1]).val();
		});
		
	 });
	
	$(function() {
		$( "#delete" ).on("click" , function() {
			fncDeleteMessage();
		});
	});
	
	
</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<form class="form-inline" name="detailForm">
		<jsp:include page="/layout/toolbar.jsp" />
		<div class="container">
			<div class="page-header text-info">
		       <h3>${user.userId} 님의  보낸쪽지함</h3>
			</div>
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
		            <th align="left" >받는사람</th>
		            <th align="left">보낸시각
					<span id=asc>(오래된순▲)</span>
					<span id=desc>(최근순▼)</span></th>
		            <th align="left">수신확인</th>
		            <th align="left">내용</th>
		            <th align="left">삭제하기</th>
		          </tr>
		        </thead>
		        
		        <tbody>
		        	<c:set var='i' value='0'/>
						<c:forEach var="message" items="${list}">
						<c:set var="i" value="${i+1}"/>
							<td align="center">${i}</td>
							<td align="center">${message.receiverId}</td>
							<td align="center">${message.receiveredDate}</td>
							<c:set var="readDate" value="${message.readDate}"/>
							<c:if test="${empty message.readDate}">
								<c:set var="readDate" value="읽지않음"/>
							</c:if>
							<td align="center">${readDate}</td>
							<td align="center">${message.contents}</td>
							<td align="center"><input type="checkbox" name="chbox" value="${message.messageNo}"></td>
							<tr/>
						</c:forEach>
						<input type="hidden" id="currentPage" name="currentPage" value="${! empty search.currentPage ? search.currentPage : 0}"/>
						<input type="hidden" id="searchCondition" name="searchCondition" value="${! empty search.searchCondition ? search.searchCondition : ""}"/>
						<input type="hidden" id="searchKeyword" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ""}"/>
						<input type="hidden" id="searchMenu" name="searchMenu" value="${! empty param.searchMenu ? param.searchMenu : ""}"/>
		        	</tbody>
      			</table>
      			</form>
      			<div align="right">
		     		<button type="button" class="btn" id="delete">삭제하기</button>
		    	</div>
			</div>
		<jsp:include page="../common/pageNavigator_new.jsp"/>
	</body>
</html>