package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.dao.BoardDAO;
import com.example.dao.MysqlDAO;
import com.example.domain.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)  //SpringJUnit4ClassRunner.class를 먼저 import한다.
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BoardTest {
    @Autowired
    private BoardDAO dao;
    
    @Test
    public void list(){
    	Criteria cri=new Criteria();
    	cri.setPage(2);
    	cri.setPerPageNum(2);
    	cri.setKeyword("red");
    	dao.list(cri);
    	dao.count(cri);
    }
    
    @Test
    public void read(){
    	dao.read(213);
    }
}
