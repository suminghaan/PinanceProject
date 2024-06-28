package com.uys2j.pinance.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.NotificationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class NotificationDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public List<NotificationDto> selectNotiList(String userId) {
		log.debug("user : {}", userId);
		return sqlSessionTemplate.selectList("notificationMapper.selectNotiList", userId);
	}
	
	public int updateNoti(NotificationDto noti) {
		return sqlSessionTemplate.update("notificationMapper.updateNoti", noti);
	}
	
	public int deleteNoti(NotificationDto noti) {
		return sqlSessionTemplate.delete("notificationMapper.deleteNoti", noti);
	}
	
	public int deleteAll(MemberDto loginUser) {
		return sqlSessionTemplate.delete("notificationMapper.deleteAll", loginUser);
	}

	public int insertNoti(NotificationDto noti) {
		return sqlSessionTemplate.insert("notificationMapper.insertNoti", noti);
	}

	public NotificationDto selectNoti(String type, String userId) {
		Map<String, String> noti = new HashMap<String, String>();
		noti.put("type", type);
		noti.put("userId", userId);
		return sqlSessionTemplate.selectOne("notificationMapper.selectNoti", noti);
	}
}
