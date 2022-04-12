package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dao.UserDAO;

@Controller
@RequestMapping("/user")
public class UserConttroller {
	@Autowired
	UserDAO dao;
	
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("pageName", "user/list.jsp");
		model.addAttribute("list", dao.list());
		return "/home";
	}
	//보낸메시지
	@RequestMapping("/read")
	public String read(Model model, String uid){
		model.addAttribute("pageName", "user/read.jsp");
		model.addAttribute("vo", dao.read(uid));
		model.addAttribute("list", dao.list());
		return "/home";
	}
	
	//받은 메시지
	@RequestMapping("/receive")
	public String receive(Model model, String uid){
		model.addAttribute("pageName", "user/receive.jsp");
		model.addAttribute("vo",dao.read(uid));
		return "/home";
	}
	
}
