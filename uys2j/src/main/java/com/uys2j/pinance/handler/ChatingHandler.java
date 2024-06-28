package com.uys2j.pinance.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.uys2j.pinance.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatingHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<>();

	/**
	 *	1) afterConnectionEstablished : 클라이언트와 연결이 되었을 때 처리할 내용을 정의
	 *
	 *	@param session - 현재 웹소켓과 연결된 클라이언트 정보를 가지고 있는 객체
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//roomId 넘겨받아서 방생성하기 + 넘어온 멤버값 id 등록하기
		log.debug("===================== websocket 연결됨 ================");
		log.debug("WebSocket Session객체 : {}", session);
		log.debug("session Id : {}", session.getId());
		log.debug("session Attributes: {}", session.getAttributes());
		
		sessionList.add(session);
		
		//입장 메세지 전달
		
		for(WebSocketSession client : sessionList) {
			// 전달하고자 하는 메세지의 형식 : 메세지유형(chat/entry/exit)|메세지내용|...
			String msg = "메시지 잘 찍히나 확인중";
			log.debug("msg:{}",msg);
			client.sendMessage(new TextMessage(msg)); // * 채팅방jsp의 onMessage function 실행
		}
		
	}
	
	/**
	 *	2) handleMessage : 데이터(텍스트, 파일등)가 웹소켓으로 전송되었을때 처리할 내용을 정의
	 *	
	 *	@param message - 현재 웹소켓으로 전달된 데이터에 대한 정보를 가지고 있는 객체
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		log.debug("============== 메세지 들어옴 ==============");
		log.debug("현재 웹소켓으로 전달된 메세지 내용 : {}", message.getPayload());
		
		// 현재 해당 웹소켓에 연결되어있는 모든 클라이언트들에게 현재 들어온 메세지를 재발송함(작성자 본인 포함)
		for(WebSocketSession client : sessionList) {
			// 전달하고자 하는 메세지의 형식 : 메세지유형(chat/entry/exit)|메세지내용|발신자아이디|...
			//String msg = (String) message.getPayload();
			String msg = "chat|" + message.getPayload() + "|" 
					+ ((MemberDto)session.getAttributes().get("loginUser")).getUserId();
			log.debug("msg:{}",msg);
			client.sendMessage(new TextMessage(msg)); // * 채팅방jsp의 onMessage function 실행
		}
		
		//db에 채팅메시지 내역을 남기고자할 경우
		//EchoHandler에서 Service연결해서
		//insert 요청하기
	}
	
	/**
	 *	3)afterConnectionClosed : 클라이언트와 연결이 끊겼을 때 처리할 내용을 정의
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.debug("===================== websocket 연결 끊김 ================");
		log.debug("WebSocket Session객체 : {}", session);
		log.debug("session Id : {}", session.getId());
		
		sessionList.remove(session);
		
		//입장 메세지 전달
		for(WebSocketSession client : sessionList) {
			// 전달하고자 하는 메세지의 형식 : 메세지유형(chat/entry/exit)|메세지내용|...
			String msg = "로그 아웃";
			log.debug("msg:{}",msg);
			client.sendMessage(new TextMessage(msg)); // * 채팅방jsp의 onMessage function 실행
		}
	}
}
