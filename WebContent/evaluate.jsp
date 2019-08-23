<%@page errorPage="handler.jsp" %>
<%@page import="java.sql.*"%>
<br>
<h1 align="center">Test Report</h1>
<br>
<br>
<br>
<p align="center">
<form action="student-log.jsp">
	<table border="1">
		<tr>
			<th rowspan="2">Question</th>
			<th rowspan="2">Answer</th>
			<th rowspan="2">Your Answer</th>
			<th rowspan="2">Status</th>
		</tr>
		<tr></tr>
		<tr></tr>
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinetest", "root", "root");
			PreparedStatement ps = con.prepareStatement(
					"SELECT question,a,b,c,d,answer FROM " + session.getAttribute("sub") + " WHERE sno = ?");
			int limit = Integer.parseInt((String) session.getAttribute("cou"));
			int c = 0;
			ResultSet rs;
			String ans = "";
			int correct = 0, wrong = 0, left = 0, marks = 0;
			while (c != limit) {
				out.println("<tr>");
				int sno = Integer.valueOf((String) session.getAttribute("co" + (c + 1)));
				ps.setInt(1, sno);
				rs = ps.executeQuery();
				String s = request.getParameter("x" + (c + 1));
				String a = "", b = "", d = "", e = "", question = "";
				while (rs.next()) {
					ans = rs.getString("answer");
					a = rs.getString("a");
					b = rs.getString("b");
					d = rs.getString("c");
					e = rs.getString("d");
					question = rs.getString("question");
				}
				out.println("<td>" + question + "</td>");
				if (ans.equals("a")) {
					out.println("<td>" + a + "</td>");
				} else if (ans.equals("b")) {
					out.println("<td>" + b + "</td>");
				} else if (ans.equals("c")) {
					out.println("<td>" + d + "</td>");
				} else if (ans.equals("d")) {
					out.println("<td>" + e + "</td>");
				}

				if (s == null) {
					out.println("<td>Not Atempted</td>");
					out.println("<td>Not Attempted</td>");
					left++;
				} else if ((ans).equals(s)) {
					if (s.equals("a")) {
						out.println("<td>" + a + "</td>");
					} else if (s.equals("b")) {
						out.println("<td>" + b + "</td>");
					} else if (s.equals("c")) {
						out.println("<td>" + d + "</td>");
					} else if (ans.equals("d")) {
						out.println("<td>" + e + "</td>");
					}
					out.println("<td>Correct</td>");
					correct++;
					marks += 4;
				} else {
					if (s.equals("a")) {
						out.println("<td>" + a + "</td>");
					} else if (s.equals("b")) {
						out.println("<td>" + b + "</td>");
					} else if (s.equals("c")) {
						out.println("<td>" + d + "</td>");
					} else if (ans.equals("d")) {
						out.println("<td>" + e + "</td>");
					}
					out.println("<td>Wrong</td>");
					wrong++;
					marks -= 1;
				}
				out.println("</tr>");
				c++;
			}
			float accuracy = 0;
			try {
				accuracy = (correct * 100) / (correct + wrong);
			} catch (Exception e) {

			}
			out.println("</table>");
			ps = con.prepareStatement(
					"INSERT INTO test(username,accuracy,marks,subject,questions,wrong,correct) values (?,?,?,?,?,?,?)");
			ps.setFloat(2, accuracy);
			ps.setString(3, marks + "/" + (4 * limit));
			ps.setInt(7, correct);
			ps.setInt(6, wrong);
			ps.setInt(5, limit);
			ps.setString(4, (String) session.getAttribute("sub"));
			ps.setString(1, (String) session.getAttribute("username"));
			ps.executeUpdate();
		%>
	</table>
	<input type="submit" value="OK" />
</form>