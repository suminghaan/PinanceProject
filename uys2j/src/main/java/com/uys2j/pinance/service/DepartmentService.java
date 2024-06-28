package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.MemberDto;

public interface DepartmentService {

	// 조직도 조회
	List<DepartmentDto> selectDepartmentList();
	
	// 조직도 추가
	int insertDepartment(DepartmentDto Department);
	
	// 조직도 삭제
	int deleteDepartment(String deptValue);
	
	// 조직도 수정
	int updateDepartment(Map<String, String> map);
	
	// 조직도 검색
	List<DepartmentDto> serachDepartment(String keyword);
		
	// 사원 조회
	List<MemberDto> selectDeptMember(String dept);
	
	// 사원 카운트 조회
	int selectDeptNullCount();
	
	// 부서 미지정 멤버 조회
	List<MemberDto> emptyMemberList();
	
	
}
