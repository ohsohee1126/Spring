package com.example.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.ProductMapper";
	
	@Override
	public List<ProductVO> list(Criteria cri) {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public int count() {
		return session.selectOne(namespace + ".count");
	}

	@Override
	public void insert(ProductVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public ProductVO read(int code) {
		return session.selectOne(namespace + ".read", code);
	}

	@Override
	public void update(ProductVO vo) {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(ProductVO vo) {
		session.update(namespace + ".delete", vo);
	}
}
