<%@page import="java.sql.*"%>
<%
	String username = request.getParameter("username");
	String p1 = request.getParameter("p1");
	String p2 = request.getParameter("p2");
	if (!p1.equals(p2)) {
		out.println(
				"<script>alert('Passwords do not match! Enter again!');window.location = 'register-student.html';</script>");
	} else if ((p2 = request.getParameter("mno")).length() != 10) {
		out.println(
				"<script>alert('Mobile Number should be exactly 10 digits long!');window.location = 'register-student.html';</script>");
	} else if (username.length() >= 35) {
		out.println(
				"<script>alert('Username should be less than 35 characters');window.location = 'register-student.html';</script>");
	} else if (p1.length() < 5) {
		out.println(
				"<script>alert('Password should be more than 5 characters');window.location = 'register-student.html';</script>");
	} else {
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
		PreparedStatement ps = c.prepareStatement("SELECT * FROM student WHERE username = ?");
		ps.setString(1, username);
		ResultSet rs = ps.executeQuery();
		int count = 0;
		while (rs.next()) {
			count++;
		}
		if (count == 0) {
			ps = c.prepareStatement("INSERT INTO student(username,password,mno) VALUES(?,sha(?),?)");
			ps.setString(1, username);
			ps.setString(2, p1);
			ps.setString(3, p2);
			ps.executeUpdate();
			out.println(
					"<script>alert('New student registered!');window.location = 'student-login.html';</script>");
		} else {
			out.println(
					"<script>alert('Username already exists! Enter a new username!');window.location = 'register-student.html';</script>");
		}
	}
%>