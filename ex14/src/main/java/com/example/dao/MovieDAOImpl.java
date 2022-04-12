package com.example.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.MovieVO;

@Repository
public class MovieDAOImpl implements MovieDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.MovieMapper";
	
	@Override
	public List<MovieVO> list(Criteria cri) {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public MovieVO check(String link) {
		return session.selectOne(namespace + ".check", link);
	}

	@Override
	public int total() {
		return session.selectOne(namespace + ".total");
	}

	@Override
	public void insert(MovieVO vo) {
		session.insert(namespace + ".insert", vo);
	}
}
