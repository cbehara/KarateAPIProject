package com.ddaqe.utils;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;
import org.springframework.data.mongodb.core.query.BasicQuery;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

public class MongoDBConnector {

	private static final Logger logger = LoggerFactory.getLogger(MongoDBConnector.class);

	private MongoOperations mongoOps;

	public MongoDBConnector(String server, String database) {
		MongoClientURI uri = new MongoClientURI(server);
		 mongoOps = new MongoTemplate(new SimpleMongoDbFactory(new MongoClient(uri), database));
		logger.info("Initialized mongo template: {}", server);
	}

	/**
	 * Finds the document count based on a query
	 * @param queryString The query in plain JSON string format
	 * @param collection The collection to access
	 * @return The count returned
	 */
	public Object readDocCount(String queryString, String collection) {
		BasicQuery query = new BasicQuery(queryString);	
		return mongoOps.count(query, Object.class, collection);
	}
	
	/**
	 * Finds a document based on a query
	 * @param queryString The query in plain JSON string format
	 * @param collection The collection to access
	 * @return The document found
	 */
	public Object readDoc(String queryString, String collection) {
		BasicQuery query = new BasicQuery(queryString);	
		return mongoOps.findOne(query, Object.class, collection);
	}

	/**
	 * Finds a list of documents based on a query
	 * @param queryString The query in plain JSON string format
	 * @param collection The collection to access
	 * @return The list of documents found
	 */
	public List<Object> readDocs(String queryString, String collection) {
		BasicQuery query = new BasicQuery(queryString);	
		return mongoOps.find(query, Object.class, collection);
	}

}
