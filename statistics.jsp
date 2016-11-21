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
	if (form_obj.startTime.value == "") {
		alert("please enter the start time of the statistics:(yyyy-MM-dd hh:mm:ss)");
		return false;
	}
	if (form_obj.endTime.value == "") {
		alert("please enter the end time of the statistics:(yyyy-MM-dd hh:mm:ss)");
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
				<label for="login">Statistics</label>
			</div>
	
	
	<%
	String numTop = request.getParameter("numTop");
	if(numTop  == null ){
	%>

		<div class="formBoxDivForm">
		<form name="statistics" method=get onsubmit="return check_all_fields(this)" action="statistics.jsp">
			<div>
				<li><label for="numTop">number of top items</label></li>
				<input type="number" name="numTop" length=10 placeholder="number of top items">
			</div>
			<div>
				<li><label for="startTime">start time</label></li>
				<input type="date" name="startTime" length=20 placeholder="yyyy-MM-dd">
			</div>
			<div>
				<li><label for="endTime">end time</label></li>
				<input type="date" name="endTime" length=20 placeholder="yyyy-MM-dd">
			</div>
			<button type="submit">Submit</button>
		</form>
		</div>

	<%

	} else {

		java.util.Date timeDate = new java.util.Date();
		java.sql.Timestamp stamp = new java.sql.Timestamp(timeDate.getTime());
		
		int num = Integer.parseInt(numTop);
		
		String time1 = request.getParameter("startTime");
		String time2 = request.getParameter("endTime");
		time1 += " 01:00:00";
		time2 += " 01:00:00";
		
		java.sql.Timestamp stamp1, stamp2;
		java.text.DateFormat dateFormat;
		dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd kk:mm:ss", java.util.Locale.ENGLISH);
		dateFormat.setLenient(false);
		java.util.Date timeDate1 = dateFormat.parse(time1);
		stamp1 = new java.sql.Timestamp(timeDate1.getTime());
		java.util.Date timeDate2 = dateFormat.parse(time2);
		stamp2 = new java.sql.Timestamp(timeDate2.getTime());
		
		bookstore.Connector con = new Connector();
		bookstore.BookStore.setConfiguration(con.stmt);
		bookstore.PrintResult.setConfiguration(con.stmt);
	%>  

	
	<div class="formBoxTable">
	<%=BookStore.displayStatisticsHTML(num, stamp1, stamp2)%>
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
