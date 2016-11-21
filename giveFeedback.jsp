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

	<p>User:admin <a href="logout.jsp">logout</a></p>

		<p>Give Feedback:<p>

		<form name="haha" method=get onsubmit="return check_all_fields(this)" action="giveFeedback.jsp">
			<div>
				<li><label for="isbn">isbn</label></li>
				<input type="text" name="isbn" length=10 placeholder="isbn of the book">
			</div>
			<div>
				<li><label for="score">score</label></li>
				<input type="text" name="score" length=5 placeholder="score of the feedback">
			</div>
			<div>
				<li><label for="comments">comments</label></li>
				<input type="text" name="comments" length=200 placeholder="short comments">
			</div>
			<div>
				<li><label for="date">date</label></li>
				<input type="date" name="date" length=20 placeholder="date">
			</div>
			<button type="submit"> Submit</button>
		</form>
		<p><a href="ui.jsp">Other Functionalities.</a></p>

</body>

</html>
