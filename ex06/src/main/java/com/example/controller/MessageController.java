package com.example.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.dao.MessageDAO;
import com.example.service.MessageService;

@RestController
@RequestMapping("/message")
public class MessageController {
	@Autowired
	MessageDAO dao;
	
	@Autowired
	MessageService service;
	
	@RequestMapping("/read")
	public HashMap<String,Object>read(int mno){
		HashMap<String,Object>vo=service.read(mno);
		return vo;
	}
	
	@RequestMapping("/send")
	public List<HashMap<String,Object>> sendList(String uid){
		return dao.sendList(uid);
	}
	
	@RequestMapping("/receive")
	public List<HashMap<String,Object>> receive(String uid){
		return dao.receiveList(uid);
	}
	
	@RequestMapping(value="/sendMessage", method=RequestMethod.POST)
	public int sendMessage(String sender, String receiver, String message){
		return service.sendMessage(sender, receiver, message);
	}
}
