package com.example.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.ReplyMapper";
	
	@Override
	public List<ReplyVO> list(int bno, Criteria cri) {
		HashMap<String, Object> map=new HashMap<>();
		map.put("bno", bno);
		map.put("cri", cri);
		return session.selectList(namespace + ".list", map);
	}

	@Override
	public int count(int bno) {
		return session.selectOne(namespace + ".count", bno);
	}

	@Override
	public void insert(ReplyVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void update(ReplyVO vo) {
		session.update(namespace + ".update", vo);
		
	}

	@Override
	public void delete(int rno) {
		session.delete(namespace + ".delete", rno);
	}
}
