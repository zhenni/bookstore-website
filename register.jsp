<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj){
	if( form_obj.login_name.value == ""){
		alert("please enter the login_name you want to register.");
		return false;
	}
	if( form_obj.password.value == ""){
		alert("please enter the password.");
		return false;
	}
	if( form_obj.name.value == ""){
		alert("please enter your name.");
		return false;
	}
	if( form_obj.address.value == ""){
		alert("please enter your address.");
		return false;
	}
	if( form_obj.phone_num.value == ""){
		alert("please enter your phone number.");
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
				<label for="login">Register</label>
			</div>
	
	
	<%
	String login_name = request.getParameter("login_name");
	if(login_name == null ){
	%>
		<div class="formBoxDivForm">
		
		<form name="newUser" method=post onsubmit="return check_all_fields(this)" action="register.jsp">
			<div>
				<li><label for="login_name">loginname</label></li>
				<input type="text" name="login_name" length=20 placeholder="login_name">
			</div>
			<div>
				<li><label for="password">password</label></li>
				<input type="password" name="password" length=20 placeholder="password">
			</div>
			<div>
				<li><label for="name">name<label></li>
				<input type="text" name="name" length=20 placeholder="your name">
			</div>
			<div>
				<li><label for="address">address<label></li>
				<input type="text" name="address" length=20 placeholder="your address">
			</div>
			<div>
				<li><label for="phone_num">phone number<label></li>
				<input type="text" name="phone_num" length=20 placeholder="your phonenum">
			</div>
			
			

			<button type="submit"> Submit</button>
		</form>
		
		</div>
	<%

	} else {
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String phone_num = request.getParameter("phone_num");
		
		
		
		bookstore.Connector con = new Connector();
		bookstore.User.setConfiguration(con.stmt);
	%>  

	<%
	if (User.newUser(login_name, password, name, address, phone_num) != -1){
	%>
		<p>Register successfully.</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="newBook.jsp"> Try again. </a></p>
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

</html>
