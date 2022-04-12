package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.ProductDAO;
import com.example.domain.ProductVO;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductDAO dao;
	
	@Transactional
	@Override
	public void insert(ProductVO vo) {
		ProductVO checkVO=dao.chekId(vo.getPid());
		if(checkVO == null) dao.insert(vo);
	}
}
