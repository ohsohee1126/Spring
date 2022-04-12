package com.example.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.AccountVO;

@Repository
public class AccountDAOImpl implements AccountDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.AccountMapper";
	
	@Override
	public List<AccountVO> list() {
		return session.selectList(namespace + ".list");
	}

	@Override
	public AccountVO read(String ano) {
		return session.selectOne(namespace + ".read", ano);
	}

	@Override
	public void updateBalance(String ano, double amount) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("ano", ano);
		map.put("amount", amount);
		System.out.println("ano:" + ano + "\namount:" + amount);
		session.update(namespace + ".updateBalance", map);
	}
}
