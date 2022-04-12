package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.ChartDAO;

@Controller
@RequestMapping("/chart")
public class ChartController {
	@Autowired
	ChartDAO dao;
	
	@RequestMapping("/user")
	public String user(Model model){
		model.addAttribute("pageName", "chart/user.jsp");
		return "/home";
	}
	
	@RequestMapping("/point.json")
	@ResponseBody
	public List<List<Object>> point(){
		List<List<Object>> array=new ArrayList<>();
		List<Map<String,Object>> list=dao.point();
		
		List<Object> arr=new ArrayList<>();
		arr.add("이름");
		arr.add("점수");
		array.add(arr);
		
		for(Map<String,Object> map:list){
			arr=new ArrayList<>();
			arr.add(map.get("uname"));
			arr.add(map.get("point"));
			array.add(arr);
		}
		return array;
	}
	
	@RequestMapping("/send.json")
	@ResponseBody
	public List<List<Object>> send(){
		List<List<Object>> array=new ArrayList<>();
		List<Map<String,Object>> list=dao.send();
		
		List<Object> arr=new ArrayList<>();
		arr.add("이름");
		arr.add("보낸메지지");
		array.add(arr);
		
		for(Map<String,Object> map:list){
			arr=new ArrayList<>();
			arr.add(map.get("uname"));
			arr.add(map.get("sendcnt"));
			array.add(arr);
		}
		return array;
	}
	
	@RequestMapping("/receive.json")
	@ResponseBody
	public List<List<Object>> receive(){
		List<List<Object>> array=new ArrayList<>();
		List<Map<String,Object>> list=dao.receive();
		
		List<Object> arr=new ArrayList<>();
		arr.add("이름");
		arr.add("받은메지지");
		array.add(arr);
		
		for(Map<String,Object> map:list){
			arr=new ArrayList<>();
			arr.add(map.get("uname"));
			arr.add(map.get("rececnt"));
			array.add(arr);
		}
		return array;
	}
}
