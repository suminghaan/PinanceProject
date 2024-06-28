package com.uys2j.pinance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.ChatDao;
import com.uys2j.pinance.dto.ChatMessageDto;
import com.uys2j.pinance.dto.ChatRoomDto;
import com.uys2j.pinance.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ChatServiceImpl implements ChatService {
	
	private final ChatDao chatDao;
	
	@Override
	public List<ChatRoomDto> selectRoomList() {
		return chatDao.selectRoomList();
	}

	@Override
	public List<MemberDto> selectMemberList() {
		return chatDao.selectMemberList();
	}

	@Override
	public int createRoom(ChatRoomDto chatRoom) {
		return chatDao.insertRoom(chatRoom);
	}

	@Override
	public int currentRoomId() {
		return chatDao.currentRoomId();
	}

	@Override
	public int insertMessage(ChatMessageDto message) {
		return chatDao.insertMessage(message);
	}

	@Override
	public List<ChatMessageDto> selectMessage(String roomId) {
		return chatDao.selectMessage(roomId);
	}

	@Override
	public int outRoom(ChatRoomDto outMember) {
		return chatDao.outRoom(outMember);
	}

	@Override
	public String selectTargetName(ChatRoomDto target) {
		return chatDao.selectTargetName(target);
	}

	@Override
	public int updateRoomName(ChatRoomDto room) {
		return chatDao.updateRoomName(room);
	}

}
