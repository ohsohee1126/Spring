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

@RestController
@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	ReplyDAO dao;
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public void insert(ReplyVO vo){
		dao.insert(vo);
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public void update(ReplyVO vo){
		dao.update(vo);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public void delete(int rno){
		dao.delete(rno);
	}
	
	@RequestMapping("/list.json")
	public HashMap<String, Object> listJSON(int bno, Criteria cri){
		HashMap<String, Object> map=new HashMap<>();
		cri.setPerPageNum(5);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.count(bno));
		
		map.put("pm", pm);
		map.put("list", dao.list(bno, cri));
		return map;
	}
}
