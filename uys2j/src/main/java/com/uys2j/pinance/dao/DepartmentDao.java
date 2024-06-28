package com.uys2j.pinance.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class DepartmentDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	public List<DepartmentDto> selectDepartmentList() {
		return sqlSessionTemplate.selectList("commonMapper.selectDepartmentList");
	}

	public int insertCommon(DepartmentDto Department) {
		return sqlSessionTemplate.insert("commonMapper.insertCommon", Department);
	}
	
	public int insertDepartment(DepartmentDto Department) {
		return sqlSessionTemplate.insert("commonMapper.insertDepartment", Department);
	}

	public int deleteDepartment(String deptValue) {
		return sqlSessionTemplate.delete("commonMapper.deleteDepartment", deptValue);
	}

	public List<DepartmentDto> serachDepartment(String keyword) {
		return sqlSessionTemplate.selectList("commonMapper.serachDepartment", keyword);
	}
	

	public List<MemberDto> selectDeptMember(String dept) {
		return sqlSessionTemplate.selectList("memberMapper.selectDeptMember", dept);
	}
	
	public int selectDeptNullCount() {
		return sqlSessionTemplate.selectOne("memberMapper.selectDeptNullCount");
	}

	public int updateDepartment(Map<String, String> map) {
		return sqlSessionTemplate.update("commonMapper.updateDepartment", map);
	}
	
	public int updateCommon(Map<String, String> map) {
		return sqlSessionTemplate.update("commonMapper.updateCommon", map);
	}
	
	public int updateMember(Map<String, String> map) {
		return sqlSessionTemplate.update("memberMapper.updateDeptMember", map);
	}

	public int selectCodeCount(String checkCode) {
		return sqlSessionTemplate.selectOne("commonMapper.selectCodeCount", checkCode);
	}

	public int delCodeCheck(String checkCode) {
		return sqlSessionTemplate.selectOne("commonMapper.selectCodeCount", checkCode);
	}

	public List<MemberDto> emptyMemberList() {
		return sqlSessionTemplate.selectList("memberMapper.emptyMemberList");
	}
	
}
