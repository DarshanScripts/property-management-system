<%@page import="java.util.UUID"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
        // create random captcha code
        UUID randomUUID = UUID.randomUUID();
        String captcha = randomUUID.toString().substring(0, 6);
        session.setAttribute("sesCaptcha", captcha);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Owner Registration</title>
    </head>
    <body>
        <h1 align="center">Home Masters</h1>
        <hr>
        <h2 align="center">Owner Registration</h2>
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

        <form action="validateReg.jsp" method="POST">
			<table align="center" cellpadding="10">
				<tr>
					<th>Full Name</th>
					<td>
						<input type="text" name="txtFullName" value="<% if (request.getParameter("txtFullName") != null) out.println(request.getParameter("txtFullName")); %>" />
					</td>
				</tr>

				<tr>
					<th>Date Of Birth</th>
					<td>
						<input type="date" name="dtDOB"/>
					</td>
				</tr>
				
				<tr>
					<th>Gender</th>
					<td>
						<input type="radio" name="rdbGender" value="M" <% if (request.getParameter("rdbGender") == "M") out.println(" checked"); %>/>Male&emsp;&emsp;
						<input type="radio" name="rdbGender" value="F" <% if (request.getParameter("rdbGender") == "F") out.println(" checked"); %>/>Female
					</td>
				</tr>
				
				<tr>
					<th>Email</th>
					<td>
						<input type="text" name="txtEmail" value="<% if (request.getParameter("txtEmail") != null) out.println(request.getParameter("txtEmail")); %>" />
					</td>
				</tr>
				
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
					<th>Captcha Code</th>
					<td>
						<center>
							<div class="form-outline mb-3" style="color:white; background-color: gray; font-style: italic; width: 80px;">
								<p><%= captcha%></p>
							</div>
						</center>
						<input type="text" name="txtCaptcha" maxlength="6" />
					</td>
				</tr>
				
				<tr>
					<td align="center"><input type="submit"></td>
					<td align="center"><input type="reset"></td>
				</tr>
			</table>
		</form>
	<center>Already Registered? <a href="./Login.jsp">Login</center>
</body>

</html>
