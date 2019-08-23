<%@page import="java.sql.*"%>
<%@page errorPage="handler.jsp" %>
<%
	String username = request.getParameter("name");
	String password = request.getParameter("password");
	Cookie [] ca = request.getCookies();
	if(ca == null){
		
	} else {
		if(ca.length == 1){
			Cookie c1 = new Cookie("cname",username);
			Cookie c2 = new Cookie("cpassword",password);
			response.addCookie(c1);
			response.addCookie(c2);
		}
	}
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
	PreparedStatement ps = c
			.prepareStatement("SELECT password,mno FROM student WHERE username = ? AND password = sha(?)");
	ps.setString(1, username);
	ps.setString(2, password);
	ResultSet rs = ps.executeQuery();
	int count = 0;
	String mno = "";
	while (rs.next()) {
		count++;
		mno = (String) rs.getString("mno");
	}
	if (count == 0) {
		out.println("<script>alert('User not found!');</script>");
	} else {
		out.println("<script>alert('Welcome!');window.location = 'student-dashboard.html';</script>");
	}
	session.setAttribute("mno", mno);
	session.setAttribute("username", username);
	rs.close();
%>