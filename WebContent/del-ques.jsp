<%@page import="java.sql.*"%>
<%@page errorPage="handler.jsp"%>
<%
	String qno = request.getParameter("qno");
	String qtype = (String) session.getAttribute("qtype");
	Class.forName("com.mysql.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
	PreparedStatement ps = c.prepareStatement("SELECT sno FROM " + qtype);
	ResultSet rs = ps.executeQuery();
	int i = 0;
	while (rs.next() && i < Integer.parseInt(qno)) {
		i++;
		qno = rs.getString("sno");
	}
	ps = c.prepareStatement("DELETE FROM " + qtype + " WHERE sno = ?");
	ps.setString(1, qno);
	ps.executeUpdate();
%>
<script>
	alert("Question deleted!");
	window.location = "admin-dashboard.html";
</script>