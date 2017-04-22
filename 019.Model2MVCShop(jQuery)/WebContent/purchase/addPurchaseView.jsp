<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
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


	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
	$(function() {
		 $( "#purchase" ).on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
		});
	});	
	
	$(function() {
		 $( "#cancel" ).on("click" , function() {
			 history.go(-1)		
		});
	});	
	
</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����</h3>
	    </div>
   	
		<form class="form-horizontal formbg">
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
					<div class="col-xs-8 col-md-4">${product.prodName}</div>
				</div>
			</div>
			
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
					<div class="col-xs-8 col-md-4">${product.prodNo}</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
					<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
					<div class="col-xs-8 col-md-4">${product.manuDate}</div>
				</div>
			</div>
				
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">����</label>
					<div class="col-xs-8 col-md-4">${product.price}</div>
				</div>
			</div>	
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
					<div class="col-xs-8 col-md-4">${product.regDate}</div>
				</div>
			</div>
			
			<div class="form-group">
				<div class="row">
					<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
					<div class="col-xs-8 col-md-4">${user.userId}</div>
				</div>
			</div>
			
			<div class="form-group">
		    	<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
				    <div class="col-sm-4">
						<select 	name="paymentOption"		class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="20">
							<option value="1" selected="selected">���ݱ���</option>
							<option value="2">�ſ뱸��</option>
						</select>
				    </div>
		    </div>
		  
		  	<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
				    <div class="col-sm-4">
						<input type="text" name="receiverName" class="ct_input_g" 
									style="width: 200px; height: 19px" maxLength="13" value="${user.userName}"/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
				    <div class="col-sm-4">
						<input type="text" name="receiverPhone" class="ct_input_g" 
									style="width: 200px; height: 19px" maxLength="13" value="${user.phone}"/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
				    <div class="col-sm-4">
						<input type="text" name="divyAddr" class="ct_input_g" 
									style="width: 200px; height: 19px" maxLength="13" value="${user.addr}"/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
				    <div class="col-sm-4">
						<input type="text" name="divyRequest" class="ct_input_g" 
									style="width: 200px; height: 19px" maxLength="13" value=""/>  
				    </div>
		    </div>
		    
		    <div class="form-group">
		   		<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    		<div class="col-sm-4">
		    			<input type="text" id="datepicker" class="ct_input_g" name="divyDate" >
		    		</div>
		  	</div>
		  	
		  	<div class="form-group">
		   		<div class="col-sm-offset-4  col-sm-4 text-center">
		    		<button type="button" class="btn" id="purchase">����</button>
		    		<button type="button" class="btn" id="cancel">���</button>
		    	</div>
		  	</div>
		</form>
	</div>
</body>
</html>