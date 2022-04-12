package com.example.controller;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.dao.UserDAO;
import com.example.domain.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserDAO dao;
	
	@Autowired
	BCryptPasswordEncoder passEncoder; //비밀번호 암호화
	
	@Resource(name="uploadPath")
	String path;
	
	@RequestMapping("/login")
	public String login(Model model){
		model.addAttribute("pageName", "user/login.jsp");
		return "/home";
	}
	
	@RequestMapping("/insert")
	public String insert(Model model){
		model.addAttribute("pageName", "user/insert.jsp");
		return "/home";
	}
	
	@RequestMapping("/update")
	public String update(Model model, String uid){
		model.addAttribute("vo", dao.read(uid));
		model.addAttribute("pageName", "user/update.jsp");
		return "/home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updatePost(UserVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file=multi.getFile("file");
		
		String password=passEncoder.encode(vo.getUpass());
		vo.setUpass(password);
		
		if(!file.isEmpty()){
			new File(path + vo.getImage()).delete(); //예전이미지 삭제
			String image = "photo/"+System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + image));
			vo.setImage(image);
		}
		
		dao.update(vo);
		return "redirect:/user/list";
	}
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insertPost(UserVO vo, MultipartHttpServletRequest multi)throws Exception{
		MultipartFile file=multi.getFile("file");
		
		String password=passEncoder.encode(vo.getUpass());
		vo.setUpass(password);
		
		if(!file.isEmpty()){
			String image = "photo/"+System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + image));
			vo.setImage(image);
			dao.insert(vo);
		}
		
		return "redirect:/user/login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public int loginPost(String uid, String upass, HttpSession session){
		int result=0; //아이디가 없는경우
		
		UserVO vo=dao.read(uid);
		if(vo != null){
			if(passEncoder.matches(upass, vo.getUpass())){
				result=1; //로그인성공
				session.setAttribute("uid", uid);
				session.setAttribute("image", vo.getImage());
			}else{
				result=2; //비밀번호 불일치
			}
		}
		return result;
	}
	
	@RequestMapping("/list")
	public String list(Model model){
		model.addAttribute("list", dao.list());
		model.addAttribute("pageName", "user/list.jsp");
		return "/home";
	}
}
