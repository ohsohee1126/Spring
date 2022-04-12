package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.dao.BoardDAO;
import com.example.dao.MysqlDAO;
import com.example.domain.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)  //SpringJUnit4ClassRunner.class�� ���� import�Ѵ�.
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
    	vo.setTitle("���ο�� ����");
    	vo.setContent("���ο�� ����");
    	vo.setWriter("red");
    	dao.insert(vo);	
    }
    
    @Test
    public void read(){
    	dao.read(253);
    }
    
    @Test
    public void update(){
    	BoardVO vo=new BoardVO();
    	vo.setTitle("���ο�� ���� ����");
    	vo.setContent("���ο�� ���� ����");
    	vo.setBno(253);
    	dao.update(vo);
    }
    
    @Test
    public void delete(){
    	dao.delete(253);
    }
}
