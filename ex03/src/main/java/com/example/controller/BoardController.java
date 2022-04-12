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
	public String list(Model model, Criteria cri){
		cri.setPerPageNum(5);
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setDisplayPageNum(5);
		pm.setTotalCount(dao.total(cri));
	
		model.addAttribute("pm", pm);
		model.addAttribute("page", cri.getPage());
		model.addAttribute("keyword", cri.getKeyword());
		
		model.addAttribute("list", dao.list(cri));
		model.addAttribute("pageName", "board/list.jsp");
		return "/home";
	}
	
	@ResponseBody
	@RequestMapping("/list.json") //JSON 데이터생성
	public HashMap<String, Object> jsonList(Criteria cri){
		HashMap<String, Object> map=new HashMap<String, Object>();
		cri.setPerPageNum(5);
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setDisplayPageNum(5);
		pm.setTotalCount(dao.total(cri));
		
		map.put("list", dao.list(cri));
		map.put("pm", pm);
		return map;
	}
	
	@RequestMapping("/ajax") //목록 출력페이지
	public String ajax(Model model, Criteria cri){
		model.addAttribute("pageName" ,"board/ajax.jsp");
		model.addAttribute("cri", cri);
		return "/home";
	}
	
	//게시글 읽기
	@RequestMapping("/read")
	public String read(int bno, Model model, Criteria cri){
		model.addAttribute("cri", cri);
		model.addAttribute("pageName", "board/read.jsp");
		model.addAttribute("vo", dao.read(bno));
		return "/home";
	}
}
