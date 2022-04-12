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
		vo.setType("���");
		tdao.insert(vo); //�ŷ� ���
		adao.updateBalance(ano, vo.getAmount() * -1);
		
		vo.setAno(tno);
		vo.setTno(ano);
		vo.setType("�Ա�");
		tdao.insert(vo); //�ŷ��Ա�
		adao.updateBalance(tno, vo.getAmount());
	}
}
