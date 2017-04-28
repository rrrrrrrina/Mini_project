<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <script src="/javascript/agency.js"></script>
   
   
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/resources/demos/style.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/mystyle.css">

	<script type="text/javascript">


	function fncAddProduct(){
		//Form ��ȿ�� ����
	 	var name = $("input[name='name']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
	
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();

	}

	$(function() {
		$( "#fix" ).on("click" , function() {
			fncAddProduct();
		});
	});
	
	$(function() {
		$( "#cancel" ).on("click" , function() {
			 history.go(-1);
		});
	});	
	
	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
</script>
</head>

<body class="bodycss">
	<jsp:include page="/layout/toolbar.jsp" />
	<input type="hidden" name="prodNo" value="${product.prodNo}">

	<div class="container">
		<form>
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����</h3>
	    </div>	
	    <div class="formbg">
		
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
			    </div>
			</div>
			
			<hr/>
			
			<div class="row">
			    <div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
			    <div class="col-xs-8 col-md-4"><input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}"></div>
			</div>
			
			<hr/>
			
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			    <div class="col-xs-8 col-md-4">
					<input type="text" id="datepicker" name="manuDate" >
				</div>
			</div>
			
			<hr/>
			
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
			    </div>
			</div>
			
			<hr/>
			
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input type="file" class="form-control" id="fileName" name="fileName" value="${product.fileName}">
			    </div>
			</div>
			</div>
			
			<div class="formbg">
				<div class="row">
				    <div class="col-sm-offset-4  col-sm-4 text-center">
				      <button type="button" class="btn btn-primary" id="fix">����</button>
					  <button type="button" class="btn btn-primary" id="cancel">���</button>
				    </div>
			    </div>
		    </div>
		  </form>
   	   </div>
   </body>
</html>