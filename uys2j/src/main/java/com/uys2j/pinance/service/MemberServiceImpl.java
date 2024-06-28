package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.MemberDao;
import com.uys2j.pinance.dto.AttendanceDto;
import com.uys2j.pinance.dto.CommonDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.VacationInformationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberDao memberDao;
	
	@Override
	public int insertMember(MemberDto m) {
		return memberDao.insertMember(m);
	}

	@Override
	public MemberDto selectMember(MemberDto m) {
		return memberDao.selectMember(m);
	}

	@Override
	public List<MemberDto> selectMemberList() {
		return memberDao.selectMemberList();
	}

	@Override
	public int updateMember(Map<String, MemberDto> updateMember) {
		return memberDao.updateMember(updateMember);
	}

	@Override
	public int deleteMember(MemberDto m) {
		return memberDao.deleteMember(m);
	}

	@Override
	public List<CommonDto> selectCommon() {
		return memberDao.selectCommon();
	}

	@Override
	public List<MemberDto> selectBrithMember() {
		return memberDao.selectBrithMember();
	}

	@Override
	public VacationInformationDto selectVacation(MemberDto m) {
		return memberDao.selectVacation(m);
	}

	@Override
	public AttendanceDto selectAttendance(MemberDto m) {
		return memberDao.selectAttendance(m);
	}
	
	@Override
	public int selectUserIdCount(String checkId) {
		return memberDao.selectUserIdCount(checkId);
	}

	@Override
	public List<CommonDto> selectCommonData(String keyword) {
		return memberDao.selectCommonData(keyword);
	}

	@Override
	public String selectNewId() {
		return memberDao.selectNewId();
	}

	@Override
	public int updateModifyPwd(MemberDto loginUser) {
		return memberDao.updateModifyPwd(loginUser);
	}
}
