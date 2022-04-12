package com.example.controller;


import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;


@Controller
public class HomeController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
		Cookie cookie = WebUtils.getCookie(request, "uid");
		if(cookie != null) {
			request.getSession().setAttribute("uid", cookie.getValue());
		}
		model.addAttribute("pageName", "about.jsp");
		return "home";
	}
	
}
