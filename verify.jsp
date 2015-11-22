<html>
<body>
<%@  page import="java.sql.*"   %>
<%@  page import="java.util.*"   %>
<%
String user=request.getParameter("user");

String pass=request.getParameter("pass");

try
{
Class.forName("oracle.jdbc.driver.OracleDriver");
	
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","mansi");
Statement s = c.createStatement();
String s1="select * from  user5 where   username='"+user+"'and pass='"+pass+"'";
ResultSet rs=s.executeQuery(s1);

 while(rs.next()) { 
            out.println("WELCOME="+rs.getString(1));
out.println("<html><body bgcolor=lemonchiffon></body></html>");
out.println("<html><body><p font size=500  align=center> DETAILS</body></html>");
out.println("<br>");
out.println("<br>");
out.println("<br>");
out.println("<br>");
out.println("<br>");
out.println("<br>");
out.println("<br>");
out.println("<br>");
//out.println("WELCOME="+rs.getString(1));
out.println("<br>");
out.println("<html><body><form action=button3.html><input type=submit name=submit value=proceed></form></body></html>");

}


else
{
out.println("<html><body><p font size=500 align=center>User has not registered</html></body>");
out.println("<html><body><form action=intro.html><input type=submit name=submit value=proceed></form></body></html>");
out.println("<html><body><form action=click.html><input type=submit name=form value=register /></body></html>");

}
rs.close();
}
catch(Exception e){out.println(e);} 
    

    %>

</body>
</html>