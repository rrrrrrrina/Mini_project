<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
      pageContext.setAttribute("crcn", "\r\n");
      pageContext.setAttribute("br", "<br/>");
%>

<html>
<head>
	<title>쪽지상세보기</title>
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

		$(function() {
			$( "#confirm" ).on("click" , function() {
				history.go(-1);
			});
			
			$( "#reply" ).on("click" , function() {
				self.location = "/user/sendMessage?messageNo="+$("#messageNo").val();
			});
		

			if(!${empty message.contents}){
				var mes = '${message.contents}'.replace("\r\n","<br/>");
				$("#contents").val(mes);
			}; 
		});
	</script>
	
</head>

<body class="bodycss">
	<jsp:include page="/layout/toolbar.jsp" />
		<input type="hidden" id="messageNo" value='${message.messageNo}'/>

		<div class="container">
	
		<div class="page-header" style='text-align:left'>
	       <h3 class=" text-info">쪽지상세보기</h3>
	    </div>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>보낸사람</strong></div>
			<div class="col-xs-4 col-md-2">${message.senderId}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>보낸날짜</strong></div>
			<div class="col-xs-4 col-md-2">${message.receiveredDate}</div>
		</div>
		<hr/>
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>받은메세지</strong></div>
	  		<div class="col-xs-4 col-md-2 "><p><textarea style='height:150px' rows="10" cols="50" name="contents" id="contents">${!empty message.contents? message.contents:""}</textarea></p></div>
		</div>
		<hr/>
		<div class="form-group">
				<div class="col-md-12 text-center">
			    	<button type="button" class="btn" id="confirm" >확인</button>
			    	<button type="button" class="btn" id="reply">답장하기</button>
			    </div>
		</div>
 	</div>
</body>

</html>
