<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<script LANGUAGE="javascript">
function check_all_fields(form_obj) {
	
	if (form_obj.author_id.value == "" && form_obj.publisher_id.value == ""
			&& form_obj.title.value == "" && form_obj.subject.value == "") {
		alert("Enter at least one information about the books you want to browse.");
		return false;
	}
	
	return true;
}

</head>
</script>

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
				<label for="login">Browsing books</label>
			</div>
	
	
	<%
	
	String orderBy = request.getParameter("orderBy");
	if(orderBy == "0" || orderBy == null){
	%>
		<div class="formBoxDivForm">
		<form name="browing" method=get onsubmit="return check_all_fields(this)" action="browing.jsp">
			<div>
				<li><label for="author_id">author's name</label></li>
				<input type="text" name="author_id" length=10 placeholder="author's name">
			</div>
			<div>
				<li><label for="publisher_id">publisher's name</label></li>
				<input type="text" name="publisher_id" length=10 placeholder="publisher's name">
			</div>
			<div>
				<li><label for="title">title</label></li>
				<input type="text" name="title" length=10 placeholder="title">
			</div>
			<div>
				<li><label for="subject">subject</label></li>
				<input type="text" name="subject" length=20 placeholder="subject">
			</div>
			<div>
				<li><label for="orderBy">order by</label></li>
				<select name="orderBy">
					<option value="1" selected="selected">year</option>
					<option value="2">average score of the feedbacks</option>
					<option value="3">average score of the trusted user feedbacks</option>
				</select>
			</div>
			<button type="submit"> Submit</button>
		</form>
		</div>

	<%

	} else {
		String author_id = request.getParameter("author_id");
		String publisher_id = request.getParameter("publisher_id");
		String title = request.getParameter("title");
		String subject = request.getParameter("subject");
	
	
		int order = Integer.parseInt(orderBy);
		bookstore.Connector con = new Connector();
		bookstore.Book.setConfiguration(con.stmt);
		bookstore.PrintResult.setConfiguration(con.stmt);
	%>  
	<div class="formBoxTable">
	<%=Book.findHTML(user.u_id, author_id, publisher_id, title, subject, order)%>
	</div>
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
