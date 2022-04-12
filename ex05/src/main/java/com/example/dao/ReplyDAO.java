package com.example.dao;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> list(Criteria cri, int bno);
	public int count(int bno);
	public void insert(ReplyVO vo);
	public void update(ReplyVO vo);
	public void delete(int rno);
	public ReplyVO read(int rno);
}
