<html>
<body bgcolor="LightSteelBlue">
<%@  page import="java.sql.*"   %>
<%@  page import="java.util.*"   %>
<%

String eventid=request.getParameter("name");
String place=request.getParameter("city");
String date=request.getParameter("date");
String time=request.getParameter("time");

try
{

Class.forName("oracle.jdbc.driver.OracleDriver");
	
		Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","mansi");
Statement s = c.createStatement();
String s1="update  from event where event_id='"+eventid+"'";


ResultSet result1=s.executeUpdate(s1);


		while(result1.next())
		{


out.println("<html><body><div style=background-color:black> <p> SUMMARY </p></div></body></html>");    

out.println("EVENT ID"+eventid);
out.println("<br>");
out.println("<br>");
out.println("CITY="+place);
out.println("<br>");
out.println("<br>");
out.println("DATE="+date);
out.println("<br>");
out.println("<br>");
out.println("TIME="+time);
out.println("<br>");
out.println("<br>");
 }

}
catch(SQLException e)
		{
			System.out.println(e);	
		}		
		catch(Exception i){System.out.println(i);}
	



%>
</body>
</html>