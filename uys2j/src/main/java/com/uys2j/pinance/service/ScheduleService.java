package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;

public interface ScheduleService {
	
	// 스케줄 조회
	List<ScheduleDto> scheduleSelect(MemberDto loginUser);
	   
   // 스케줄 추가
   int scheduleInsert(ScheduleDto s);
   
   // 스케줄 삭제
   int scheduleDelete(ScheduleDto s);
      
   // 스케줄 수정
   int scheduleUpdate(ScheduleDto s);
   
	// 스케줄 카테고리별 조회
   List<ScheduleDto> scheduleSelectFiltered(Map<String, Object> params);
   



	   

}
