package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.MessageDAO;
import com.example.dao.UserDAO;
import com.example.domain.MessageVO;

@Service
public class MessageServiceImpl implements MessageService{
	@Autowired
	UserDAO udao;
	
	@Autowired
	MessageDAO mdao;
	
	@Transactional
	@Override
	public void insert(MessageVO vo) {
		mdao.insert(vo);
		udao.updatePoint(vo.getSender(), 10);
		mdao.updateSendcnt(vo.getSender());
		mdao.updateRececnt(vo.getReceiver());
	}

	@Transactional
	@Override
	public MessageVO read(int mno) {
		MessageVO vo=mdao.read(mno);
		
		if(vo.getReaddate()==null){ //아직 읽지않은경우
			udao.updatePoint(vo.getReceiver(), 5); //받은사람의 포인트를 5점증가
			mdao.updateReaddate(mno); //읽은날짜를 현재날짜로 수정
			vo=mdao.read(mno);
		}
		
		return vo;
	}
}
