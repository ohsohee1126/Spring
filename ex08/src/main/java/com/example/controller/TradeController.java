package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.dao.TradeDAO;
import com.example.domain.TradeVO;
import com.example.service.TradeService;

@RestController
@RequestMapping("/trade")
public class TradeController {
	@Autowired
	TradeDAO dao;
	
	@Autowired
	TradeService service;
	
	@RequestMapping("/list")
	public List<TradeVO> list(String ano){
		return dao.list(ano);
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public void insert(TradeVO vo){
		service.insert(vo);
	}
}
