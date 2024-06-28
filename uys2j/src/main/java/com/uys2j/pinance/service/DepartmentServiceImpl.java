package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.DepartmentDao;
import com.uys2j.pinance.dto.DepartmentDto;
import com.uys2j.pinance.dto.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class DepartmentServiceImpl implements DepartmentService {
	
	private final DepartmentDao departmentDao;
	
	@Override
	public List<DepartmentDto> selectDepartmentList() {
		return departmentDao.selectDepartmentList();
	}

	@Override
	public int insertDepartment(DepartmentDto Department) {
		int result1 = 1; 
		int result2 = departmentDao.insertCommon(Department);
		
		String checkWord = Department.getDeptValue().substring(0, 2);
		if(result2 > 0 && (!checkWord.equals("CP") && !checkWord.equals("CR"))) {
			result1 = departmentDao.insertDepartment(Department);
		}
		return result1 * result2;
	}

	@Override
	public int deleteDepartment(String deptValue) {
		return departmentDao.deleteDepartment(deptValue);
	}

	@Override
	public List<DepartmentDto> serachDepartment(String keyword) {
		return departmentDao.serachDepartment(keyword);
	}

	@Override
	public List<MemberDto> selectDeptMember(String dept) {
		return departmentDao.selectDeptMember(dept);
	}

	@Override
	public int selectDeptNullCount() {
		return departmentDao.selectDeptNullCount();
	}

	@Override
	public int updateDepartment(Map<String, String> map) {
		int result = 0;
		int result2 = 1;
		int result3 = 1;
		if(map.get("nodeId").length() <= 5) {
			result = departmentDao.updateDepartment(map);
			log.debug("result {} ", result);
			result3 = departmentDao.updateCommon(map);
			log.debug("result3 {} ", result3);
			result2 = departmentDao.updateMember(map);
			log.debug("result2 {} ", result2);
		}else {
			result = departmentDao.updateMember(map);
		}
		return result * result2 * result3;
	}

	public int selectCodeCount(String checkCode) {
		return departmentDao.selectCodeCount(checkCode);
	}
	
	public int delCodeCheck(String checkCode) {
		return departmentDao.delCodeCheck(checkCode);
	}

	@Override
	public List<MemberDto> emptyMemberList() {
		return departmentDao.emptyMemberList();
	}
	
	
}
