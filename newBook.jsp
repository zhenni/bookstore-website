<%@ page language="java" import="bookstore.*"%>

<html>
<head>
<title>Book Store</title>
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script LANGUAGE="javascript">
function check_all_fields(form_obj){
	if( form_obj.isbn.value == ""){
		alert("please enter the isbn of book you want to add.");
		return false;
	}
	if( form_obj.title.value == ""){
		alert("please enter the title of book you want to add.");
		return false;
	}
	if( form_obj.year.value == ""){
		alert("please enter the year of the publication of book you want to add.");
		return false;
	}
	if( form_obj.copy_num.value == ""){
		alert("please enter the number of books you want to add.");
		return false;
	}
	if( form_obj.price.value == ""){
		alert("please enter the price of book you want to add.");
		return false;
	}
	if( form_obj.format.value == ""){
		alert("please enter the format of book you want to add.");
		return false;
	}
	if( form_obj.subject.value == ""){
		alert("please enter the subject of book you want to add.");
		return false;
	}
	if( form_obj.keywords.value == ""){
		alert("please enter the keywords of book you want to add.");
		return false;
	}
	if( form_obj.publisher.value == ""){
		alert("please enter the authors of book you want to add.");
		return false;
	}
	if( form_obj.authors.value == ""){
		alert("please enter the number of books you want to add.");
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
				<label for="login">New book</label>
			</div>
	<%
	String isbn = request.getParameter("isbn");
	if(isbn  == null ){
	%>
		
		<div class="formBoxDivForm">
		<form name="book" method=get onsubmit="return check_all_fields(this)" action="newBook.jsp">
			<div>
				<li><label for="isbn">isbn</label></li>
				<input type="text" name="isbn" length=20 placeholder="isbn of the book">
			</div>
			<div>
				<li><label for="title">title</label></li>
				<input type="text" name="title" length=20 placeholder="title of the book">
			</div>
			<div>
				<li><label for="year">year of publication</label></li>
				<input type="number" name="year" length=20 placeholder="year of publication">
			</div>
			<div>
				<li><label for="copy_num">number of copies</label></li>
				<input type="number" name="copy_num" length=20 placeholder="number of copies">
			</div>
			<div>
				<li><label for="price">price</label></li>
				<input type="number" name="price" length=20 placeholder="price of the book">
			</div>
			<div>
				<li><label for="format">format</label></li>
				<input type="text" name="format" length=20 placeholder="format of the book">
			</div>
			<div>
				<li><label for="subject">subject</label></li>
				<input type="text" name="subject" length=20 placeholder="subject of the book">
			</div>
			<div>
				<li><label for="keywords">keywords</label></li>
				<input type="text" name="keywords" length=20 placeholder="keywords of the book">
			</div>
			<div>
				<li><label for="publisher">publisher</label></li>
				<input type="text" name="publisher" length=20 placeholder="publisher of the book">
			</div>
			<div>
				<li><label for="authors">authors</label></li>
				<input type="text" name="authors" length=20 placeholder="authors of the book, split by ','">
			</div>

			<button type="submit"> Submit</button>
		</form>
		</div>

	<%

	} else {
		String title = request.getParameter("title");
		int year = Integer.parseInt(request.getParameter("year"));
		int copy_num = Integer.parseInt(request.getParameter("copy_num"));
		String price = request.getParameter("price");
		String format = request.getParameter("format");
		String subject = request.getParameter("subject");
		String keywords = request.getParameter("keywords");
		String publisher = request.getParameter("publisher");
		// Many authors
		String authors = request.getParameter("authors");
		java.util.HashSet<String> author_names = new java.util.HashSet<String>();
		author_names.add(authors);
		
		bookstore.Connector con = new Connector();
		bookstore.Book.setConfiguration(con.stmt);
	%>  

	<%
	if (Book.newBook(isbn, title, year, copy_num, price, format, subject, keywords, publisher, author_names) 
					!= -1){
	%>
		<p>New book added successfully.</p>
	<%
	}else {
	%>
		<p>Failed. Please try again</p><BR>
		<p><a href="newBook.jsp"> Try again. </a></p>
	<%
	}
%> 
<BR>

</div>
<%
  con.closeConnection();
}  // We are ending the braces for else here
%>

	
	
	
	
<%
}else{
	response.sendRedirect("index.html");
}


%>

</body>

</html>
