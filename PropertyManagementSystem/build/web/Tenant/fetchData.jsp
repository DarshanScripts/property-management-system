<%@page import="Database.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");

	Connection conn = DBConnection.getConnection();
	String sql = "SELECT * FROM PropertyOwnerMaster PO, PropertyMaster PM WHERE PO.OwnerId = PM.OwnerId ";

	if (type != null && !type.isEmpty()) {
		sql += " AND Type = ?";
	}

	PreparedStatement ps = conn.prepareStatement(sql);
	if (type != null && !type.isEmpty()) {
		ps.setString(1, type);
	}

	ResultSet rs = ps.executeQuery();
%>
<table align="center" cellpadding="10" >
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
		while (rs.next()) {
			out.println("<tr><td>" + rs.getInt("PropertyId") + "</td>"
					+ "<td>" + rs.getString("FullName") + "</td>"
					+ "<td>" + rs.getString("PropertyName") + "</td>"
					+ "<td>" + rs.getString("Address") + "</td>"
					+ "<td>" + rs.getString("Type") + "</td>"
					+ "<td>" + rs.getString("AdditionalFeatures") + "</td>"
					+ "<td>" + rs.getDouble("RentPerMonth") + "</td>"
					+ "<td><img src='.." + rs.getString("ImagePath") + "' width='100px' height='100px'></td>"
					+ "<td><a href='SendEmail.jsp?propId=" + rs.getString("PropertyId") + "'><img src='../images/1.jpg' width='100px' height='100px'></a></td></tr>");
		}
		rs.close();
		ps.close();
		conn.close();
	%>
</table>
