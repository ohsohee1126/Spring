package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;

@RestController
@RequestMapping("/crawl")
public class CrawlController {
	
	@RequestMapping("/shop.json")
	public List<Map<String,Object>> shop(String query){
		List<Map<String,Object>> array= new ArrayList<>();
		try {
			ChromeOptions options=new ChromeOptions();
			//options.addArguments("headless");
			
			System.setProperty("webdriver.chrome.driver", "c:/data/chromedriver.exe");
			WebDriver driver=new ChromeDriver(options);
			
			driver.get("https://shoppinghow.kakao.com/search/" + query);
			Thread.sleep(1000);
			
			JavascriptExecutor js=(JavascriptExecutor)driver;
			js.executeScript("window.scrollTo(0, document.body.scrollHeight)");
			Thread.sleep(1000);
			List<WebElement> es=driver.findElements(By.cssSelector(".wrap_prod_list .wrap_prod"));
			
			for(WebElement e:es){
				Map<String,Object> map=new HashMap<>();
				WebElement title=e.findElement(By.className("link_g"));
				WebElement image=e.findElement(By.className("thumb_img"));
				WebElement price=e.findElement(By.cssSelector(".wrap_price .lowest"));
				map.put("image", image.getAttribute("src"));
				map.put("title", title.getText());
				map.put("price", price.getText());
				array.add(map);
			}
			driver.close();
			
		}catch(Exception e){
			System.out.println("shop 오류:" + e.toString());
		}
		return array;
	}
	
	
	@RequestMapping("/cgv.json")
	public Map<String, Object> cgv(Criteria cri){
		Map<String, Object> hmap=new HashMap<>();
		List<Map<String, Object>> array=new ArrayList<>();
		
		try{
			ChromeOptions options=new ChromeOptions();
			options.addArguments("headless");
			
			System.setProperty("webdriver.chrome.driver", "c:/data/chromedriver.exe");
			WebDriver driver=new ChromeDriver(options);
			
			driver.get("http://www.cgv.co.kr/movies/?lt=1&ft=0");
			WebElement content=driver.findElement(By.id("contents"));
			WebElement more=content.findElement(By.className("link-more"));
			more.click();
			Thread.sleep(1000);
			
			List<WebElement> es=driver.findElements(By.cssSelector(".sect-movie-chart ol li"));
			int i=1;
			for(WebElement e:es){
				Map<String,Object> map=new HashMap<>();
				
				String title=e.findElement(By.className("title")).getText();
				String image=e.findElement(By.tagName("img")).getAttribute("src");
				String link=e.findElement(By.cssSelector(".box-contents a")).getAttribute("href");
				String percent=e.findElement(By.className("percent")).getText();
				String date=e.findElement(By.cssSelector(".txt-info strong")).getText();
				map.put("no", i);
				map.put("title", title);
				map.put("image", image);
				map.put("link", link);
				map.put("percent", percent);
				map.put("date", date.substring(0,11));
				
				array.add(map);
				i++;
			}
			
			cri.setPerPageNum(5);
			
			PageMaker pm=new PageMaker();
			pm.setCri(cri);
			pm.setTotalCount(array.size());
			
			hmap.put("array", array);
			hmap.put("pm", pm);
			
			driver.quit();
		}catch(Exception e){
			System.out.println("cgv 오류:" + e.toString());
		}
		return hmap;
	}
}
