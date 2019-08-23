<%@include file="update-question.html" %>
<%@page errorPage="handler.jsp"%>
<%@page import="java.sql.*"%><br>
<br>
<hr>
<br>
<b>Select the question you want to update : </b>
<br>
<br>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
	String s1 = "";
	s1 = request.getParameter("qtype");
	session.setAttribute("qtype", s1);
	if (s1 == null) {
		out.println(
				"<script>alert('Please select a language!'); window.location = 'update-question.html';</script>");
	} else {
		ResultSet r;
		PreparedStatement ps = c.prepareStatement("SELECT question FROM "+s1);
		r = ps.executeQuery();
		int count = 1;
%>
<form action="update-ques.jsp">
	<%
		while (r.next()) {
				out.print(count + ". " + r.getString(1));
	%>
	<input type="radio" name="qno" value=<%=count%> /><br>
	<%
		count++;
			}
			if (count == 1) {
				out.println(
						"<script>alert('No question found');</script><a href='add-question.html'>Click here to add questions</a>");
			}
		}
	%><br> <br> <input type="submit" value="Update" />
</form>