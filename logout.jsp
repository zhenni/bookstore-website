<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store Logout</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>



<body>
<%
if (!session.isNew()){
	User user = (User)session.getAttribute("user");
	if (user == null) response.sendRedirect("index.html");
	if (user.u_id == -1) response.sendRedirect("index.html");
	if (user == null) user = new User();
	BookStore.logout(user);
	response.sendRedirect("index.html");
}else{
	response.sendRedirect("index.html");
}
%>
</body>

</html>
