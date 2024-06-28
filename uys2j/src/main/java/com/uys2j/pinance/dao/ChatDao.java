package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.ChatMessageDto;
import com.uys2j.pinance.dto.ChatRoomDto;
import com.uys2j.pinance.dto.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ChatDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public List<ChatRoomDto> selectRoomList(){
		List<ChatRoomDto> list = sqlSessionTemplate.selectList("chatMapper.selectRoomList");
		return list; 
	}

	public List<MemberDto> selectMemberList() {
		return sqlSessionTemplate.selectList("chatMapper.selectMemberList");
	}

	public int insertRoom(ChatRoomDto chatRoom) {
		int result1 = sqlSessionTemplate.insert("chatMapper.insertTarget",chatRoom);
		int result2 = sqlSessionTemplate.insert("chatMapper.insertRoom",chatRoom);
		return result1 + result2;
	}
	
	public int currentRoomId() {
		return sqlSessionTemplate.selectOne("chatMapper.selectRoomId");
	}

	public int insertMessage(ChatMessageDto message) {
		return sqlSessionTemplate.insert("chatMapper.insertMessage",message);
	}

	public List<ChatMessageDto> selectMessage(String roomId) {
		return sqlSessionTemplate.selectList("chatMapper.selectMessage",roomId);
	}

	public int outRoom(ChatRoomDto outMember) {
		return sqlSessionTemplate.update("chatMapper.outRoom",outMember);
	}

	public String selectTargetName(ChatRoomDto target) {
		return sqlSessionTemplate.selectOne("chatMapper.targetName",target);
	}

	public int updateRoomName(ChatRoomDto room) {
		return sqlSessionTemplate.update("chatMapper.updateRoomName",room);
	}
	
}
