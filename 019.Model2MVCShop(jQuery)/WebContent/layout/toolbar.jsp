<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	
		
		$(function() {
		
			$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
			
			$("a:contains('ȸ��������ȸ')").on("click" , function() {
				self.location = "/user/listUser"
			}); 
			
		 	$( "a:contains('����������ȸ')" ).on("click" , function() {
				$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
			});
			
		 	$( "a:contains('����������')" ).on("click" , function() {
				$(self.location).attr("href","/user/listMessage?searchMenu=send");
			});
		 	
		 	$( "a:contains('����������')" ).on("click" , function() {
				$(self.location).attr("href","/user/listMessage?searchMenu=get");
			});
		 	
		 	$( "a:contains('��������')" ).on("click" , function() {
				$(self.location).attr("href","/user/sendMessage");
			});
		 	
		 	$( "a:contains('�����̷���ȸ')" ).on("click" , function() {
				$(self.location).attr("href","/purchase/listPurchase");
			});
		 	
		 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
				$(self.location).attr("href","../product/addProductView.jsp;");
			});
		 	
		 	$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=manage");
			});
		 	
		 	$( "a:contains('�ǸŻ�ǰ��ȸ')" ).on("click" , function() {
				$(self.location).attr("href","/purchase/listSale");
			});
		 	
		 	$( "a:contains('��ǰ�˻�')" ).on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=search");
			});
		 	
		 	$( "a:contains('���ѻ�ǰ��ȸ')" ).on("click" , function() {
				$(self.location).attr("href","/product/listWishList");
			});
		 	
		 	$( "a:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
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
	             <li><a href="#" >��ǰ�˻�</a></li>
	             <c:if test="${!empty user}">
		             <c:if test="${sessionScope.user.role == 'admin'}">
		             	<li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >ȸ������</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">����������ȸ</a></li>
		                         <li><a href="#">ȸ��������ȸ</a></li>
		                     </ul>
		                 </li>
		                 
			             <li class="dropdown">
			                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			                         <span>�ǸŻ�ǰ����</span>
			                         <span class="caret"></span>
			                     </a>
			                     <ul class="dropdown-menu">
			                         <li><a href="#">�ǸŻ�ǰ���</a></li>
			                         <li><a href="#">�ǸŻ�ǰ����</a></li>
			                         <li><a href="#">�ǸŻ�ǰ��ȸ</a></li>
			                     </ul>
			             </li>
		            </c:if>
	                
	                <c:if test="${sessionScope.user.role == 'user'}">
	                	<li><a href="#">����������ȸ</a></li>
		                <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >��ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                     	<li><a href="#">�����̷���ȸ</a></li>
		                     	<li><a href="#">�ֱٺ���ǰ</a></li>
		                     </ul>
		               	</li> 
		                <li><a href="#" >���ѻ�ǰ��ȸ</a></li>
	                </c:if>
	                
	                <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">����������</a></li>
	                         <li><a href="#">����������</a></li>
	                         <li><a href="#">��������</a></li>
	                     </ul>
	                </li>
					
	             	<ul class="nav navbar-nav navbar-right">
	                <li><a href="#">�α׾ƿ�</a></li>
	            	</ul>
	            </c:if>
	            </ul>
			</div>    
		</div>
</div>
   	