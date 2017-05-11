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
   
   
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/mystyle.css">
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" type="text/css" href="../css/font-awesome/css/font-awesome.min.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	
	
	<script type="text/javascript">
	
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/getProduct").submit();
	}


	$(function() {
		
		var userIds=[];
		var prodNo=$('#productNo').val();
		var gotResult=0;
		
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
		
		$("#send").on("click" , function() {

			$.ajax( 
					{
						url : "/product/addJsonComment",
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						data : {
								contents:$(this).prev().val(),
								prodNo:prodNo
								} , 
						success : function(serverData , status) {
						
							var displayValue='<span id="'+serverData.comment.commentNo+'">'
											+'<div class="row">'
											+'<div class="col-xs-4 col-md-2">'
											+'<td><strong>'+serverData.comment.commenterId+'</strong></td></div>'
											+'<div class="col-xs-8 col-md-6">'
											+serverData.comment.receiverId
											+serverData.comment.contents
											+'('+serverData.comment.commentDate+')'
											+'<i class="fa fa-times-circle-o" style="margin:10"></i>'
											+'<input type="hidden" id="commentNo" name="commentNo" value="'+serverData.comment.commentNo+'">'
											+'</div></div></span>';
							
							$("#productNo").after(displayValue);
							$("#contents").val("");
							
						}
				});
		});
		
		$( "#contents" ).on("keyup" , function() {
			var contents=$("#contents").val();
			if(contents=="@"){
				getUserIds()
			}
			
			function getUserIds(){
					 $.ajax( 
								{
									url : "/user/getJsonUserIds/"+gotResult,
									method : "GET" ,
									dataType : "json" ,
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									context : this,
									success : function(serverData , status) {
										if(gotResult==0){
											for(var i=0; i<serverData.list.length; i++){
												userIds.push("@"+serverData.list[i]+" ");
											}
										}
										gotResult=serverData.gotResult;
									}
						});
				}
			

			$( "#contents" ).autocomplete({
			      source: userIds,
			      minLength: 1
			});
			

		});
		
		$( "#moreComments" ).on("click" , function() {
			var currentPage=$("#currentPage").val();
		
			$.ajax( 
					{
						url : "/product/listJsonComment/"+prodNo+"/"+currentPage,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							for(var i=0; i<serverData.list.length; i++){
								var displayValue='<c:forEach var="comment" items="'+serverData.list+'">'
								+'<span id="'+serverData.list[i].commentNo+'">'
								+'<div class="row">'
								+'<div class="col-xs-4 col-md-2">'
								+'<td><strong>'+serverData.list[i].commenterId+'</strong></td></div>'
								+'<div class="col-xs-8 col-md-6">'
								+serverData.list[i].receiverId
								+serverData.list[i].contents+'('+serverData.list[i].commentDate+')'
								+'<i class="fa fa-times-circle-o" style="margin:10"></i>'
								+'<input type="hidden" id="commentNo" name="commentNo" value="'+serverData.list[i].commentNo+'">'
								+'</div></div></span></c:forEach>';

								$("#moreComments").before(displayValue);
							} 
							$("#currentPage").val(serverData.currentPage);
						}
				});
		});
		
		$('body').on('click' , '.fa-times-circle-o', function() {
			var commentNo=$(this).next().val();
			
			$.ajax( 
					{
						url : "/product/deleteComment/"+commentNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							$( "#"+serverData.commentNo+"" ).remove();
						}
					});
		});
});
	
</script>
</head>

<body class="bodycss">
	
	<jsp:include page="/layout/toolbar.jsp" />
	<form>
	
	
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	    </div>	
	    <div class="formbg">
		
		<input type="hidden" value="${search.currentPage}" name="currentPage" id="currentPage"/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			<img src = "/images/uploadFiles/${product.fileName}"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}"</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}"</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}"</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}"</div>
		</div>
		<hr/>
		</div>
		
		<br/>
		
		<div class="formbg">
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>${user.userId}</strong>
				</div>
				<div class="ui-widget">
					<labal for="contents">
						<div class="col-xs-8 col-md-6">
							<input type="text" id="contents" name="contents" size="40" value="����� �����ּ���." onFocus="value=''"/>
							<input type="button" class="search btn-default" id="send" value="Ȯ��" >
						</div>
					</labal>
				</div>
			</div>
			
			<input type="hidden" value="${product.prodNo}" name="productNo" id="productNo"/>
			
			
			<c:set var="i" value="0" />
		  	<c:forEach var="comment" items="${list}">
		  		<c:set var="i" value="${ i+1 }" />
		  		<span id="${comment.commentNo}">
					<div class="row">
						<div class="col-xs-4 col-md-2">
							<td id="commenterId"><strong>${comment.commenterId}</strong></td>
						</div>
						<div class="col-xs-8 col-md-6">
							<c:if test="${!empty comment.receiverId}">
								${comment.receiverId}
							</c:if>
							${comment.contents}(${comment.commentDate})
	  						<i class="fa fa-times-circle-o" style="margin:10"></i>
	  						<input type="hidden" id="commentNo" name="commentNo" value="${comment.commentNo}">
						</div>
					</div>
				</span>
			</c:forEach>
 			
 			<input type="button" class="search btn-default" id="moreComments" value="������" >
		</div>
		
		<br/>
		
			<div class="row">
		  		<div class="col-md-12 text-center ">
		  			<c:if test='${isDuplicate}'>
		  				<button class="btn" id="cancel" >���ϱ����</button>
		  			</c:if>
		  			<c:if test='${!isDuplicate}'>
		  				<button class="btn" id="wishList" >���ϱ�</button>
		  			</c:if>
		  			<c:if test='${product.proTranCode==0}'>
		  				<button class="btn" id="purchase" >����</button>
		  			</c:if>
		  			<button class="btn" id="back" >����</button>
		  		</div>
			</div>
		</div>
		
	  <br/>
 	</form>
</body>
</html>

