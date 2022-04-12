package com.example.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.MessageDAO;
import com.example.dao.UserDAO;
import com.example.domain.UserVO;

@Service
public class MwssageServiceImpl  implements MessageService{
	@Autowired
	UserDAO udao;
	
	@Autowired
	MessageDAO mdao;

	@Transactional
	@Override
	public int sendMessage(String sender, String receiver, String message) {
		mdao.sendMessage(sender, receiver, message);
		udao.pointUpdate(sender,10);
		UserVO vo=udao.read(sender);
		return vo.getPoint();
	}


	@Transactional
	@Override
	public HashMap<String, Object> read(int mno) {
		HashMap<String,Object> map=new HashMap<>();
		HashMap<String,Object> vo=mdao.read(mno);
		
		
		mdao.updateReadDate(mno);
		udao.pointUpdate(vo.get("receiver").toString(), 5);
		UserVO user=udao.read(vo.get("receiver").toString());
		
		map.put("vo", mdao.read(mno));
		map.put("point", user.getPoint());
		return map;
		}
	}

