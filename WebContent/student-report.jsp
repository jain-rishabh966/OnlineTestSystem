<%@page import="java.sql.*"%>
<%@page errorPage="handler.jsp" %>
<body>
	<br>
	<u>
		<h1 align="center">Student Report</h1>
	</u>
	<br>
	<br>
	<%
		int c = 1;
		int x = 0;
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
		PreparedStatement ps = con.prepareStatement("SELECT * FROM test WHERE username = ?");
		ps.setString(1, (String) session.getAttribute("username"));
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			x++;
		}
		if (x == 0) {
			out.println(
					"<script>window.location = 'give-test.html';alert('No Tests Found! Please give a test to view its report');</script>");
		}
		String mno = "**********";
		PreparedStatement p = con.prepareStatement("SELECT * FROM student WHERE username = ?");
		ps.setString(1, (String) session.getAttribute("username"));
		ResultSet r = ps.executeQuery();
		while (r.next()) {
			mno = (String) (session.getAttribute("mno"));
		}
	%>
	<h3>
		<u>Student username</u> :
		<%=session.getAttribute("username")%><br> <u>Mobile Number</u> :
		<%=mno%><br> <br>
	</h3>
	<p align="center">
	<table border="1">
		<tr>
			<th>S.no.</th>
			<th>Subject</th>
			<th>Marks</th>
			<th>Correct answers</th>
			<th>Wrong answers</th>
			<th>Questions left</th>
			<th>Total Questions</th>
			<th>Accuracy</th>
		</tr>
		<%
			int marks = 0;
			int tot = 0, corr = 0, wro = 0;
			rs = ps.executeQuery();
			while (rs.next()) {
				int cor = Integer.valueOf(rs.getString("correct"));
				int wr = Integer.valueOf(rs.getString("wrong"));
				int ques = Integer.valueOf(rs.getString("questions"));
				int left = ques - wr - cor;
		%>

		<tr>
			<td><%=c%></td>
			<td><%=rs.getString("subject")%></td>
			<td><%=rs.getString("marks")%></td>
			<td><%=cor%></td>
			<td><%=wr%></td>
			<td><%=left%></td>
			<td><%=ques%></td>
			<td><%=rs.getString("accuracy") + "%"%></td>
		</tr>
		<%
			marks += ((cor * 4) - (wr));
				tot += ques;
				corr += cor;
				wro += wr;
				c++;
			}
			float yz = 0;
			if (x != 0) {
				yz = (float) (corr * 100) / (float) (corr + wro);
			}
		%>
		<tr>
			<td>Total</td>
			<td>-></td>
			<td><%=marks + "/" + (tot * 4)%></td>
			<td><%=corr%></td>
			<td><%=wro%></td>
			<td><%=tot - corr - wro%></td>
			<td><%=tot%></td>
			<td><%=yz + "%"%></td>
		</tr>
	</table>
	<p align="center">

		<form action="student-log.jsp"><input type="submit" value="OK" /></form>
	</p>
</body>