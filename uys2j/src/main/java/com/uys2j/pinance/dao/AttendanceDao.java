package com.uys2j.pinance.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationDto;
import com.uys2j.pinance.dto.VacationInformationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Repository
@Slf4j
public class AttendanceDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public int insertWorkIn(MemberDto m) {
		return sqlSessionTemplate.insert("attendanceMapper.insertWorkIn", m);
	}

	public int insertWorkOut(MemberDto m) {
		return sqlSessionTemplate.insert("attendanceMapper.updateWorkOut", m);
	}
	
	public AttendanceDto selectWork(MemberDto m) {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectWork", m);
	}

	public VacationInformationDto selectVacInfo(int userNo) {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectVacInfo", userNo);
	}
	
	public List<AttendanceDto> selectAttendance (String regId) {
		return sqlSessionTemplate.selectList("attendanceMapper.selectAttendanceList", regId);
	}
	
	public List<VacationInformationDto> selectVacInfoList(VacationInformationDto vo){
		return sqlSessionTemplate.selectList("attendanceMapper.selectVacInfoList", vo);
	}
	
	public List<VacationDto> selectVacation(int userNo){
		return sqlSessionTemplate.selectList("attendanceMapper.selectVacation", userNo);
	}
	
	public List<VacationDto> empVacationList(String vacMonth, String userId) {
	    Map<String, String> params = new HashMap<>();
	    params.put("vacMonth", vacMonth);
	    params.put("userId", userId);
	    return sqlSessionTemplate.selectList("attendanceMapper.empVacationList", params);
	}
	
	public List<AttendanceDto> empAttendanceList(String userId){
		log.debug("dao {}", sqlSessionTemplate.selectList("attendanceMapper.empAttendanceList"));
		return sqlSessionTemplate.selectList("attendanceMapper.empAttendanceList", userId);
	}
	
	// 결근
	public int absentDay(MemberDto m) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userId", m.getUserId());
	    return sqlSessionTemplate.insert("attendanceMapper.absentDay", params);
	}
	
	public List<MemberDto> nullUserId(){
		return sqlSessionTemplate.selectList("attendanceMapper.nullUserId");
	}
}
