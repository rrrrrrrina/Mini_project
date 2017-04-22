<%@ page contentType="text/html; charset=euc-kr" %>


<html>
<head>
<title>상품등록</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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


	function fncAddProduct(){
		//Form 유효성 검증
	 	var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		
		alert(name+detail+manuDate+price);
		
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
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

<body>

	<jsp:include page="/layout/toolbar.jsp" />
   	
   	<div class="container">
   	
   	<h1 class="bg-primary text-center">상품등록</h1>

		<form class="form-horizontal">
		
		<div class="form-group">
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" name="prodName" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" name="prodDetail" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		    <p><input type="text" id="datepicker" name="manuDate" ></p>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
				<input type="text" name="price" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="10">&nbsp;원
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
				<input		type="file" name="fileName" class="ct_input_g" 
							style="width: 200px; height: 19px" maxLength="13"/>  
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="enroll">등록</button>
			  <a class="btn btn-primary btn" href="#" role="button" id="cancel">취소</a>
		    </div>
		  </div>
		  </div>
		</form>
	</div>
</body>
</html>