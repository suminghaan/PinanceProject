package com.uys2j.pinance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.NotificationDao;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.NotificationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class NotificationServiceImpl implements NotificationService {
	private final NotificationDao notiDao;

	@Override
	public List<NotificationDto> selectNotiList(String userId) {
		return notiDao.selectNotiList(userId);
	}

	@Override
	public int updateNoti(NotificationDto noti) {
		return notiDao.updateNoti(noti);
	}

	@Override
	public int deleteNoti(NotificationDto noti) {
		return notiDao.deleteNoti(noti);
	}

	@Override
	public int deleteAll(MemberDto loginUser) {
		return notiDao.deleteAll(loginUser);
	}

	@Override
	public int insertNoti(NotificationDto noti) {
		return notiDao.insertNoti(noti);
	}

	@Override
	public NotificationDto selectNoti(String type, String userId) {
		return notiDao.selectNoti(type, userId);
	}
}
