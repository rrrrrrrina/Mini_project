<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<title>��� ��ǰ ����</title>

</head>
<body>
	����� ��� ��ǰ�� �˰� �ִ�
<br>
<br>

<c:set var='i' value='0'/>
	<c:forEach var="history" items="${history}">
		<a href="/product/getProduct?prodNo=${history}&menu=search"	target="rightFrame">${history}</a><br/>
	</c:forEach>
</body>
</html>