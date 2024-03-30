<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Owner Login</title>
    </head>
    <body>
		<h1 align="center">Home Masters</h1>
		<hr>
		<h2 align="center">Owner Login</h2>
		<%			
            if (request.getAttribute("errors") != null) {
                List<String> errors = (List<String>) request.getAttribute("errors");
        %>
		<h3>Error Messages</h3>
        <% 
                for (String error : errors) {
                    out.println(error + "<br>");
                }
            }
        %>
		<form action="validateLogin.jsp" method="POST">
			<table align="center" cellpadding="10">
				<tr>
					<th>Phone Number</th>
					<td>
						<input type="text" name="txtPhoneNo" maxlength="10" value="<% if (request.getParameter("txtPhoneNo") != null) out.println(request.getParameter("txtPhoneNo")); %>" />
					</td>
				</tr>
				
				<tr>
					<th>Password</th>
					<td>
						<input type="password" name="txtPassword" value="<% if (request.getParameter("txtPassword") != null) out.println(request.getParameter("txtPassword")); %>" />
					</td>
				</tr>
				
				<tr>
					<td align="center"><input type="submit"></td>
				</tr>
			</table>
		</form>
	<center>Don't have an account? <a href="./Registration.jsp">Register</center>
	</body>
</html>
