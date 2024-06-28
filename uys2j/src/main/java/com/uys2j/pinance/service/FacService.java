package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import com.uys2j.pinance.dto.FacDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;

public interface FacService {
	
   // 시설 추가
   int facInsert(FacDto f);
   
   // 시설 삭제
   int facDelete(FacDto f);
   FacDto facUpdatepage(int facNo);
   
   // 시설 조회
   List<FacDto> facSelect();
   
   // 시설 예약 추가
   int faclistInsert(ScheduleDto s);
   
   // 시설 예약 조회
   List<ScheduleDto> scSelect();
   
   // 내 예약 현황 조회
   public List<ScheduleDto> getReservationsByDate(Map<String, Object> map);
   
   // 시설 예약 삭제
   int faclistDelete(ScheduleDto s);
      
   // 시설 예약 수정
   int faclistUpdate(ScheduleDto s);

}
