package com.uys2j.pinance.util;

import org.springframework.stereotype.Component;

import com.uys2j.pinance.dto.NotificationDto;


@Component
public class TempData {

	public NotificationDto setNotification(String type) {
		NotificationDto noti = new NotificationDto();
		//이전에 입력한 데이터가 없는 경우
		return setData(type, noti);
	}
	
	public NotificationDto setNotification(String type, NotificationDto noti) {
		//이전에 입력한 데이터가 있는 경우
		return setData(type, noti);
	}
	
	public NotificationDto setData(String type, NotificationDto noti) {
		
		switch (type) {
			case "board": 
				noti.setNotificationContent("새로운 게시글이 올라왔습니다."); 
				noti.setRefType("게시판");
			break;
			
			case "workIn": 
				noti.setNotificationContent("정상 출근 처리 되었습니다.");
				noti.setNotificationIcon("mdi mdi-comment-check-outline");
				noti.setRefType("근태관리");
			break;//출근
			
			case "workOut": 
				noti.setNotificationContent("정상 퇴근 처리 되었습니다.");
				noti.setNotificationIcon("mdi mdi-comment-check-outline");
				noti.setRefType("근태관리");
			break;//퇴근
			
			//결재선
			case "insertEdoc": 
				noti.setNotificationContent("새로운 전자결재 정보가 등록되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-plus-outline");
				noti.setRefAddress("/edoc/uploadApprovalList.page");
				noti.setRefType("전자결재");
			break;//전자결재 등록시 결제선 결재할
			
			case "modifyEdoc": 
				noti.setNotificationContent("전자결재 정보가 수정되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-plus-outline");
				noti.setRefAddress("/edoc/approvalList.page");
				noti.setRefType("전자결재");
			break;//전자결재 등록시 결제선 결재할
			
			case "enterEdoc": 
				noti.setNotificationContent("대기중인 결재서류가 존재합니다.");
				noti.setNotificationIcon("mdi mdi-book-plus-outline");
				noti.setRefAddress("/edoc/approvalList.page");
				noti.setRefType("전자결재");
			break;//전자결재 등록시 결제선 결재할
			
			case "rejEdoc": 
				noti.setNotificationContent("등록된 전자결재 서류가 반려처리 되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-minus-outline");
				noti.setRefAddress("/edoc/finishApprovalList.page");
				noti.setRefType("전자결재");
			break;//전자 결재 참조자 알람 보내기
			
			case "endEdoc": 
				noti.setNotificationContent("등록된 전자결재 서류가 완료 되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-remove-outline");
				noti.setRefAddress("/edoc/finishApprovalList.page");
				noti.setRefType("전자결재");
			break;//전자 결재 참조자 알람 보내기
			
			case "deleteEdoc": 
				noti.setNotificationContent("등록된 전자결재 서류가 삭제 되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-remove-outline");
				noti.setRefAddress("/edoc/uploadApprovalList.page");
				noti.setRefType("전자결재");
			break;//전자 결재 참조자 알람 보내기

			//참조자
			case "refEdoc": 
				noti.setNotificationContent("새로운 전자결재의 참조자로 등록되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-lock-outline");
				noti.setRefAddress("/edoc/approvalList.page");
				noti.setRefType("전자결재");
			break;//전자 결재 참조자 알람 보내기

			case "refModifyEdoc": 
				noti.setNotificationContent("수정된 전자결재 서류의 참조자로 등록되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-lock-outline");
				noti.setRefAddress("/edoc/approvalList.page");
				noti.setRefType("전자결재");
			break;//전자 결재 참조자 알람 보내기
			
			case "refDeleteEdoc": 
				noti.setNotificationContent("참조되었던 전자결재 서류가 삭제되었습니다.");
				noti.setNotificationIcon("mdi mdi-book-lock-outline");
				noti.setRefAddress("/edoc/uploadApprovalList.page");
				noti.setRefType("전자결재");
			break;//전자 결재 참조자 알람 보내기
			
			case "C": 
				noti.setNotificationContent("새로운 비품 정보가 올라왔습니다.");
				noti.setRefAddress("/eq/eq.page");
				noti.setRefType("비품");
			break;//비품
			
			case "F": 
				noti.setNotificationContent("새로운 시설 정보가 올라왔습니다.");
				noti.setRefAddress("/fac/fac.page");
				noti.setRefType("시설");
			break;//시설
			
			case "S": 
				noti.setNotificationContent("새로운 일정 정보가 올라왔습니다.");
				noti.setRefAddress("/schedule/schedule.page");
				noti.setRefType("일정");
			break;//일정
			
			case "chatEnter": 
				noti.setNotificationContent("채팅방에 입장했습니다.");
				noti.setNotificationIcon("mdi mdi-chat-processing-outline");
				noti.setRefAddress("/room/page");
				noti.setRefType("채팅");
			break;//채팅방 입장
			
			case "chatExit": 
				noti.setNotificationContent("채팅방에서 퇴장했습니다.");
				noti.setNotificationIcon("mdi mdi-chat-processing-outline");
				noti.setRefAddress("/room/page");
				noti.setRefType("채팅");
			break;//채팅방 입장
		}
		
		return noti;
	}
}
