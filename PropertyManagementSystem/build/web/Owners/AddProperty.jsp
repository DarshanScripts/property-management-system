<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Property</title>
    </head>
    <body>
        <h1 align="center">Home Masters</h1>
		<center><a href="./Dashboard.jsp">Dashboard</a></center>
		<hr>
        <h2 align="center">Add Property</h2>

		<form action="valAddProperty.jsp" method="POST">
			<table align="center" cellpadding="10">
				<tr>
					<th>Property Name</th>
					<td>
						<input type="text" name="txtPropName" value="<% if (request.getParameter("txtPropName") != null) out.println(request.getParameter("txtPropName")); %>" />
					</td>
				</tr>

				<tr>
					<th>Address</th>
					<td>
						<textarea name="txtaAdd" ><% if (request.getParameter("txtaAdd") != null) out.println(request.getParameter("txtaAdd")); %> </textarea>
					</td>
				</tr>
				
				<tr>
					<th>Type of Property</th>
					<td>
						<select name="selType">
							<option hidden>--Select--</option>
							<option>House</option>
							<option>Apartment</option>
							<option>Condo</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>Additional Features</th>
					<td>
						<textarea name="txtaAddFeat" ><% if (request.getParameter("txtaAddFeat") != null) out.println(request.getParameter("txtaAddFeat")); %> </textarea>
					</td>
				</tr>
				
				<tr>
					<th>Rent per Month</th>
					<td>
						<input type="text" name="txtRent" value="<% if (request.getParameter("txtRent") != null) out.println(request.getParameter("txtRent")); %>" />
					</td>
				</tr>
				
				<tr>
					<th>Image Path:</th>
					<td>
						<input type="text" name="txtImgPath" value="<% if (request.getParameter("txtImgPath") != null) out.println(request.getParameter("txtImgPath")); %>" />
					</td>
				</tr>
				
				<tr>
					<th>Status</th>
					<td>
						<input type="radio" name="rdbStatus" value="Available" <% if (request.getParameter("rdbStatus") == "Available") out.println(" checked"); %>/>Available&emsp;&emsp;
						<input type="radio" name="rdbStatus" value="Rented" <% if (request.getParameter("rdbStatus") == "Rented") out.println(" checked"); %>/>Rented
					</td>
				</tr>
				
				<tr>
					<td align="center"><input type="submit"></td>
					<td align="center"><input type="reset"></td>
				</tr>
			</table>
		</form>
	</body>
</html>
