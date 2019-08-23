<%@page errorPage="handler.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Login</title>
</head>
<body background="2.jpg">
	<h1 align="center">Student Login Page</h1>
	<br>
	<br>
	<%
		String cook1 = "", cook2 = "";
		Cookie[] ca = request.getCookies();
		if (ca != null) {
			for (Cookie c : ca) {
				String x = c.getName();
				if (x.equalsIgnoreCase("cname")) {
					cook1 = c.getValue();
				}
				if (x.equalsIgnoreCase("cpassword")) {
					cook2 = c.getValue();
				}
			}
		}
	%>
	<form action="student-login.jsp" method="post">
		<br> Input the student User-name<br> <input type="text"
			name="name" value="<%=cook1%>" required /><br> <br>Input password<br> <input
			type="password" name="password" value="<%=cook2%>" required /><br> <br> <input
			type="submit" value="Login" required/>
	</form>
	<br> New user?
	<a href="register-student.html">Click here to register</a>
</body>
</html>