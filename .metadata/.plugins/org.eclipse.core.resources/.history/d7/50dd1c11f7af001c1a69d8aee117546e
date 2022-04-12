package com.example.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.dao.ProductDAO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Resource(name = "uploadPath")
	String path;
	
	@Autowired
	ProductDAO dao;
	
	
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updatePost(ProductVO vo, MultipartHttpServletRequest multi, int page) throws Exception{
		MultipartFile file=multi.getFile("file");
		//파일업로드
		if(!file.isEmpty()) {
			new File(path + vo.getImage()).delete(); //기존이미지 삭제
			String image="product/" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
			file.transferTo(new File(path + image));
			vo.setImage(image);
		}
		
		//데이터수정
		dao.update(vo);
		return "redirect:/product/list?page=" + page;
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertPost(ProductVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file=multi.getFile("file");
		
		//파일업로드
		String image="product/" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
		file.transferTo(new File(path + image));
		vo.setImage(image);
		
		//데이터저장
		dao.insert(vo);
		return "redirect:/product/list";
	}
	
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "product/insert.jsp");
		return "/home";
	}
	
	@RequestMapping("/update")
	public String update(Model model, int code){
		model.addAttribute("vo", dao.read(code));
		model.addAttribute("pageName", "product/update.jsp");
		return "/home";
	}
	
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("pageName", "product/list.jsp");
		return "/home";
	}
	
	@RequestMapping("/read")
	public String read(Model model, int code){
		model.addAttribute("vo", dao.read(code));
		model.addAttribute("pageName", "product/read.jsp");
		return "/home";
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(int code, String check){
		ProductVO vo=new ProductVO();
		vo.setCode(code);
		if(check.equals("입고")){
			vo.setIsDelete(0);
		}else{
			vo.setIsDelete(1);
		}
		dao.delete(vo);
	}
	
	@RequestMapping("/list.json")
	@ResponseBody
	public HashMap<String, Object> listJSON(Criteria cri){
		HashMap<String, Object> map=new HashMap<>();
		cri.setPerPageNum(4);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.count());
		
		map.put("pm", pm);
		map.put("list", dao.list(cri));
		return map;
	}
}
