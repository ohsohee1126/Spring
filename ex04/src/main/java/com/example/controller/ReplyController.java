package com.example.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.dao.ReplyDAO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	ReplyDAO dao;
	
	@RequestMapping("/list.json")
	public HashMap<String, Object> listJSON(Criteria cri, int bno){
		HashMap<String, Object> map=new HashMap<String, Object>();
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










