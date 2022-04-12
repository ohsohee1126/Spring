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
	
	//���������
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
	
	//�Խñ��Է�ȭ��
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "board/insert.jsp");
		return "/home";
	}
	
	//�Խñ��Է�
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertPost(BoardVO vo){
		dao.insert(vo);
		return "redirect:/board/list";
	}
	
	//�Խñ��б�ȭ��
	@RequestMapping("/read")
	public String read(int bno, Model model, int page){
		model.addAttribute("page", page);
		model.addAttribute("vo", dao.read(bno));
		model.addAttribute("pageName", "board/read.jsp");
		return "home";
	}
	
	//�Խñۼ���
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(BoardVO vo, Criteria cri, RedirectAttributes rttr){
		rttr.addAttribute("page", cri.getPage());
		dao.update(vo);
		return "redirect:/board/list";
	}
	
	//�Խñۻ���
	@RequestMapping(value="delete",method=RequestMethod.POST)
	public String delete(int bno, Criteria cri, RedirectAttributes rttr){
		rttr.addAttribute("page", cri.getPage());
		dao.delete(bno);
		return "redirect:/board/list";
	}
}
