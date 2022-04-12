package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.dao.BoardDAO;
import com.example.dao.MysqlDAO;
import com.example.domain.BoardVO;

//SpringJUnit4ClassRunner.class를 먼저 import한다.
@RunWith(SpringJUnit4ClassRunner.class)  
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BoardTest {
    @Autowired
    private BoardDAO dao;
    
    @Test
    public void list(){
    	//dao.list();
    }
    
    @Test
    public void insert(){
    	BoardVO vo=new BoardVO();
    	vo.setTitle("새로운 데이터 제목");
    	vo.setContent("새로운 데이터 내용");
    	vo.setWriter("blue");
    	dao.insert(vo);
    }
    
    @Test
    public void update(){
    	BoardVO vo=new BoardVO();
    	vo.setTitle("데이터 제목 수정");
    	vo.setContent("데이터 수정");
    	vo.setBno(6);
    	dao.update(vo);
    }
    
    @Test
    public void read(){
    	dao.read(6);
    }
   
    @Test
    public void delete(){
    	dao.delete(6);
    }
}
