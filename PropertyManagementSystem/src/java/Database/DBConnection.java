package Database;

import java.sql.Connection;
import java.sql.DriverManager;

public final class DBConnection {

	private static Connection conn = null;

	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/PropertyManagementSystem", "root", "");
			System.out.println(conn);
		} catch (Exception e) {
			System.out.println(e);
		}
		return conn;
	}
}
