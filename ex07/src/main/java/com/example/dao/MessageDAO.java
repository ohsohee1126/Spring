package com.example.dao;

import java.util.List;

import com.example.domain.MessageVO;

public interface MessageDAO {
	//보낸메시지목록
	public List<MessageVO> sendList(String uid);
	//받은메시지 목록
	public List<MessageVO> receiveList(String uid);
	
	//메시지보내기
	public void insert(MessageVO vo);
	
	//특정메시지 읽기
	public MessageVO read(int mno);
	
	//읽은날짜 현재날짜로 수정
	public void updateReaddate(int mno);
	
	public void updateSendcnt(String uid);
	public void updateRececnt(String uid);
}
