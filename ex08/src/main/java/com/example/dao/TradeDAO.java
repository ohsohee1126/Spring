package com.example.dao;

import java.util.List;

import com.example.domain.TradeVO;

public interface TradeDAO {
	//�ŷ�����
	public List<TradeVO> list(String ano);
	
	//�ŷ������Է�
	public void insert(TradeVO vo);
}
