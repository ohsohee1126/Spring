package com.example.dao;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.ProductVO;

public interface ProductDAO {
	public void insert(ProductVO vo);
	public ProductVO chekId(String pid);
	public List<ProductVO> list(Criteria cri);
	public int count();
}
