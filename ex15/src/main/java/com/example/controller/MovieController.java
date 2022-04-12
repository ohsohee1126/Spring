package com.example.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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
	
	@RequestMapping("list")
	public String list(Model model){
		model.addAttribute("pageName", "movie/list.jsp");
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
	public void insertPost(MovieVO vo)throws Exception{
		MovieVO checkVO=dao.check(vo.getLink());
		if(checkVO == null){
			//이미지 다운로드
			String image=vo.getImage();
			
			URL url=new URL(image);
			InputStream in=url.openStream();
			
			String file="movie/" + image.substring(image.lastIndexOf("/")+1);
			OutputStream out= new FileOutputStream(path + file);
			FileCopyUtils.copy(in, out);
			
			//영화등록
			vo.setImage(file);
			dao.insert(vo);
		}
	}
}
