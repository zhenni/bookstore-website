<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj) {
	if (form_obj.loginName.value == "") {
		alert("please enter the login name of the user that you want to trust or not trust.");
		return false;
	}
	if (form_obj.isTrust.value == "") {
		alert("pleas enter your choice of trust or untrust?(t/u)");
		return false;
	}
	return true;
}
</script>

</head>



<body>
<%
if (!session.isNew()){
	User user = (User)session.getAttribute("user");
	if (user == null) response.sendRedirect("index.html");
	if (user.u_id == -1) response.sendRedirect("index.html");
	if (user == null) user = new User();
	int authority = user.authority;
%>
	<div class="header">
		<div class="header-title">
			WZ & SY 's Book Store
		</div>
		<div class="login-div">
			<button class="login-button">User: <%=user.login_name%></button>
			<button class="login-button"><a href="logout.jsp">Logout</a></button>
		</div>
	</div>
	
	<div class="content">
		<div class="left-side">
			<ul>
				
			
		
<%
if (authority == BookStore.ADMIN){
%>
	<li><div class="slide"><a href="newBook.jsp">New Book</a></div></li>
	<li><div class="slide"><a href="moreBooks.jsp">Arriving of more books</a></div></li>
	
<%
}
%>
<li><div class="slide"><a href="orderBook.jsp">Order a book</a></div></li>
<li><div class="slide"><a href="feedbackRecording.jsp">Feedback Recording</a></div></li>
<li><div class="slide"><a href="usefulnessRating.jsp">Usefulness Rating</a></div></li>
<li><div class="slide"><a href="trustRecording.jsp">Trust recordings</a></div></li>
<li><div class="slide"><a href="browing.jsp">Book browsing</a></div></li>
<li><div class="slide"><a href="usefulFeedbacks.jsp">Useful feedbacks</a></div></li>
<li><div class="slide"><a href="suggestions.jsp">Buying suggestions</a></</div></li>
<li><div class="slide"><a href="2degree.jsp">'Two degrees of separation'</a></div></li>
<li><div class="slide"><a href="statistics.jsp">Statistics</a></div></li>
<li><div class="slide"><a href="awards.jsp">User Awards</a></div></li>


			</ul>
		</div>
		
		
	
	
		<div class="formBoxDiv">
			<div class="formBoxDivHeader">
				<label for="login">Trust Recording</label>
			</div>
	
	
	<%
	String login_name = request.getParameter("login_name");
	if(login_name  == null ){
	%>
		<div class="formBoxDivForm">
		<form name="trust" method=get onsubmit="return check_all_fields(this)" action="trustRecording.jsp">
			<div>
				<li><label for="login_name">login name</label></li>
				<input type="text" name="login_name" length=20 placehoulder="login name of the user">
			</div>
			<div>
				<li><label for="isTrust">trust or not trust</label></li>
				<select name="isTrust">
					<option value="1" selected="selected">trust</option>
					<option value="0">not trust</option>
				</select>
			</div>
			<button type="submit"> Submit</button>
		</form>
		</div>
	<%

	} else {

		bookstore.Connector con = new Connector();
		bookstore.User.setConfiguration(con.stmt);
		
		int u2_id = User.getUserId(login_name);
		int trust = Integer.parseInt(request.getParameter("isTrust"));
	%>  

	<%
	if(u2_id > -1 && User.setTrustOrNot(user.u_id, u2_id, trust) != -1){
	%>
		<p>Add successfully.</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="trustRecording.jsp"> Try again. </a></p>
	<%
	}
%> 
<BR>
<%
  con.closeConnection();
}  // We are ending the braces for else here
%>

	
	</div>
	
	
<%
}else{
	response.sendRedirect("index.html");
}


%>

</body>

</html>
