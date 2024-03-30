<%@page import="Database.DBConnection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.CallableStatement"%>
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
			String propName = request.getParameter("txtPropName");
			String add = request.getParameter("txtaAdd");
			String type = request.getParameter("selType");
			String addFeat = request.getParameter("txtaAddFeat");
			String rent = request.getParameter("txtRent");
			String imgPath = request.getParameter("txtImgPath");
			String status = request.getParameter("rdbStatus");

			List<String> errors = new ArrayList<>();
			Connection conn = DBConnection.getConnection();
			
			int id = 0;
		
				String sql = "SELECT OwnerId FROM PropertyOwnerMaster WHERE PhoneNumber = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				String phoneNo = session.getAttribute("sesPhoneNo").toString();
				ps.setString(1, phoneNo);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					id = rs.getInt("OwnerId");
				}

				if (errors.isEmpty()) {
					sql = "{CALL addProperty(?,?,?,?,?,?,?,?)}";
					
					CallableStatement cs = conn.prepareCall(sql);
					cs.setInt(1, id);
					cs.setString(2, propName);
					cs.setString(3, add);
					cs.setString(4, type);
					cs.setString(5, addFeat);
					cs.setDouble(6, Double.parseDouble(rent));
					cs.setString(7, imgPath);
					cs.setString(8, status);
					
					if (cs.execute() == true) {
						response.sendRedirect("./Dashboard.jsp");
					} else {
						errors.add("Can't Add property! Please try again.");
					}

				}
				rs.close();
				ps.close();
				conn.close();

			if (!errors.isEmpty()) {
				request.setAttribute("errors", errors);
				request.getRequestDispatcher("./AddProperty.jsp").forward(request, response);
			}
		%>
    </body>
</html>