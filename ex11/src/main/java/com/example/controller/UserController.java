package com.example.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.example.dao.UserDAO;
import com.example.domain.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	UserDAO dao;
	
	@RequestMapping("/login")
	public String login(Model model){
		model.addAttribute("pageName", "user/login.jsp");
		return "/home";
	}
	
	@RequestMapping("/logout")
	public String login(HttpSession session, HttpServletRequest request, 
							HttpServletResponse response){
		session.invalidate();
		
		Cookie cookie=WebUtils.getCookie(request, "uid");
		if(cookie != null){
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public int login(String uid, String upass, HttpSession session, boolean isLogin,
					HttpServletResponse response){
		int result=0; //아이디 없는 경우
		
		UserVO vo=dao.read(uid);
		if(vo != null){
			if(vo.getUpass().equals(upass)){
				result=1; //로그인 성공
				session.setAttribute("uid", uid);
				if(isLogin){ //로그인 상태유지
					Cookie cookie=new Cookie("uid", uid);
					cookie.setPath("/");
					cookie.setMaxAge(60*60*24*7); //일주일
					response.addCookie(cookie);
				}
			}else{
				result=2; //비밀번호가 틀린경우
			}
		}
		return result;
	}
}
