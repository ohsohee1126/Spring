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
	public List<ReplyVO> list(Criteria cri, int bno) {
		HashMap<String,Object> map= new HashMap<>();
		map.put("cri", cri);
		map.put("bno", bno);
		return session.selectList(namespace + ".list", map);
	}

	@Override
	public int count(int bno) {
		return session.selectOne(namespace + ".count", bno);
	}
}
