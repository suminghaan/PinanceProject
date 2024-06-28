package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.NotificationDto;

public interface NotificationService {

	//유저 아이디로 모든 알람 정보 긁어오기
	List<NotificationDto> selectNotiList(String userId);
	
	//한개의 알림 정보를 긁어오기
	NotificationDto selectNoti(String type, String userId);
	
	//읽은 상태로 만들기 위해 상태값 N으로 변경
	int updateNoti(NotificationDto noti);
	
	//내가 선택한 하나의 알람 지우기
	int deleteNoti(NotificationDto noti);
	
	//모든 알람 지우기
	int deleteAll(MemberDto loginUser);

	//알림 추가
	int insertNoti(NotificationDto noti);
}
