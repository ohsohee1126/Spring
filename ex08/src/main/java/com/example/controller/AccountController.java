package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.AccountDAO;
import com.example.domain.AccountVO;

@Controller
@RequestMapping("/account")
public class AccountController {
	@Autowired
	AccountDAO dao;
	
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("list", dao.list());
		model.addAttribute("pageName", "account/list.jsp");
		return "/home";
	}
	
	@RequestMapping("/read")
	public String read(Model model, String ano){
		model.addAttribute("list", dao.list());
		model.addAttribute("vo", dao.read(ano));
		model.addAttribute("pageName", "account/read.jsp");
		return "/home";
	}
	
	@RequestMapping("/getBalance")
	@ResponseBody
	public double getBalance(String ano){
		AccountVO vo=dao.read(ano);
		return vo.getBalance();
	}
}
