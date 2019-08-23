<%@page errorPage="handler.jsp"%>
<%@page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
	PreparedStatement ps;
	String s;
	s = request.getParameter("sub");
	ps = con.prepareStatement("INSERT INTO "+s+" (question,a,b,c,d,answer) values(?,?,?,?,?,?)");
	String s1 = request.getParameter("a");
	if (s1.equalsIgnoreCase("null")) {
		out.println(
				"<script>alert('Please select a language!'); window.location = 'add-question.html';</script>");
	} else {
		ps.setString(1, request.getParameter("question"));
		ps.setString(2, request.getParameter("a1"));
		ps.setString(3, request.getParameter("a2"));
		ps.setString(4, request.getParameter("a3"));
		ps.setString(5, request.getParameter("a4"));
		ps.setString(6, s1);
		ps.executeUpdate();
		out.println(
				"<script>alert('Question successfully added to the database!'); window.location = 'admin-dashboard.html';</script>");
	}
%>