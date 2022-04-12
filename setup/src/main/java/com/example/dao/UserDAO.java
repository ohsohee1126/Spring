package com.example.dao;

import com.example.domain.UserVO;

public interface UserDAO {
	public UserVO read(String uid);
}
