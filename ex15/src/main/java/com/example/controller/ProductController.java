package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.dao.ProductDAO;

@RestController
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductDAO dao;
	
	@RequestMapping("/best.json")
	public List<Map<String, Object>> best(){
		return dao.best();
	}
}
