package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.UserDAO;
import com.example.domain.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserDAO dao;
	
	//����� ����Ʈ �б�
	@RequestMapping("/getPoint")
	@ResponseBody
	public int getPoint(String uid){
		UserVO vo=dao.read(uid);
		return vo.getPoint();
	}
	
	//����� ���
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("list", dao.list());
		model.addAttribute("pageName", "user/list.jsp");
		return "/home";
	}
	
	//�����޽�����
	@RequestMapping("/send")
	public String send(Model model, String uid){
		model.addAttribute("list", dao.list());
		model.addAttribute("vo", dao.read(uid));
		model.addAttribute("pageName", "user/send.jsp");
		return "/home";
	}
	
	//�����޽�����
	@RequestMapping("/receive")
	public String receive(Model model, String uid){
		model.addAttribute("vo", dao.read(uid));
		model.addAttribute("pageName", "user/receive.jsp");
		return "/home";
	}
}
