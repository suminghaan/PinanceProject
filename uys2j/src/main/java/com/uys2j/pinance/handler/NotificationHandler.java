package com.uys2j.pinance.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uys2j.pinance.dao.NotificationDao;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.NotificationDto;
import com.uys2j.pinance.service.NotificationService;
import com.uys2j.pinance.util.TempData;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
public class NotificationHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<>();
	
	private final TempData tempData;

	/**
	 *	1) afterConnectionEstablished : 클라이언트와 연결이 되었을 때 처리할 내용을 정의
	 *
	 *	@param session - 현재 웹소켓과 연결된 클라이언트 정보를 가지고 있는 객체
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		log.debug("===================== websocket 연결됨 ================");
		log.debug("WebSocket Session객체 : {}", session);
		log.debug("session Id : {}", session.getId());
		log.debug("session Attributes: {}", session.getAttributes());
		
		sessionList.add(session);
		
		//입장 메세지 전달
		for(WebSocketSession client : sessionList) {
			String msg = "알람 방 입장";
			log.debug("msg:{}",msg);
		}
	}
	
	/**
	 *	2) handleMessage : 데이터(텍스트, 파일등)가 웹소켓으로 전송되었을때 처리할 내용을 정의
	 *	
	 *	@param message - 현재 웹소켓으로 전달된 데이터에 대한 정보를 가지고 있는 객체
	 */
	@Override
	@ResponseBody
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		log.debug("============== 메세지 들어옴 ==============");
		log.debug("현재 웹소켓으로 전달된 메세지 내용 : {}", message.getPayload());
		ObjectMapper objectMapper = new ObjectMapper();
		
		// 현재 해당 웹소켓에 연결되어있는 모든 클라이언트들에게 현재 들어온 메세지를 재발송함(작성자 본인 포함)
		for(WebSocketSession client : sessionList) {
			// jsp쪽에서 보낸 메세지 ex)알람 타입, 알람 보낼 유저 ID
			String[] data = ((String) message.getPayload()).split(",");
			// 알람 타입
			String type = data[0];
			log.debug("type : {}", type);
			// 알람 받을 유저 아이디
			String receiveUser = data[1];
			log.debug("받는 사람 : {}", receiveUser);
			// 현재 세션에 들어와있는 유저의 아이디
			String clientId = ((MemberDto)client.getAttributes().get("loginUser")).getUserId();
			
			//전달 받은 메시지의 데이터에 유저 정보를 비교해서 맞는 알람 보내기
			if(receiveUser.equals(clientId)) {
				NotificationDto noti = tempData.setNotification(type);
				log.debug("noti : {}", noti);
				// 알람 객체의 정보를 담고 jsp로 보내질 String타입의 변수
				String msg = objectMapper.writeValueAsString(noti);
				client.sendMessage(new TextMessage(msg));
			}
			//현재 접속해있는 모든 계정
			//접속해 있는 계정중 내가 보내고 싶은 유저아이디와 같은 유저아이디 일경우
			
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
