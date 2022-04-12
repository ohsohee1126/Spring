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
	public List<Map<String, Object>> point() {
		return session.selectList(namespace + ".point");
	}

	@Override
	public List<Map<String, Object>> send() {
		return session.selectList(namespace + ".send");
	}

	@Override
	public List<Map<String, Object>> receive() {
		return session.selectList(namespace + ".receive");
	}

}
