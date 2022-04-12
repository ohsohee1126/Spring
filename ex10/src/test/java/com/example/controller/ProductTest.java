package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.dao.MysqlDAO;
import com.example.dao.ProductDAO;
import com.example.domain.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)  //SpringJUnit4ClassRunner.class를 먼저 import한다.
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ProductTest {
    @Autowired
    private ProductDAO dao;
    
    @Test
    public void list(){
    	Criteria cri=new Criteria();
    	cri.setPerPageNum(4);
    	cri.setKeyword("1인분");
    	dao.list(cri);
    }
}
