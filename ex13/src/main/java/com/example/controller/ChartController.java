package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.ChartDAO;

@Controller
@RequestMapping("/chart")
public class ChartController {
	@Autowired
	ChartDAO dao;
	
	@RequestMapping("/message")
	@ResponseBody
	public List<List<Object>> message(){
		List<List<Object>> array=new ArrayList<>();
		List<Map<String,Object>> list=dao.message(); 
		
		List<Object> arr=new ArrayList<>();
		arr.add("이름");
		arr.add("받은메시지");
		arr.add("보낸메시지");
		array.add(arr);

		for(Map<String,Object> map:list){
			arr=new ArrayList<>();
			arr.add(map.get("uname"));
			arr.add(map.get("sendcnt"));
			arr.add(map.get("rececnt"));
			array.add(arr);
		}
		return array;
	}
}
