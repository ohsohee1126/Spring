package com.example.dao;

import java.util.HashMap;
import java.util.List;

public interface MessageDAO {
	public List<HashMap<String,Object>> sendList(String uid);
	public void sendMessage(String sender, String receiver, String message);
	public List<HashMap<String,Object>> receiveList(String uid);
	public void updateReadDate(int mno);
	public HashMap<String,Object> read(int mno);
}
