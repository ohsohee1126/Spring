package com.example.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.ProductDAO;
import com.example.domain.Criteria;
import com.example.domain.NaverAPI;
import com.example.domain.PageMaker;
import com.example.domain.ProductVO;
import com.example.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductService service;
	
	@Autowired
	ProductDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "product/insert.jsp");
		return "/home";
	}
	
	@RequestMapping("/shop.json")
	@ResponseBody
	public String shop(String query){
		return NaverAPI.connection(query);
	}
	
	@RequestMapping("/list.json")
	@ResponseBody
	public Map<String,Object> list(Criteria cri){
		Map<String,Object> map=new HashMap<>();
		cri.setPerPageNum(4);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.count());
		
		map.put("pm", pm);
		map.put("list", dao.list(cri));
		return map;
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public void insert(ProductVO vo){
		//이미지 내서버로 Copy
		String str=vo.getImage();
		String fileName=str.substring(str.lastIndexOf("/")+1);
		
		try {
			URL url=new URL(str);
			InputStream in=url.openStream();
			OutputStream out=new FileOutputStream(path + "product/" + fileName);
			FileCopyUtils.copy(in, out);
			vo.setImage("product/" + fileName);
			service.insert(vo);
			
		} catch (Exception e) {
			System.out.println("오류:" + e.toString());
		}
	}
}
