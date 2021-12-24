package org.conan.test;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTest {
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@Test
	public void testConnection() {
		try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/scottdb?userSSL=false", "scott",
				"tiger")) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}
