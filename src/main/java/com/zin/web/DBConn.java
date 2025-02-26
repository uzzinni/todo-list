package com.zin.web;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
	static final String url = "jdbc:mariadb://localhost:3300/j25a01";
	static final String id = "j25a01";
	static final String pw = "j25a01";

	static DBConn dbConn = new DBConn();

	private DBConn() {
	}

	public static DBConn getInstance() {
		// System.out.println("DBConn 인스턴스 호출");
		if (dbConn == null) {
			dbConn = new DBConn();
		}
		// System.out.println("객체 전달 : " + dbConn);
		return dbConn;
	}

	public Connection getConn() {
		Connection conn = null;

		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}