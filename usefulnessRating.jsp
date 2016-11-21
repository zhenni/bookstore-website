<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj) {
	if (form_obj.isbn.value == "") {
		alert("please enter the isbn of the book of the feedback you want to assess.");
		return false;
	}
	if (form_obj.login_name.value == "") {
		alert("please enter the login name of the user of the feedback you want to assess.");
		return false;
	}
	if (form_obj.score.value == "") {
		alert("please enter your numerical score(0 = 'useless', 1 = 'useful', 2 = 'very useful').");
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
				<label for="login">Usefulness Rating</label>
			</div>
	
	
	<%
	String isbn = request.getParameter("isbn");
	if(isbn  == null ){
	%>
		
		<div class="formBoxDivForm">
		<form name="usefulness" method=get onsubmit="return check_all_fields(this)" action="usefulnessRating.jsp">
			<div>
				<li><label for="isbn">isbn</label></li>
				<input type="text" name="isbn" length=10 placeholder="isbn of the book">
			</div>
			<div>
				<li><label for="login_name">login name</label></li>
				<input type="text" name="login_name" length=10 placeholder="login name">
			</div>
			<div>
				<li><label for="score">score</label></li>
				<input type="number" name="score" min="0" max="2" length=10 placeholder="numerical score">
			</div>
			<button type="submit"> Submit</button>
		</form>
		</div>
	<%

	} else {
		String login_name = request.getParameter("login_name");
		int score = Integer.parseInt(request.getParameter("score"));
		bookstore.Connector con = new Connector();
		bookstore.Book.setConfiguration(con.stmt);
		bookstore.User.setConfiguration(con.stmt);
		
		int u2_id = User.getUserId(login_name);
	%>  

	<%
	if(/*Book.showFeedbacks(user.u_id, isbn) != -1 &&*/ Book.haveGivenFeedback(isbn, u2_id) && Book.usefulnessRating(user.u_id, isbn, u2_id, score) != -1){
	%>
		<p>Add successfully.</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="usefulnessRating.jsp"> Try again. </a></p>
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
