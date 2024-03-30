<%@page import="Database.DBConnection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
    </head>
    <body>
		<h1 align="center">HomeMasters</h1>
	<hr>
	<div id="result">
	<table align="center" cellpadding="10">
		<tr>
			<th>Property ID</th>
			<th>Property Owner Name</th>
			<th>Property Name</th>
			<th>Address</th>
			<th>Type</th>
			<th>Additional Features</th>
			<th>Rent per Month</th>
			<th>Image</th>
			<th>Apply for Rent</th>
		</tr>
		<%
				Connection conn = DBConnection.getConnection();
				String sql = "SELECT * FROM PropertyOwnerMaster PO, PropertyMaster PM WHERE PO.OwnerId = PM.OwnerId";

				PreparedStatement ps = conn.prepareStatement(sql);

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					out.println("<tr>"
					+ "<td>" + rs.getInt("PropertyId") + "</td>"
					+ "<td>" + rs.getString("FullName") + "</td>"
					+ "<td>" + rs.getString("PropertyName") + "</td>"
					+ "<td>" + rs.getString("Address") + "</td>"
					+ "<td>" + rs.getString("Type") + "</td>"
					+ "<td>" + rs.getString("AdditionalFeatures") + "</td>"
					+ "<td>" + rs.getDouble("RentPerMonth") + "</td>"
					+ "<td><img src='.." + rs.getString("ImagePath") + "' width='100px' height='100px'></td>"
					+ "<td><a href='SendEmail.jsp?propId="+ rs.getString("PropertyId") + "'><img src='../images/1.jpg' width='100px' height='100px'></a></td></tr>");
				}
				rs.close();
				ps.close();
				conn.close();
		%>
	</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<script>
		window.print();
	</script>
	
</body>
</html>


</table>
</body>
</html>
