package com.example.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAOImpl implements ChartDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.ChartMapper";
	
	@Override
	public List<Map<String, Object>> message() {
		return session.selectList(namespace + ".message");
	}
}
