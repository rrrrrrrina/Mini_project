<%@ page contentType="text/html; charset=euc-kr" %>


<html>
<head>
<title>��ǰ���</title>
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
	 	var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		
		alert(name+detail+manuDate+price);
		
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
		
		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	
	}
	
	$(function() {
		$( "#enroll" ).on("click" , function() {
			fncAddProduct();
		});
	});	
	
	$(function() {
		 $( "#cancel" ).on("click" , function() {
				$("form")[0].reset();
		});
	});	
	
	
	$( function() {
	    $( "#datepicker" ).datepicker();
	});
	
	
</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
   	
   	<div class="container">
		<div class="page-header">
		    <h3 class=" text-info">��ǰ���</h3>
		</div>	
	    <div class="formbg">

		<form class="form-horizontal">
		
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="text" name="prodName"></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		 	<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="text" name="prodDetail"/></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
		    <div class="col-xs-8 col-md-4"><p><input type="text" id="datepicker" name="manuDate" ></p></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>����</strong></div>
		    <div class="col-xs-8 col-md-4""><input type="text" name="price">&nbsp;��</div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		  	<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
		    <div class="col-xs-8 col-md-4"><input type="file" name="fileName"/></div>
		  </div>
		  
		  <hr/>
		  
		  <div class="row">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="enroll">���</button>
			 <button type="button" class="btn btn-primary" id="cancel">���</button>
		    </div>
		  </div>
		  </form>
		  </div>
		</div>
</body>
</html>