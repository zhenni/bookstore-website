<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj){
	if( form_obj.isbn.value == ""){
		alert("please enter the isbn of book you want to order.");
		return false;
	}
	if( form_obj.copy_num.value == ""){
		alert("please enter the number of books you want to order.");
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
				<label for="login">New order</label>
			</div>
	
	<%
	String isbn = request.getParameter("isbn");
	if(isbn  == null ){
	%>

		<div class="formBoxDivForm">
		<form name="order" method=get onsubmit="return check_all_fields(this)" action="orderBook.jsp">
			<div>
				<li><label for="isbn">isbn</label></li>
				<input type="text" name="isbn" length=10 placeholder="isbn of the book">
			</div>
			<div>
				<li><label for="copy_num">number of the copies you want</label></li>
				<input type="number" name="copy_num" length=10 placeholder="number of copies">
			</div>
			<button type="submit"> Submit</button>
		</form>
		</div>
	<%

	} else {

		java.util.Date timeDate = new java.util.Date();
		java.sql.Timestamp stamp = new java.sql.Timestamp(timeDate.getTime());
		
		int copy_num = Integer.parseInt(request.getParameter("copy_num"));
		bookstore.Connector con = new Connector();
		bookstore.Order.setConfiguration(con.stmt);
	%>  

	<%
	if(Order.order(user.u_id, isbn, copy_num, stamp) != -1){
	%>
		<p>Order successfully.</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="orderBook.jsp"> Try again. </a></p>
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
