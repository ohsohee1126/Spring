package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/local")
public class Localcontroller {
	
	@RequestMapping("/list")
	public String local(Model model){
		model.addAttribute("pageName", "local/list.jsp");
		return "/home";
	}
}
