<%@page import="Database.DBConnection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
        <title>Validation</title>
    </head>
    <body>
        <%
			String fullName = request.getParameter("txtFullName");
			String dob = request.getParameter("dtDOB");
			String gender = request.getParameter("rdbGender");
			String email = request.getParameter("txtEmail");
			String phoneNo = request.getParameter("txtPhoneNo");
			String pass = request.getParameter("txtPassword");
			String captcha = request.getParameter("txtCaptcha");

			List<String> errors = new ArrayList<>();
			Connection conn = DBConnection.getConnection();

			// No field left blank validation
			if (fullName.isEmpty() || gender.isEmpty() || email.isEmpty() || phoneNo.isEmpty() || pass.isEmpty() || captcha.isEmpty()) {
				errors.add("All fields must be filled.");
			} else {
				if (phoneNo.length() != 10) {
					errors.add("Mobile No. must contain 10 digits.");
				} else if (!phoneNo.matches("[6-9][0-9]{9}")) {
					errors.add("Invalid mobile format.");
				}

				if (!email.matches("^[a-z][a-z0-9]+@(gmail|outlook|hotmail|yahoo|icloud)[.](com|in)$")) {
					errors.add("Invalid email format.");
				}

				if (pass.length() < 8 || pass.length() > 10) {
					errors.add("Length of Password should be between 8 to 10 characters");
				}
				
				if (!captcha.equals((String) session.getAttribute("sesCaptcha"))) {
					errors.add("Captcha Code is incorrect.");
				}

				// mobile no. exist check
				String sql = "SELECT PhoneNumber FROM PropertyOwnerMaster WHERE PhoneNumber = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, phoneNo);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					errors.add("Mobile Number already exists. Try another.");
				}

				// email exist check
				sql = "SELECT EmailId FROM PropertyOwnerMaster WHERE EmailId = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, email);
				rs = ps.executeQuery();
				if (rs.next()) {
					errors.add("Email already exists. Try another.");
				}

				if (errors.isEmpty()) {
					sql = "INSERT INTO TenantMaster (FullName, DOB, Gender, EmailId, PhoneNumber, Password) VALUES(?,?,?,?,?,?)";

					ps = conn.prepareStatement(sql);
					ps.setString(1, fullName);
					ps.setString(2, dob);
					ps.setString(3, gender);
					ps.setString(4, email);
					ps.setString(5, phoneNo);
					ps.setString(6, pass);

					if (ps.executeUpdate() == 1) {
						request.getRequestDispatcher("./Login.jsp").forward(request, response);
					} else {
						errors.add("Can't register! Please try again.");
					}

				}
				rs.close();
				ps.close();
				conn.close();
			}

			if (!errors.isEmpty()) {
				request.setAttribute("errors", errors);
				request.getRequestDispatcher("./Registration.jsp").forward(request, response);
			}
		%>
    </body>
</html>
