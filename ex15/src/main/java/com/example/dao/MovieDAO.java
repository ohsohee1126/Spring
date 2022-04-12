package com.example.dao;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.MovieVO;

public interface MovieDAO {
	public List<MovieVO> list(Criteria cri);
	public MovieVO check(String link);
	public void insert(MovieVO vo);
	public int total();
}
