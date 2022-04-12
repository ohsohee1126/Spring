package com.example.dao;

import java.util.List;

import com.example.domain.MessageVO;

public interface MessageDAO {
	//�����޽������
	public List<MessageVO> sendList(String uid);
	//�����޽��� ���
	public List<MessageVO> receiveList(String uid);
	
	//�޽���������
	public void insert(MessageVO vo);
	
	//Ư���޽��� �б�
	public MessageVO read(int mno);
	
	//������¥ ���糯¥�� ����
	public void updateReaddate(int mno);
	
	public void updateSendcnt(String uid);
	public void updateRececnt(String uid);
}
