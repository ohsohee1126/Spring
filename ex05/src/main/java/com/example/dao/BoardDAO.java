package com.example.dao;

import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public interface BoardDAO {
	public List<BoardVO> list(Criteria cri);
	public BoardVO read(int bno);
	public int count(Criteria cri);
	//view count 1씩증가
	public void viewcnt(int bno);
	//replycnt 1씩증가 하거나 감소
	public void replycnt(int bno, int amount);
}
