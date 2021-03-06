package com.example.dao;

import java.util.List;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public interface BoardDAO {
	public List<BoardVO> list(Criteria cri);
	public void insert(BoardVO vo);
	public BoardVO read(int bno);
	public void update(BoardVO vo);
	public void delete(int bno);
	public int totalCount();
}
