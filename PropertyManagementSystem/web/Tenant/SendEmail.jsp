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
        <title>Email</title>
    </head>
    <body>
		<%
			
			Connection conn = DBConnection.getConnection();

			String email= "", ownerEmail= "";
			int propId = Integer.parseInt(request.getParameter("propId"));
		
			String sql = "SELECT EmailId FROM TenantMaster WHERE PhoneNumber = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			String phoneNo = session.getAttribute("sesPhoneNo").toString();
			ps.setString(1, phoneNo);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				email = rs.getString("EmailId");
			}
			
			sql = "SELECT EmailId FROM PropertyOwnerMaster PO, PropertyMaster PM WHERE PO.OwnerId = PM.OwnerId AND PropertyId = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, propId);
			rs = ps.executeQuery();
			if (rs.next()) {
				ownerEmail = rs.getString("EmailId");
			}
//			
//	
//			String res;
//			String to = ownerEmail;
//			String from = email;
//			String host = "192.168.40.8";
//
//			Properties prop = System.getProperties();
//			prop.setProperty("mail.smtp.host", host);
//
//			Session mSess = Session.getDefaultInstance(prop);
//
//			try {
//			   MimeMessage msg = new MimeMessage(mSess);
//			   
//			   msg.setFrom(new InternetAddress(from));
//			   msg.addRecipient(new InternetAddress(to));
//			   msg.setSubject("Property Request");
//			   msg.setText("I want this property");
//
//			   Transport.send(msg);
//			   res = "Sent msg successfully";
//			} catch (Exception e) {
//			   e.printStackTrace();
//			   res = "Error: Message not sent";
//			}
			
			
			int tId = 0;
			
			sql = "SELECT TenantId FROM TenantMaster WHERE PhoneNumber = ?";
			ps = conn.prepareStatement(sql);
			phoneNo = session.getAttribute("sesPhoneNo").toString();
			ps.setString(1, phoneNo);
			rs = ps.executeQuery();
			if (rs.next()) {
				tId = rs.getInt("TenantId");
			}
			
			
			
			sql = "INSERT INTO LeaseDetail (PropertyId, TenantId, StartDate, EndDate, RentAmount, LeaseStatus) VALUES (?,?,?,?,?,?)";

			ps = conn.prepareStatement(sql);

			ps = conn.prepareStatement(sql);
			ps.setInt(1, propId);
			ps.setInt(2, tId);
			ps.setString(3, "2023-04-05");
			ps.setString(4, "2023-10-05");
			ps.setDouble(5, 1200.00);
			ps.setString(6, "Inactive");

			if (ps.executeUpdate() == 1) {
				request.getRequestDispatcher("./Dashboard.jsp").forward(request, response);
			}


//			response.sendRedirect("./Dashboard.jsp");
			
			
		%>
    </body>
</html>
