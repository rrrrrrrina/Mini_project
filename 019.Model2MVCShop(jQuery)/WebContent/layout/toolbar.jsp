<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	
		
		$(function() {
		
			$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
			
			$("a:contains('회원정보조회')").on("click" , function() {
				self.location = "/user/listUser"
			}); 
			
		 	$( "a:contains('개인정보조회')" ).on("click" , function() {
				$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
			});
			
		 	$( "a:contains('보낸쪽지함')" ).on("click" , function() {
				$(self.location).attr("href","/user/listMessage?searchMenu=send");
			});
		 	
		 	$( "a:contains('받은쪽지함')" ).on("click" , function() {
				$(self.location).attr("href","/user/listMessage?searchMenu=get");
			});
		 	
		 	$( "a:contains('쪽지쓰기')" ).on("click" , function() {
				$(self.location).attr("href","/user/sendMessage");
			});
		 	
		 	$( "a:contains('구매이력조회')" ).on("click" , function() {
				$(self.location).attr("href","/purchase/listPurchase");
			});
		 	
		 	$( "a:contains('판매상품등록')" ).on("click" , function() {
				$(self.location).attr("href","../product/addProductView.jsp;");
			});
		 	
		 	$( "a:contains('판매상품관리')" ).on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=manage");
			});
		 	
		 	$( "a:contains('판매상품조회')" ).on("click" , function() {
				$(self.location).attr("href","/purchase/listSale");
			});
		 	
		 	$( "a:contains('상품검색')" ).on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=search");
			});
		 	
		 	$( "a:contains('찜한상품조회')" ).on("click" , function() {
				$(self.location).attr("href","/product/listWishList");
			});
		 	
		 	$( "a:contains('최근 본 상품')" ).on("click" , function() {
		 		popWin = window.open("/history.jsp",
						"popWin",
						"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
			});
		 	
		 	$("ul li ul li").hover(function(){ 
		 		$(this).parents().prev().css('background','transparent');
			});
		 
		});
		
		
		
</script>
<div class="navbar navbar-custom navbar-fixed-top">
	<div class="container">
		<div class="navbar-header page-scroll">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		    <a class="navbar-brand page-scroll" href="/index.jsp">Buying and Selling</a>
		</div>
		
		<div class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	             <ul class="nav navbar-nav navbar-right">
	             <li><a href="#" >상품검색</a></li>
	             <c:if test="${!empty user}">
		             <c:if test="${sessionScope.user.role == 'admin'}">
		             	<li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >회원관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">개인정보조회</a></li>
		                         <li><a href="#">회원정보조회</a></li>
		                     </ul>
		                 </li>
		                 
			             <li class="dropdown">
			                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                         <span>판매상품관리</span>
			                         <span class="caret"></span>
			                     </a>
			                     <ul class="dropdown-menu">
			                         <li><a href="#">판매상품등록</a></li>
			                         <li><a href="#">판매상품관리</a></li>
			                         <li><a href="#">판매상품조회</a></li>
			                     </ul>
			             </li>
		            </c:if>
	                
	                <c:if test="${sessionScope.user.role == 'user'}">
	                	<li><a href="#">개인정보조회</a></li>
		                <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >상품구매</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                     	<li><a href="#">구매이력조회</a></li>
		                     	<li><a href="#">최근본상품</a></li>
		                     </ul>
		               	</li> 
		                <li><a href="#" >찜한상품조회</a></li>
	                </c:if>
	                
	                <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >쪽지함</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">보낸쪽지함</a></li>
	                         <li><a href="#">받은쪽지함</a></li>
	                         <li><a href="#">쪽지쓰기</a></li>
	                     </ul>
	                </li>
					
	             	<ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            	</ul>
	            </c:if>
	            </ul>
			</div>    
		</div>
</div>
   	