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
        <title>Validate Login</title>
    </head>
    <body>
		<%
			String phoneNo = request.getParameter("txtPhoneNo");
			String pass = request.getParameter("txtPassword");

			List<String> errors = new ArrayList<>();

			// No field left blank validation
			if (phoneNo.isEmpty() || pass.isEmpty()) {
				errors.add("All fields are required.");
			} else {
				if (phoneNo.length() != 10) {
					errors.add("Mobile No. must contain 10 digits.");
				} else if (!phoneNo.matches("[6-9][0-9]{9}")) {
					errors.add("Invalid mobile format.");
				}

				if (pass.length() < 8 && pass.length() > 10) {
					errors.add("Length of Password should be between 8 to 10 characters");
				}
				if (errors.isEmpty()) {
//					out.println("<h2>Registration successful!</h2>");

					Connection conn = DBConnection.getConnection();
					String sql = "SELECT PhoneNumber, Password FROM PropertyOwnerMaster WHERE PhoneNumber = ? AND Password = ?";

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, phoneNo);
					ps.setString(2, pass);

					ResultSet rs = ps.executeQuery();
					int rowCount = 0;
					while (rs.next()) {
						rowCount++;
					}
					if (rowCount == 1) {
						session.setAttribute("sesPhoneNo", phoneNo);
						response.sendRedirect("./Dashboard.jsp");
					} else {
						errors.add("Phone Number or Password is incorrect.");
					}
					rs.close();
					ps.close();
					conn.close();
				}
			}

			if (!errors.isEmpty()) {
				request.setAttribute("errors", errors);
				request.getRequestDispatcher("./Login.jsp").forward(request, response);
			}
		%>
    </body>
</html>
