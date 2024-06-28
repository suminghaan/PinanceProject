package com.uys2j.pinance.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.CommonDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationInformationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class MemberDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public int insertMember(MemberDto m) {
		return sqlSessionTemplate.insert("memberMapper.insertMember", m);
	}

	public MemberDto selectMember(MemberDto m) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMember", m);
	}

	public List<MemberDto> selectMemberList() {
		return sqlSessionTemplate.selectList("memberMapper.selectMemberList");
	}

	public int updateMember(Map<String, MemberDto> updateMember) {
		return sqlSessionTemplate.update("memberMapper.updateMember", updateMember);
	}
	
	public int deleteMember(MemberDto m) {
		return sqlSessionTemplate.update("memberMapper.deleteMember", m);
	}

	public List<CommonDto> selectCommon() {
		return sqlSessionTemplate.selectList("commonMapper.selectCommon");
	}

	public List<MemberDto> selectBrithMember() {
		return sqlSessionTemplate.selectList("memberMapper.selectBrithMember");
	}

	public VacationInformationDto selectVacation(MemberDto m) {
		return sqlSessionTemplate.selectOne("memberMapper.selectVacation", m);
	}

	public AttendanceDto selectAttendance(MemberDto m) {
		return sqlSessionTemplate.selectOne("memberMapper.selectAttendance", m);
	}
	
	public int selectUserIdCount(String checkId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectUserIdCount", checkId);
	}

	public List<CommonDto> selectCommonData(String keyword) {
		return sqlSessionTemplate.selectList("commonMapper.selectCommonData", keyword);
	}

	public String selectNewId() {
		return sqlSessionTemplate.selectOne("memberMapper.selectNewId");
	}

	public int updateModifyPwd(MemberDto loginUser) {
		return sqlSessionTemplate.update("memberMapper.updateModifyPwd", loginUser);
	}
}
