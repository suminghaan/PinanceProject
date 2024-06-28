package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationInformationDto;

public interface AttendanceService {
	
	// 연차와 남은 연차정보 조회
	VacationInformationDto selectVacInfo(int userNo);
	
	// 지각, 조퇴, 결근 조회
	List<AttendanceDto> selectAttendanceList(String regId);

	public int insertWorkIn(MemberDto m);
	
	public int insertWorkOut(MemberDto m);
	
	public AttendanceDto selectWork(MemberDto m);
	
	public List<VacationInformationDto> selectVacInfoList(VacationInformationDto vo);
	
	public List<VacationDto> selectVacation(int userNo);
	
	public List<VacationDto> empVacationList(String vacMonth, String userId);
	
	public List<AttendanceDto> empAttendanceList(String userId);
	
	//결근
	public int absentDay(MemberDto m);
	
	public List<MemberDto> nullUserId();
	
	
	
}
