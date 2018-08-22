package com.ddaqe.utils;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;


public class DBConnector {
	
	private static final Logger logger = LoggerFactory.getLogger(DBConnector.class);
	
	private final JdbcTemplate jdbc;
	
	public DBConnector(Map<String, Object> creds) {
		
		// Get configuration credentials
		String url = (String) creds.get("url");
        String username = (String) creds.get("username");
        String password = (String) creds.get("password");

		// Define datasource
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(oracle.jdbc.driver.OracleDriver.class.getName()); // oracle.jdbc.driver.OracleDriver
		dataSource.setUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		
		// Initialize template
		jdbc = new JdbcTemplate(dataSource);
		logger.info("Initialized jdbc template: {}", url);
		
	}
	
	/**
	 * Finds a value based on a query
	 * @param query The SQL query to run
	 * @return The value returned
	 */
    public Object readValue(String query) {
        return jdbc.queryForObject(query, Object.class);
    }    
    
    /**
     * Finds a data row based on a query
     * @param query The SQL query to run
     * @return The row in key:value pair
     */
    public Map<String, Object> readRow(String query) {
        return jdbc.queryForMap(query);
    }
    
    /**
     * Find multiple data rows based on a query
     * @param query The SQL query to run
     * @return The rows in a list of key:value pairs
     */
    public List<Map<String, Object>> readRows(String query) {
        return jdbc.queryForList(query);
    }   
	
}