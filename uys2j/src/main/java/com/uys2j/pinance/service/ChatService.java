package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.ChatMessageDto;
import com.uys2j.pinance.dto.ChatRoomDto;
import com.uys2j.pinance.dto.MemberDto;

public interface ChatService {
	
	List<ChatRoomDto> selectRoomList();

	List<MemberDto> selectMemberList();

	int createRoom(ChatRoomDto chatRoom);
	
	int currentRoomId();

	int insertMessage(ChatMessageDto message);

	List<ChatMessageDto> selectMessage(String roomId);

	int outRoom(ChatRoomDto outMember);

	String selectTargetName(ChatRoomDto target);

	int updateRoomName(ChatRoomDto room);
}
