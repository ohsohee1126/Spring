package com.example.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;

@Repository
public class BoardDAOimpl implements BoardDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.BoardMapper";
	
	@Override
	public List<BoardVO> list(Criteria cri) {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public BoardVO read(int bno) {
		return session.selectOne(namespace + ".read", bno);
	}

	@Override
	public int count(Criteria cri) {
		return session.selectOne(namespace + ".count", cri);
	}

}
