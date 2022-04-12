package com.example.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessions=new ArrayList<WebSocketSession>();
	
		//client연결 끈긴경우
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
		System.out.println("연결끊김"+session.getId());
		super.afterConnectionClosed(session, status);
	}
	//연결된경우
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		System.out.println("연결됨"+session.getId());
		super.afterConnectionEstablished(session);
	}
	//클라이언트에서 메시지가 전송된다음
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String strMessage = message.getPayload(); //retrieves messages
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date =sdf.format(new Date());
		strMessage += "|" +date;
		
		System.out.print(strMessage);
		
		for(WebSocketSession web:sessions) {
			web.sendMessage(new TextMessage(strMessage));
		}
		super.handleTextMessage(session, message);
	}


}
