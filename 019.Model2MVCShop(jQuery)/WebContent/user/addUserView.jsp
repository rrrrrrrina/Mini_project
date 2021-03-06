<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>


<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   <link href="../css/animate.min.css" rel="stylesheet">
   <link href="../css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   <script src="../javascript/bootstrap-dropdownhover.min.js"></script>
   <script src="../javascript/agency.js"></script>
   <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
   
   <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
   <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
   <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
   <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
   
   
	<link rel="stylesheet" href="/code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../css/mystyle.css">
	<link rel="stylesheet" type="text/css" href="../css/font-awesome/css/font-awesome.min.css">
	

	<script type="text/javascript">

	function fncAddUser() {
	// Form 유효성 검증
	var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
	
	if(id == null || id.length <1){
		alert("아이디는 반드시 입력하셔야 합니다.");
		return;
	}
	if(pw == null || pw.length <1){
		alert("패스워드는  반드시 입력하셔야 합니다.");
		return;
	}
	if(pw_confirm == null || pw_confirm.length <1){
		alert("패스워드 확인은  반드시 입력하셔야 합니다.");
		return;
	}
	if(name == null || name.length <1){
		alert("이름은  반드시 입력하셔야 합니다.");
		return;
	}
	
	if(pw != pw_confirm) {
		alert("비밀번호 확인이 일치하지 않습니다.");
		$("input:text[name='password2']").focus();
		return;
	}
		
	var value = "";	
	if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
		var value = $("option:selected").val() + "-" 
							+ $("input[name='phone2']").val() + "-" 
							+ $("input[name='phone3']").val();
	}
	
	$("input:hidden[name='phone']").val( value );

	$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
	
}
	
	$(function() {
		$( "#join" ).on("click" , function() {
			fncAddUser();
		});
	});	
	
	$(function() {
		$( "#cancel" ).on("click" , function() {
			$("form")[0].reset();
		});
	});	

	$(function() {
		 
		 $("input[name='email']").on("change" , function() {
			
			 var email=$("input[name='email']").val();
		    
			 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
		    	alert("이메일 형식이 아닙니다.");
		     }
		});
		 
	});	

	function checkSsn() {
		var ssn1, ssn2; 
		var nByear, nTyear; 
		var today; 

		ssn = document.detailForm.ssn.value;
		// 유효한 주민번호 형식인 경우만 나이 계산 진행, PortalJuminCheck 함수는 CommonScript.js 의 공통 주민번호 체크 함수임 
		if(!PortalJuminCheck(ssn)) {
			alert("잘못된 주민번호입니다.");
			return false;
		}
	}

function PortalJuminCheck(fieldValue){
    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
	var num = fieldValue;
    if (!pattern.test(num)) return false; 
    num = RegExp.$1 + RegExp.$2;

	var sum = 0;
	var last = num.charCodeAt(12) - 0x30;
	var bases = "234567892345";
	for (var i=0; i<12; i++) {
		if (isNaN(num.substring(i,i+1))) return false;
		sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
	}
	var mod = sum % 11;
	return ((11 - mod) % 10 == last) ? true : false;
}

	$(function() {

		$( "#userId" ).on("keyup" , function() {
			
			var userId=$("#userId").val();
			
			$.ajax( 
					{
						url : "/user/checkJsonDuplication/"+userId ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(JSONData , status) {
							if(JSONData.result){
								$("#check").html("사용불가한 아이디입니다.");
							}else{
								$("#check").html("사용가능한 아이디입니다.");
							}
						}
					});
			});
		});	

</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
	
	
	<div class="container form-box form-top">
	
		<h3 class="bg-primary text-center form-top form-top2">회 원 가 입</h3>

		<form class="form-horizontal">
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="중복확인하세요" width="50px"><div id="check">아이디를 입력하세요</div></input>
		    </div>
		</div>
		  
	<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="회원이름">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주민번호</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="주민번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="addr" name="addr" placeholder="주소">
		    </div>
		  </div>	
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
		    <div class="col-sm-3 your-class">
		    <input type="text" class="form-control" id="phone1" name="phone1" style="width:60px">
		    <input type="text" class="form-control" id="phone2" name="phone2" style="width:60px">
		    <input type="text" class="form-control" id="phone3" name="phone3" style="width:60px">
		    </div>
		    <input type="hidden" name="phone"/>
		  </div>
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
		    </div>
		  </div>

		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn" id="join" width="20px">가 &nbsp;입</button>
			  <button type="button" class="btn" id="cancel" width="20px" >취&nbsp;소</a>
		    </div>
		  </div>
		</form>
	</div>
</body>

</html>