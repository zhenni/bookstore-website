<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj) {
	if (form_obj.author1.value == "") {
		alert("please enter the login name of one of the authors.");
		return false;
	}
	if (form_obj.author2.value == "") {
		alert("please enter the login name of the other author.");
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
				<label for="login">Two degree of Separation</label>
			</div>
	<%
	String author1 = request.getParameter("author1");
	if(author1  == null ){
	%>
	
		<div class="formBoxDivForm">
		<form name="degree" method=get onsubmit="return check_all_fields(this)" action="2degree.jsp">
			<div>
				<li><label for="author1">author name</label></li>
				<input type="text" name="author1" length=20 placeholder="name of one of the author">
			</div>
			<div>
				<li><label for="author2">the other author name</label></li>
				<input type="text" name="author2" length=20 placeholder="name of the other author">
			</div>
			<button type="submit"> Submit</button>
		</form>
		</div>

	<%

	} else {

		
		String author2 = request.getParameter("author2");
		
		Connector con = new Connector();
		Book.setConfiguration(con.stmt);
	%>  

	<div id="result">
	<%=Book.giveSeparationDegree(author1, author2)%>
	</div>
	
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
