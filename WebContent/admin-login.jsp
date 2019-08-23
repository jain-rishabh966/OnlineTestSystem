<%@page import="java.sql.*"%>
<%@page errorPage="handler.jsp"%>
<%
	int c = 0;
	String key = request.getParameter("key");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
	PreparedStatement ps = con.prepareStatement("SELECT password FROM admin WHERE password = SHA(?)");
	ps.setString(1, key);
	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
		c++;
	}
	if (c == 0) {
		out.print(
				"<script>alert('The key you entered is incorrect.. Please enter a valid key!');window.location='admin-login.html';</script>");
	} else {
		out.print("<script>alert('Welcome!');window.location='admin-dashboard.html';</script>");
	}
%>