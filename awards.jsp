<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj) {
	if (form_obj.numTop.value == "") {
		alert("please enter the number of top items you want to see.");
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
				<label for="login">User Awards</label>
			</div>
	
	
	<%
	String numTop = request.getParameter("numTop");
	if(numTop  == null ){
	%>
		
		<div class="formBoxDivForm">
		<form name="awards" method=get onsubmit="return check_all_fields(this)" action="awards.jsp">
			<div>
				<li><label for="numTop">number of top items</label></li>
				<input type="number" name="numTop" length=10 placehoulder="number of top items">
			</div>
			<button type="submit"> Submit</button>
		</form>
		</div>
	<%

	} else {

		
		int num = Integer.parseInt(numTop);
		
		bookstore.Connector con = new Connector();
		bookstore.BookStore.setConfiguration(con.stmt);
		bookstore.PrintResult.setConfiguration(con.stmt);
	%>  

	
	<div class="formBoxTable">
	<div id="result">
	<%=BookStore.displayAwardedUsersHTML(num)%>
	</div>
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
