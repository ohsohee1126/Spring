package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.dao.ReplyDAO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.ReplyVO;
import com.example.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	@Autowired 
	ReplyDAO dao;
	
	@Autowired
	ReplyService service;
	
	//����Է�
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public void insert(ReplyVO vo){
		service.insert(vo);
	}
	
	//��ۼ���
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public void update(ReplyVO vo){
		dao.update(vo);
	}
	
	//��ۻ���
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public void delete(int rno){
		service.delete(rno);
	}
	
	//��۸�� JSON������ ���
	@RequestMapping("/list.json")
	public HashMap<String,Object> list(int bno, Criteria cri){
		HashMap<String,Object> map=new HashMap<String,Object>();
		
		cri.setPerPageNum(5);
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setDisplayPageNum(5);
		pm.setTotalCount(dao.count(bno));
		
		map.put("pm", pm);
		map.put("list", dao.list(cri, bno));
		return map;
	}
}
