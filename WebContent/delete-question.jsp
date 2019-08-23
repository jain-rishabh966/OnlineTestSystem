<%@page errorPage="handler.jsp"%>
<%@include file="delete-question.html"%>
<%@page import="java.sql.*"%><br>
<br>
<hr>
<br>
<b>Select the question you want to delete : </b>
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
				"<script>alert('Please select a language!'); window.location = 'delete-question.html';</script>");
	} else {
		ResultSet r;
		if (s1.equals("c")) {
			PreparedStatement ps = c.prepareStatement("SELECT question FROM c");
			r = ps.executeQuery();
		} else if (s1.equals("ds")) {
			PreparedStatement ps = c.prepareStatement("SELECT question FROM ds");
			r = ps.executeQuery();
		} else {
			PreparedStatement ps = c.prepareStatement("SELECT question FROM java");
			r = ps.executeQuery();
		}
		int count = 1;
%>
<form action="del-ques.jsp">
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
	%><br> <br> <input type="submit" value="Delete" />
</form>