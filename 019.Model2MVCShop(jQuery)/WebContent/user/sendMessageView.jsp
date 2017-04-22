<%@ page contentType="text/html; charset=euc-kr" %>
<%
      pageContext.setAttribute("crcn", "\r\n");
      pageContext.setAttribute("br", "<br/>");
%>


<html>
<head>
	<meta charset="EUC-KR">
	<title>����������</title>

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


	
	function fncSendMessage() {
	var receiverId=$("input[name='receiverId']").val();
	var contents=$("#contents").val();
	
	if(receiverId == null || receiverId.length <1){
		alert("�޴º��� ���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(contents == null || contents.length <1){
		alert("�޼�����  �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	$("form").attr("method" , "POST").attr("action" , "/user/sendMessage").submit();
	}
	
	function appendNode(){
		var divElem="<input type='text' style='margin:3' class='form-control' id='receiverIdExtra' name='receiverIdExtra'/>";
		$("input:last").after(divElem);
	}
	
	function deleteNode(){
		$("#receiverId:last").remove();
	}
	
	$(function() {
		$( "#send" ).on("click" , function() {
			fncSendMessage();
		});

		$( "#cancel" ).on("click", function() {
			history.go(-1);
		});
		
		$( "#addReceiver" ).on("click" , function() {
			appendNode();
		});
		
		$( "#deleteReceiver" ).on("click" , function() {
			deleteNode();
		});
		
		
		if(!${empty message.contents}){
			var mes = '${message.contents}'.replace("\r\n","<br>");
			var mes2 = 'RE:'+mes;
			$("#contents").val(mes2);
		}; 
	});
	

</script>
</head>

<body class="bodycss">

	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		<div class="page-header" >
	       <h3 class=" text-info">����������</h3>
	    </div>
	
		<form class="form-horizontal formbg">
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�޴»�� &nbsp;&nbsp;
		    <button type="button" class="search" id="addReceiver" style='height:30px'>�߰�</button>
		    <button type="button" class="search" id="deleteReceiver" style='height:30px'>����</button></label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="receiverId" name="receiverId" value="${!empty message.senderId? message.senderId :""}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label"></label>
		    <div class="col-sm-4">
				<p><textarea style='height:150px' rows="10" cols="50" name="contents" id="contents">${!empty message.contents? message.contents:""}</textarea></p>
		    </div>
		  </div>
		  
		  <div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
			    	<button type="button" class="btn" id="send">������</button>
			    	<button type="button" class="btn" id="cancel">���</button>
			    </div>
		  </div>
		
		</form>
	</div>