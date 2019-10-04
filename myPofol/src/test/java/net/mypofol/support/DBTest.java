package net.mypofol.support;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import lombok.extern.log4j.Log4j;

@Log4j
public class DBTest {

	public void dbTest() {
		try {
			Class.forName("oracle:jdbc:driver:OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "test", "test00");
			log.info(conn);
		} catch(Exception e) {
			fail(e.getMessage());
		}
		
	}
	
}
