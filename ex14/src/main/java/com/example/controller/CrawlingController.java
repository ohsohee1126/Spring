package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/crawl")
public class CrawlingController {
	//주식 Top10 종목
	@RequestMapping("/finance.json")
	public List<Map<String,Object>> finance(){
		List<Map<String,Object>> array=new ArrayList<>();
		try{
			Document doc=Jsoup.connect("https://finance.naver.com/").get();
			Elements es=doc.select("#_topItems1 tr");
			int i=1;
			for(Element e:es){
				Map<String, Object> map=new HashMap<>();
				
				String title=e.select("a").text();
				String price=e.select("td").get(0).text();
				String range=e.select("td").get(1).text();
				String percent=e.select("td").get(2).text();
				
				String color=range.substring(0,2);
				if(color.equals("상승")){
					map.put("color", "red");
				}else {
					map.put("color", "blue");
				}
				
				map.put("title", title);
				map.put("price", price);
				map.put("range", range);
				map.put("percent", percent);
				
				array.add(map);
			}
		}catch(Exception e){
			System.out.println("finace 오류:" + e.toString());
		}
		return array;
	}
	
	//cgv 무비차트
	@RequestMapping("/cgv.json")
	public List<Map<String, Object>> cgv(){
		List<Map<String, Object>> array=new ArrayList<>();
		try {
			Document doc=Jsoup.connect("http://www.cgv.co.kr/movies/?lt=1&ft=0").get();
			Elements es=doc.select(".sect-movie-chart ol li");
			for(Element e:es){
				String image=e.select("img").attr("src");
				String title=e.select(".title").text();
				String date=e.select(".txt-info").text();
				String percent=e.select(".percent").text();
				String link=e.select(".box-image a").attr("href");
				
				HashMap<String,Object> map=new HashMap<>();
				map.put("image", image);
				map.put("title", title);
				map.put("date", date);
				map.put("percent", percent);
				map.put("link", "http://www.cgv.co.kr" + link);
				
				if(!title.equals(""))
					array.add(map);
			}
		}catch(Exception e){
			System.out.println("cgv 오류:" + e.toString());
		}
		
		return array;
	}
}
