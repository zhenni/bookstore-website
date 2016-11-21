<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj) {
	if (form_obj.isbn.value == "") {
		alert("please enter the isbn of book you want to give feedback.");
		return false;
	}

	if (form_obj.score.value == "") {
		alert("please enter the numerical score(0 = terrible, 10 = masterpiece).");
		return false;
	}

	if (form_obj.comments.value == "") {
		alert("please enter the short comment text.");
		return false;
	}

	if (form_obj.date.value == "") {
		alert("please enter the date(yyyy-MM-dd hh:mm:ss)");
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
				<label for="login">Give Feedback</label>
			</div>
	
	<%
	String isbn = request.getParameter("isbn");
	if(isbn  == null ){
	%>
		
		<div class="formBoxDivForm">
		<form name="haha" method=get onsubmit="return check_all_fields(this)" action="feedbackRecording.jsp">
			<div>
				<li><label for="isbn">isbn</label></li>
				<input type="text" name="isbn" length=10 placeholder="isbn of the book">
			</div>
			<div>
				<li><label for="score">score</label></li>
				<input type="number" name="score" length=5 placeholder="score of the feedback">
			</div>
			<div>
				<li><label for="comments">comments</label></li>
				<input type="text" name="comments" length=200 placeholder="short comments">
			</div>
			
			<button type="submit"> Submit</button>
		</form>
		</div>
	<%

	} else {
		java.util.Date timeDate = new java.util.Date();
		java.sql.Timestamp stamp = new java.sql.Timestamp(timeDate.getTime());
	
		int score = Integer.parseInt(request.getParameter("score"));
		String comment = request.getParameter("comments");
			
		bookstore.Connector con = new Connector();
		bookstore.Book.setConfiguration(con.stmt);
	%>  

	<%
	if(Book.giveFeedback(isbn, user.u_id, score, comment, stamp) != -1){
	%>
		<p>Add successfully.</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="feedbackRecording.jsp"> Try again. </a></p>
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
