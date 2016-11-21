<%@ page language="java" import="bookstore.*" %>
<html>
<head>
<title>Book Store Login</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<script LANGUAGE="javascript">
function check_all_fields(form_obj){
	if( form_obj.login_name.value == ""){
		alert("Please enter your login name");
		return false;
	}
	if( form_obj.password.value == ""){
		alert("Please enter your password");
		return false;
	}
	return true;
}

</script> 
</head>
<body>

	<div class="header">
		<div class="header-title">
			WZ & SY 's Book Store
		</div>
		<div class="login-div">
			<button class="login-button"><a href="login.jsp">login</a></button>
			<button class="login-button"><a href="register.jsp">register</a></button>
		</div>
	</div>
	
	<div class="content">
		<div class="left-side">
			<ul>
				<li><div class="slide"><a href="login.jsp">login</a></div></li>
				<li><div class="slide"><a href="register.jsp">register</a></div></li>
			</ul>
		</div>
		
		<div class="formBoxDiv">
			<div class="formBoxDivHeader">
				<label for="login">Login</label>
			</div>

<%
String login_name = request.getParameter("login_name");
if(login_name  == null ){
%>

	<div class="formBoxDivForm">
	
	<form name="login" method=post onsubmit="return check_all_fields(this)" action="login.jsp">
		<div>
			<li><label for="login_name">login name:</label></li>
			<input type=text name="login_name" length=10 placeholder="Enter your login name">
		</div>
		<div>
			<li><label for="password">password:</label></li>
			<input type="password" name="password" length=10 placeholder="password">
		</div>
		<button type="submit"> Submit</button>
	</form>
	
	</div>

<%

} else {

	String password = request.getParameter("password");
	bookstore.Connector con = new Connector();
	bookstore.BookStore.setConfiguration(con.stmt);
	bookstore.User.setConfiguration(con.stmt);
	bookstore.User user = new User();
%>  

	<%
	if(bookstore.BookStore.login(user, login_name, password)){
		session.setAttribute("user",user);
		con.closeConnection();
		response.sendRedirect("ui.jsp");
	%>
		<p>Success</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="login.jsp"> Try to login again. </a></p>

	<%
	}
%> 
<BR>
  

<%
  con.closeConnection();
}  // We are ending the braces for else here
%>

</div>


</body>
