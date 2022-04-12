package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.dao.AccountDAO;
import com.example.dao.MysqlDAO;

@RunWith(SpringJUnit4ClassRunner.class)  //SpringJUnit4ClassRunner.class를 먼저 import한다.
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class AccountTest {
    @Autowired
    private AccountDAO dao;
    
    @Test
    public void list(){
    	dao.list();
    }
    
    @Test
    public void read(){
    	dao.read("1003");
    }
}
