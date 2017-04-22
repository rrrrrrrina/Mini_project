<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>


<html>
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
	// Form ��ȿ�� ����
	var id=$("input[name='userId']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();
			var name=$("input[name='userName']").val();
	
	if(id == null || id.length <1){
		alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(pw == null || pw.length <1){
		alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(pw_confirm == null || pw_confirm.length <1){
		alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(name == null || name.length <1){
		alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	
	if(pw != pw_confirm) {
		alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
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
			alert("dd");
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
		    	alert("�̸��� ������ �ƴմϴ�.");
		     }
		});
		 
	});	

	function checkSsn() {
		var ssn1, ssn2; 
		var nByear, nTyear; 
		var today; 

		ssn = document.detailForm.ssn.value;
		// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
		if(!PortalJuminCheck(ssn)) {
			alert("�߸��� �ֹι�ȣ�Դϴ�.");
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
		 $("#duplication").on("click" , function() {
			popWin 
			= window.open("/user/checkDuplication.jsp",
									"popWin", 
									"left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,"+
									"scrollbars=no,scrolling=no,menubar=no,resizable=no");
		});
	});	

</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />
	
	
	<div class="container form-box form-top">
	
		<h3 class="bg-primary text-center form-top form-top2">ȸ �� �� ��</h3>

		<form class="form-horizontal">
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�� �� ��</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="�ߺ�Ȯ���ϼ���" width="50px" readonly>
		    </div>
		    <div class="col-sm-2">
		      <button type="button" class="btn" id="duplication">�ߺ�Ȯ��</button>
		    </div>
		  </div>
		  
	<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ Ȯ��</label>
		    <div class="col-sm-3">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="��й�ȣ Ȯ��">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="ȸ���̸�">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ֹι�ȣ</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="�ֹι�ȣ">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="addr" name="addr" placeholder="�ּ�">
		    </div>
		  </div>	
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�޴���ȭ��ȣ</label>
		     <div class="col-sm-3">
		    <input type="text" class="form-control" id="phone" name="phone" placeholder="��ȣ">
		    </div>
		    <input type="hidden" name="phone"/>
		  </div>
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>
		    <div class="col-sm-3">
		      <input type="text" class="form-control" id="email" name="email" placeholder="�̸���">
		    </div>
		  </div>

		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn" id="join" width="20px">�� &nbsp;��</button>
			  <button type="button" class="btn" id="cancel" width="20px" >��&nbsp;��</a>
		    </div>
		  </div>
		</form>
	</div>
</body>

</html>