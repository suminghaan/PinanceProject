package com.uys2j.pinance.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.uys2j.pinance.dto.ChatMessageDto;
import com.uys2j.pinance.dto.ChatRoomDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.service.ChatService;
import com.uys2j.pinance.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/room")
@RequiredArgsConstructor
@Slf4j
public class RoomController {
	
	private final ChatService chatService;
	
	@ResponseBody
	@GetMapping("/list")
	public List<ChatRoomDto> rooms(){
		//전체 채팅방 리스트 반환
		List<ChatRoomDto> list = chatService.selectRoomList();
		return list;
	}
	
	@GetMapping("/page")
	public String chatPage(Model model) {
		List<MemberDto> memberList = chatService.selectMemberList();
		model.addAttribute("memberList",memberList);
		return "chat/roomList";
	}
	
	@GetMapping("/{roomId}") // /chattest/room/xx 요청시 특정 채팅방 조회해주는 controller
	  public String getRoom(@PathVariable("roomId") String roomId,HttpSession session ,Model model) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
	    List<ChatRoomDto> list = chatService.selectRoomList(); // 전체 채팅방정보 조회
	    ChatRoomDto chatroom = null;
	    ChatRoomDto target = new ChatRoomDto();
	    for(ChatRoomDto room : list) {
	      if(room.getRoomId().equals(roomId) && room.getUserId().equals(loginUser.getUserId())) {
	        chatroom = room;
	      }
	    }
	    
	    String userId = loginUser.getUserId();
	    target.setUserId(userId);
	    target.setRoomId(roomId);
	    String targetName =chatService.selectTargetName(target); 
	    
	    List<ChatMessageDto> messages = null;
	    if(chatroom != null) {
	    	messages = chatService.selectMessage(chatroom.getRoomId());
	    	if (messages == null) {
	    	    messages = new ArrayList<>();
	    	}
	    }
	    List<MemberDto> memberList = chatService.selectMemberList();
		model.addAttribute("memberList",memberList);
	    model.addAttribute("room", chatroom);
	    model.addAttribute("targetName", targetName);
	    model.addAttribute("messages", messages);
	    return "chat/room";
	  }
	
	@GetMapping("/create.room") // /chattest/room/xx 요청시 특정 채팅방 조회해주는 controller
	  public String createRoom(ChatRoomDto chatRoom,String userName, RedirectAttributes redirectAttributes) {
		if(chatRoom.getRoomName() == "") {
			chatRoom.setRoomName(userName + "의 채팅방");
		}
		//방정보 insert 하고 room에 담아서 리턴
		int result = chatService.createRoom(chatRoom);
		// 성공비교 안했음.
		String roomId = String.valueOf(chatService.currentRoomId());
		
		List<ChatRoomDto> list = chatService.selectRoomList();
		ChatRoomDto chatroom = null;
		for(ChatRoomDto room : list) {
	      if(room.getRoomId().equals(roomId)) {
	        chatroom = room;
	      }
	    }
	    String targetName = chatRoom.getTargetName();
	    List<MemberDto> memberList = chatService.selectMemberList();
		
	    redirectAttributes.addFlashAttribute("memberList",memberList);
	    redirectAttributes.addFlashAttribute("room", chatroom);
	    redirectAttributes.addFlashAttribute("targetName", targetName);
	    
	    return "redirect:/room/" + roomId;
	  }
	
	@ResponseBody
	@PostMapping("/update.name")
	public int updateRoom(String newName,String userId,String roomId) {
		ChatRoomDto room = new ChatRoomDto();
		room.setRoomId(roomId);
		room.setRoomName(newName);
		room.setUserId(userId);
		int result = chatService.updateRoomName(room);
		return result;
	}	
	
}
