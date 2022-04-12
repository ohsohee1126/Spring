package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.BoardDAO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDAO dao;
	
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("pageName", "board/list.jsp");
		return "/home";
	}
	
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "board/insert.jsp");
		return "/home";
	}
	
	@RequestMapping("/read")
	public String read(Model model, int bno){
		model.addAttribute("vo", dao.read(bno));
		model.addAttribute("pageName", "board/read.jsp");
		return "/home";
	}
	
	@RequestMapping("/list.json")
	@ResponseBody
	public HashMap<String, Object> listJSON(Criteria cri){
		HashMap<String, Object> map=new HashMap<String, Object>();
		cri.setPerPageNum(10);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.count(cri));
		
		map.put("list", dao.list(cri));
		map.put("pm", pm);
		return map;
	}
}
