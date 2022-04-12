package com.example.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAOImpl implements MessageDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.MessageMapper";
	
	@Override
	public List<HashMap<String, Object>> sendList(String uid) {
		return session.selectList(namespace + ".send", uid);
	}

	@Override
	public void sendMessage(String sender, String receiver, String message) {
		HashMap<String,Object> map=new HashMap<>();
		map.put("sender", sender);
		map.put("receiver", receiver);
		map.put("message", message);
		session.insert(namespace + ".sendMessage", map);
	}

	@Override
	public List<HashMap<String, Object>> receiveList(String uid) {
		return session.selectList(namespace+".receive",uid);
	}

	@Override
	public void updateReadDate(int mno) {
		session.update(namespace+".readdate", mno);
		
	}

	@Override
	public HashMap<String, Object> read(int mno) {
		return session.selectOne(namespace+ ".read",mno);
	}
}
