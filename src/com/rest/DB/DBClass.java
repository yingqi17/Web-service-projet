package com.rest.DB;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBClass {
	private static DataSource mySQLDataSource = null; //hold the database object
	private static Context context = null; //used to lookup the database connection in weblogic
	/**
	 * This is a public method that will return the  database connection.
	 *
	 *
	 *
	 * @return Database object
	 * @throws Exception
	 */
	private static DataSource getMySQLConnection() throws Exception {
		/**
		 * check to see if the database object is already defined...
		 * if it is, then return the connection, no need to look it up again.
		 */
		if (mySQLDataSource != null) {
			return mySQLDataSource;
		}
		try {
			/**
			 * This only needs to run one time to get the database object.
			 * context is used to lookup the database object in JNDI
			 * 
			 */
			if (context == null) {
				context = new InitialContext();
			}
			/**
			 * ATTENTION: HERE PUT THE JNDI NAME 
			 * */

			mySQLDataSource = (DataSource) context.lookup("jdbc/MySQLDataSource");//JNDI NAME HERE
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return mySQLDataSource;
	}
	/**
	 * This method will return the connection to the DB
	 * @return Connection to MySQL database.
	 */
	public static Connection returnConnection() {
		Connection conn = null;
		try {
			conn = getMySQLConnection().getConnection();
			return conn;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

}
