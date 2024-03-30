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
		<h1 align="center">Home Masters</h1>
	<center><a href="./Logout.jsp">Logout</a></center>
	<hr>
	<h2 align="center">Dashboard</h2>
	<center>
		Type: 
		<select name="selType" id="type">
			<option>Select</option>
			<option value="House">House</option>
			<option value="Apartment">Apartment</option>
			<option value="Condo">Condo</option>
		</select>
	</center><br>
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
							+ "<td><a href='SendEmail.jsp?propId=" + rs.getString("PropertyId") + "'><img src='../images/1.jpg' width='100px' height='100px'></a></td></tr>");
				}
				rs.close();
				ps.close();
				conn.close();
			%>
		</table>
	</div>

	<button onclick="downloadPDF()">Download PDF</button>
	<script src="../assets/jquery-3.2.1.min.js"></script>

	<script>
		function downloadPDF() {
			window.location.href = "./DownloadPDF.jsp";
		}

		function fetchData() {
			var type = document.getElementById("type").value;
			console.log(type);
			$.ajax({
				url: "fetchData.jsp",
				data: { type: type },
				method: "POST",
				success: function (data) {
					$("#result").empty();

					$("#result").html(data);
				},
				error: function (error) {
					console.log("Error: " + error);
				}
			});
		}

		$("#type").on("input", fetchData);
	</script>
</body>
</html>