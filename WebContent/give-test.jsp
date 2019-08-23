<%@page import="java.sql.*"%>
<%@page errorPage="handler.jsp" %>
<%
	String sub = (String) request.getParameter("sub");
	session.setAttribute("sub", sub);
	Class.forName("com.mysql.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
	PreparedStatement ps = c
			.prepareStatement("SELECT sno,question,a,b,c,d,answer FROM " + sub + " ORDER BY RAND() LIMIT 25");
	ResultSet rs = ps.executeQuery();
	int count = 0;
%>
<h1 align="center">Answer the following questions</h1>
<form action="evaluate.jsp" method="post">
	<%
		while (rs.next()) {
			count++;
			out.print(count + ".  " + rs.getString("question") + "<br><br><input type=\"radio\" name=\"x" + count
					+ "\"" + " value=\"a\">" + rs.getString("a") + "<br><input type=\"radio\" name=\"x" + count
					+ "\"" + " value=\"b\">" + rs.getString("b") + "<br><input type=\"radio\" name=\"x" + count
					+ "\"" + " value=\"c\">" + rs.getString("c") + "<br><input type=\"radio\" name=\"x" + count
					+ "\"" + " value=\"d\">" + rs.getString("d") + "<br><br>");
			session.setAttribute("co" + count, "" + rs.getInt("sno"));
		}
		session.setAttribute("cou", count + "");
		if (count == 0) {
			out.println(
					"<script>window.location = 'give-test.html';alert('No Questions Found in This Subject');</script>");
		}
	%>
	<input type="submit" value="Submit">
</form>