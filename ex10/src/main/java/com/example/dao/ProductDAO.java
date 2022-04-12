package com.example.dao;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.ProductVO;

public interface ProductDAO {
	public List<ProductVO> list(Criteria cri);
	public int count(Criteria cri);
	public void insert(ProductVO vo);
	public ProductVO read(int code);
	public void update(ProductVO vo);
	public void qntUpdate(int code, int qnt);
}
