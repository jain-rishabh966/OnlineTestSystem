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
	ps = c.prepareStatement("SELECT question,a,b,c,d,answer FROM " + qtype + " WHERE sno = ?");
	ps.setString(1, qno);
	rs = ps.executeQuery();
	String q = "", aa = "", bb = "", cc = "", dd = "", ans = "";
	while (rs.next()) {
		q = rs.getString("question");
		aa = rs.getString("a");
		bb = rs.getString("b");
		cc = rs.getString("c");
		dd = rs.getString("d");
		ans = rs.getString("answer");
	}
%>
<%ps = c.prepareStatement("SELECT sno FROM " + qtype);
	rs = ps.executeQuery();
	i = 0;
	while (rs.next() && i < Integer.parseInt(qno)) {
		i++;
		qno = rs.getString("sno");
	}
	ps = c.prepareStatement("DELETE FROM " + qtype + " WHERE sno = ?");
	ps.setString(1, qno);
	ps.executeUpdate();
%>
<form action="add-question.jsp" method="post">
	<br> <u><b>Update Question -</b><i> <%=qtype = qtype.toUpperCase()%></i></u><br>
	<br> <br> <br> <input type="text" name="sub"
		value=<%=qtype%> required><br> <br>Question<br>
	<textarea rows="5" cols="100" name="question"
		placeholder="Enter your question here" required><%=q%></textarea>
	<br> <br> <br> (A) <input type="text" name="a1"
		value=<%=aa%> required></input><br> (B) <input type="text"
		name="a2" value=<%=bb%> required></input><br> (C) <input
		type="text" name="a3" value=<%=cc%> required></input><br> (D) <input
		type="text" name="a4" value=<%=dd%> required></input><br> <br>
	<br> Correct option :
	<%
		if (ans.equals("a")) {
			out.println(
					"(A)<input type=\"radio\" name=\"a\" value=\"a\" checked></input>(B)<input type=\"radio\" name=\"a\" value=\"b\"></input> (C)<input type=\"radio\" name=\"a\" value=\"c\"></input>(D)<input type=\"radio\" name=\"a\" value=\"d\"></input>");
		} else if (ans.equals("b")) {
			out.println(
					"(A)<input type=\"radio\" name=\"a\" value=\"a\"></input>(B)<input type=\"radio\" name=\"a\" value=\"b\" checked></input> (C)<input type=\"radio\" name=\"a\" value=\"c\"></input>(D)<input type=\"radio\" name=\"a\" value=\"d\"></input>");
		} else if (ans.equals("c")) {
			out.println(
					"(A)<input type=\"radio\" name=\"a\" value=\"a\"></input>(B)<input type=\"radio\" name=\"a\" value=\"b\"></input> (C)<input type=\"radio\" name=\"a\" value=\"c\" checked></input>(D)<input type=\"radio\" name=\"a\" value=\"d\"></input>");
		} else {
			out.println(
					"(A)<input type=\"radio\" name=\"a\" value=\"a\"></input>(B)<input type=\"radio\" name=\"a\" value=\"b\"></input> (C)<input type=\"radio\" name=\"a\" value=\"c\"></input>(D)<input type=\"radio\" name=\"a\" value=\"d\" checked></input>");
		}
	%>
	<br> <br> <input type="submit" value="SAVE"></input>
</form>
