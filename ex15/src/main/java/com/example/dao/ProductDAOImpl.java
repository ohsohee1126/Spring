package com.example.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.ProductMapper";
	
	@Override
	public List<Map<String, Object>> best() {
		return session.selectList(namespace + ".best");
	}

}
