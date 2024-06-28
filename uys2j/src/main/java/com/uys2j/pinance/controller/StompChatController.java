package com.uys2j.pinance.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.uys2j.pinance.dto.ChatMessageDto;
import com.uys2j.pinance.dto.ChatRoomDto;
import com.uys2j.pinance.service.ChatService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StompChatController {
	private final SimpMessagingTemplate template;
	private final ChatService chatService;
	  /*
	   * @MessageMapping : Websocket으로 들어오는 메세지 발행을 처리함 
	   * client 쪽에서 prefix로 /pub/chat/enter 로 발행요청시 /sub/chat/room/{roomId}로 메세지 전달
	   * 
	   * client는 해당 주소를 구독(sub) 하고 있다가 메세지가 전달되면 화면에 출력 
	   * 
	   * Handler없어도됨
	   */
	  
	  
	   //servlet-context에서 application~~prefix="/pub" 과 결합되서 
	   // /pub/chat/enter   => 채팅방 입장
	   // /pub/chat/enter?roomId=1&writer=admin
	  @MessageMapping(value="/chat/enter") 
	  public void enter(ChatMessageDto message) {
	      
	   message.setMessage(message.getWriter() + "님이 채팅방에 참여하였습니다.");  // admin님이 채팅방에 참여하였습니다.
	   template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
	   // /sub/chat/room/1  =>  해당 메세지객체{roomId:1, writer:"admin", message:"admin님이 채팅방에 참여하였습니다."}전달
	   
	  }
	  
	  @MessageMapping(value="/chat/message") // /pub/chat/message
	  public void message(ChatMessageDto message) {
		int result = chatService.insertMessage(message);
	    template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
	  }
	  
	  @MessageMapping(value="/chat/out") // /pub/chat/message
	  public void out(ChatMessageDto message) {
		ChatRoomDto outMember = new ChatRoomDto();
		outMember.setUserId(message.getUserId());
		outMember.setRoomId(message.getRoomId());
		int result = chatService.outRoom(outMember);
		message.setMessage(message.getWriter() + "님이 채팅방에서 퇴장하였습니다.");
		int result2 = chatService.insertMessage(message);
	    template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);
	  }
}
