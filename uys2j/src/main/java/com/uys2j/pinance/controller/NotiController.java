package com.uys2j.pinance.controller;

import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uys2j.pinance.dto.DefaultDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.NotificationDto;
import com.uys2j.pinance.service.NotificationService;
import com.uys2j.pinance.util.TempData;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@RequestMapping("/noti")
@Controller
@Slf4j
public class NotiController {
	
	private final NotificationService notiService;
	private final TempData tempData;
	
	@GetMapping("/room.page")
	public String chatRoomPage() {
		return "redirect:/";
	}
	
	@ResponseBody
	@PostMapping("/list.do")
	public List<NotificationDto> notification(String userId) {
		log.debug("아이디 : {}", userId);
		return notiService.selectNotiList(userId);
	}
	
	@ResponseBody
	@PostMapping("/deleteOne.do")
	public String deleteOne(NotificationDto noti) {
		notiService.deleteNoti(noti);
		return "";
	}
	
	@ResponseBody
	@PostMapping("/deleteAll.do")
	public String deleteAll(HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		notiService.deleteAll(loginUser);
		return "";
	}
	
	@ResponseBody
	@PostMapping("/update.do")
	public int updateNoti(NotificationDto noti, HttpSession session) {
		log.debug("noti:{}", noti);
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		DefaultDto dd = new DefaultDto();
		dd.setRegId(loginUser.getUserId());
		noti.setDefaultDto(dd);
		int result = notiService.updateNoti(noti);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/insert.do")
	public int insertNoti(String type, String refUser, HttpSession session) {
		log.debug("insert Noti {}",type);
		NotificationDto noti = new NotificationDto();
		DefaultDto dd = new DefaultDto();
		
		dd.setRegId(refUser);
		noti.setDefaultDto(dd);
		noti = tempData.setNotification(type, noti);
		log.debug("notiData : {}", noti);
		
		int result = notiService.insertNoti(noti);
		return result;
	}
}
