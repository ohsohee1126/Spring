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
	
	//게시글 상세정보 페이지
	@RequestMapping("/read")
	public String read(int bno, Model model){
		model.addAttribute("pageName", "board/read.jsp");
		model.addAttribute("vo", dao.read(bno));
		return "/home";
	}
	
	//게시글 목록 페이지
	@RequestMapping("/list")
	public String list(Model model){;
		model.addAttribute("pageName", "board/list.jsp"); 
		return "/home";
	}
	
	//게시글 목록 JSON 데이터생성
	@RequestMapping("/list.json")
	@ResponseBody
	public HashMap<String,Object> listJSON(Criteria cri){
		HashMap<String,Object> map=new HashMap<String,Object>();
		cri.setPerPageNum(5);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setDisplayPageNum(5);
		pm.setTotalCount(dao.count(cri));
		
		map.put("pm", pm); //페이지정보
		map.put("list", dao.list(cri)); //목록 데이터
		return map;
	}
}
