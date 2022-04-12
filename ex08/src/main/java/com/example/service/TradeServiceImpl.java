package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.AccountDAO;
import com.example.dao.TradeDAO;
import com.example.domain.TradeVO;

@Service
public class TradeServiceImpl implements TradeService{
	@Autowired
	AccountDAO adao;
	
	@Autowired
	TradeDAO tdao;
	
	@Transactional
	@Override
	public void insert(TradeVO vo) {
		String ano=vo.getAno();
		String tno=vo.getTno();
		vo.setType("출금");
		tdao.insert(vo); //거래 출금
		adao.updateBalance(ano, vo.getAmount() * -1);
		
		vo.setAno(tno);
		vo.setTno(ano);
		vo.setType("입금");
		tdao.insert(vo); //거래입금
		adao.updateBalance(tno, vo.getAmount());
	}
}
