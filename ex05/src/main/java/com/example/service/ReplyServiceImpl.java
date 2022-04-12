package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.BoardDAO;
import com.example.dao.ReplyDAO;
import com.example.domain.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	BoardDAO bdao;
	
	@Autowired
	ReplyDAO rdao;
	
	@Transactional
	@Override
	public void insert(ReplyVO vo) {
		rdao.insert(vo);
		bdao.replycnt(vo.getBno(), 1);		
	}

	@Transactional
	@Override
	public void delete(int rno) {
		ReplyVO vo=rdao.read(rno);
		rdao.delete(rno);
		bdao.replycnt(vo.getBno(), -1);
	}
}
