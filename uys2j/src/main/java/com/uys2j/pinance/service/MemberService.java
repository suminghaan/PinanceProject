package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.CommonDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationInformationDto;

public interface MemberService {

	//멤버 추가
	int insertMember(MemberDto m);
	
	//마이페이지 검색
	MemberDto selectMember(MemberDto m);
	
	//전체 멤버 목록 리스트
	List<MemberDto> selectMemberList();
	
	//멤버 수정
	int updateMember(Map<String, MemberDto> updateMember);
	
	//멤버 삭제
	int deleteMember(MemberDto m);

	//db에 저장되어있는 직책 직위 지점 부서 값 가져오기
	List<CommonDto> selectCommon();
	
	// 로그인 멤버의 연차 조회
	VacationInformationDto selectVacation(MemberDto m);
	
	// 로그인 멤버의 근무일수 조회
	AttendanceDto selectAttendance(MemberDto m);
	
	// 생일자 조회
	List<MemberDto> selectBrithMember();

	//사번 중복체크용
	int selectUserIdCount(String checkId);

	//관련된 지점, 부서, 직책, 직급 가져오기
	List<CommonDto> selectCommonData(String keyword);

	//자동으로 세팅되는 다음 사번 찾아오기
	String selectNewId();

	//비밀번호 변경
	int updateModifyPwd(MemberDto loginUser);
}
