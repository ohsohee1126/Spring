package com.example.dao;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> list(Criteria cri, int bno);
	public int count(int bno);
}
