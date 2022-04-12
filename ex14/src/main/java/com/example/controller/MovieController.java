package com.example.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dao.MovieDAO;
import com.example.domain.Criteria;
import com.example.domain.MovieVO;
import com.example.domain.PageMaker;

@Controller
@RequestMapping("/movie")
public class MovieController {
	@Autowired
	MovieDAO dao;
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "movie/insert.jsp");
		return "/home";
	}
	
	@RequestMapping("/list.json")
	@ResponseBody
	public Map<String,Object> listJSON(Criteria cri){
		Map<String,Object> map=new HashMap<>();
		cri.setPerPageNum(4);
		
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setDisplayPageNum(3);
		pm.setTotalCount(dao.total());
		
		map.put("pm", pm);
		map.put("list", dao.list(cri));
		return map;
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public void insert(MovieVO vo)throws Exception{
		MovieVO checkvo=dao.check(vo.getLink());
		
		if(checkvo == null){
			//이미지 다운로드
			URL url=new URL(vo.getImage());
			
			String image=vo.getImage().substring(vo.getImage().lastIndexOf("/")+1);
			InputStream in=url.openStream();
			OutputStream out=new FileOutputStream(path + "movie/" + image);
			FileCopyUtils.copy(in, out);
			vo.setImage("movie/" + image);
			
			dao.insert(vo);
		}
	}
}
