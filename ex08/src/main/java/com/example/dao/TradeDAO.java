package com.example.dao;

import java.util.List;

import com.example.domain.TradeVO;

public interface TradeDAO {
	//거래내역
	public List<TradeVO> list(String ano);
	
	//거래내역입력
	public void insert(TradeVO vo);
}
