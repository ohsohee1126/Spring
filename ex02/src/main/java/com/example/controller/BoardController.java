package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.dao.BoardDAO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDAO dao;
	
	//목록페이지
	@RequestMapping("/list")
	public String list(Model model, Criteria cri){
		cri.setPerPageNum(5);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setDisplayPageNum(10);
		pm.setTotalCount(dao.totalCount());
		model.addAttribute("pm", pm);
		
		model.addAttribute("list", dao.list(cri));
		model.addAttribute("pageName", "board/list.jsp");
		return "/home";
	}
	
	//게시글입력화면
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "board/insert.jsp");
		return "/home";
	}
	
	//게시글입력
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertPost(BoardVO vo){
		dao.insert(vo);
		return "redirect:/board/list";
	}
	
	//게시글읽기화면
	@RequestMapping("/read")
	public String read(int bno, Model model, int page){
		model.addAttribute("page", page);
		model.addAttribute("vo", dao.read(bno));
		model.addAttribute("pageName", "board/read.jsp");
		return "home";
	}
	
	//게시글수정
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(BoardVO vo, Criteria cri, RedirectAttributes rttr){
		rttr.addAttribute("page", cri.getPage());
		dao.update(vo);
		return "redirect:/board/list";
	}
	
	//게시글삭제
	@RequestMapping(value="delete",method=RequestMethod.POST)
	public String delete(int bno, Criteria cri, RedirectAttributes rttr){
		rttr.addAttribute("page", cri.getPage());
		dao.delete(bno);
		return "redirect:/board/list";
	}
}
