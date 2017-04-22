<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
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
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/mystyle.css">

	<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu").submit();
	}
	
	 $(function() {
		$( "button:contains('search')" ).on("click" , function() {
			fncGetUserList(1);
		});
		
		$( "#desc" ).on("click" , function() {
			self.location="/product/listProduct?orderByPrice=2&menu="+$('#menu').val();
		});
		
		$( "#asc" ).on("click" , function() {
			self.location="/product/listProduct?orderByPrice=1&menu="+$('#menu').val();
		});
		
		$( "tbody td:nth-child(3)" ).on("click" , function() {
			var prodNo = $(this).next().val();
			var prodName=$(this).text().trim();
			var menu=$("#menu").val();
			var destination='<input type="button" value="상세보기" id="detail"/>';
			
			if(menu=='manage'){
				destination='<input type="button" value="수정하기" id="fix"/>';
			}
			
			$.ajax( 
					{
						url : "/product/getJsonProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							var displayValue = "<h5>"
														+"상품명 : "+JSONData.product.prodName+"<br/>"
														+"제조날짜 : "+JSONData.product.manuDate+"<br/>"
														+"상세정보 : "+JSONData.product.prodDetail+"<br/>"
														+"가격 : "+JSONData.product.price+"<br/>"
														+"등록일 : "+JSONData.product.regDate+"<br/>"
														+destination
														+"</h5>";
							$("h5").remove();
							$( "#"+prodName+"" ).html(displayValue);
							$(document).on('click', '#detail',function(){
					 			self.location="/product/getProduct?prodNo="+JSONData.product.prodNo+"&proTranCode="+JSONData.product.proTranCode;
					 		});
							$(document).on('click', '#fix',function(){
					 			self.location="/product/updateProduct?prodNo="+JSONData.product.prodNo;
					 		});
						}
				});
			
		});	
		/* 
		$( "td:nth-child(3)" ).on("click" , function() {
			self.location ="/user/getUser?userId="+$(this).text().trim();
		}); */
		
		$( "td:nth-child(9)" ).on("click" , function() {
			self.location="/purchase/updateTranCodeByProd?prodNo="+$(this).parents('tr').find('input').val().trim()+
					"&proTranCode="+$(this).parents('tr').find('input').next().val().trim();
		});
		
		
	});
	
</script>

</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	<input type="hidden" id="menu" value='${menu}'/>
	
	<div class="container">
		<div class="page-header text-info">
	       <h3>${!empty menu && menu=="search" ? "상품목록조회" : "상품관리"}</h3>
		</div>
	<div class="row">
			<div class="col-md-6 text-left">
				<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
		    	<form class="form-inline" name="detailForm">
				<div class="form-group">
					<label class="sr-only" for="searchKeyword">가격검색</label>
					<input 	type="text" id="startPrice" name="startPrice" value="${!empty search.startPrice? search.startPrice : ""}"
							class="ct_input_g" style="height:20px;width:70px;" />~
					<input 	type="text" id="endPrice" name="endPrice" value="${!empty search.endPrice? search.endPrice : ""}"
							class="ct_input_g" style="height:20px;width:70px;" />
				    <button type="button" class="search btn-default">search</button>
				    <input type="hidden" id="currentPage" name="currentPage" value=""/>
				    <input type="hidden" id="orderByPrice" name="orderByPrice" value="${!empty search.orderByPrice? search.orderByPrice:''}"/> 
				</div>
				<br/>
				
				<div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <select name="searchCondition" class="ct_input_g" style="width:65px">
						<option value="1" ${search.searchCondition=="1"? "selected" : ""}>상품명</option>
						<option value="2" ${search.searchCondition=="2"? "selected" : ""}>상품가격</option>
					</select>
					<input 	type="text" name="searchKeyword"  value="${!empty search.searchKeyword? search.searchKeyword : ""}" 
							class="ct_input_g" style="width:153px; height:19px" >
				    <button type="button" class="search btn-default">search</button>
				</div>
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  </form>
	    	</div>
	   </div>
		
		
		<table class="table table-hover table-striped">
      
        <thead>
          <tr>
            <th align="left">No</th>
            <th align="left" >상품이미지</th>
            <th align="left">상품명</th>
            <th align="left">가격
			<span id=asc>(▲)</span>
			<span id=desc>(▼)</span></th>
            <th align="left">상품정보</th>
            <th align="left">등록날짜</th>
            <th align="left">현재상태</th>
            <th align="left" width="100px">찜한사람 수</th>
          </tr>
        </thead>
		
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left">${ i }</td>
			  <td align="left"><img src="/images/uploadFiles/${product.fileName}" width="50" height="50"/>
			  <td align="left" id="name">${product.prodName}</td>
			  <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
			  <input type="hidden" id="proTranCode" name="proTranCode" value='${product.proTranCode.trim()}'/>
			  <td align="center" id="name">${product.price}</td>
			  <td align="left">${product.prodDetail}</td>
			  <td align="left">${product.regDate}</td>
			  <c:set var="tranCode" value="판매중"/>
			  <c:if test="${role=='admin'}">
					<c:if test="${product.proTranCode.trim()=='1'}">
						<c:set var="tranCode" value="구매완료"/>
					</c:if>
					<c:if test="${product.proTranCode.trim()=='2'}">
						<c:set var="tranCode" value="배송중"/>
					</c:if>
					<c:if test="${product.proTranCode.trim()=='3'}">
						<c:set var="tranCode" value="배송완료"/>
					</c:if>
			  </c:if>
			  <c:if test="${role=='user'}">
					<c:if test="${product.proTranCode.trim()!='0'}">
						<c:set var="tranCode" value="재고없음"/>
					</c:if>
			  </c:if>
			  <td align="left">${tranCode}
			  <c:if test="${!empty menu && menu=='manage' && product.proTranCode.trim()=='1'}">
					배송하기
			  </c:if>
			  <td align="center">${product.countLiked}</td>
			  <tr>
			  <td id="${product.prodName}" colspan="15"></td>
			  </tr>
          </c:forEach>
        </tbody>
      </table>
	</div>

	<jsp:include page="../common/pageNavigator_new.jsp"/>

</body>
</html>
