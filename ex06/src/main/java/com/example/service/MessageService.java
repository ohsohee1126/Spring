package com.example.service;

import java.util.HashMap;

public interface MessageService {
	public int sendMessage(String sender, String receiver, String message);
	public  HashMap<String,Object>read(int mno);
}
