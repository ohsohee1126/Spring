package com.example.dao;

import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public interface BoardDAO {
	public List<BoardVO> list(Criteria cri);
	public BoardVO read(int bno);
	public int count(Criteria cri);
}
