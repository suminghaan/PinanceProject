package com.uys2j.pinance.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ScheduleDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	public List<ScheduleDto> scheduleSelect(MemberDto loginUser){
		return sqlSessionTemplate.selectList("scheduleMapper.scheduleSelect", loginUser);
	}

	public int scheduleInsert(ScheduleDto s) {
		return sqlSessionTemplate.insert("scheduleMapper.scheduleInsert", s);
	}

	public int scheduleDelete(ScheduleDto s) {
		return sqlSessionTemplate.update("scheduleMapper.scheduleDelete", s);
	}

	public int scheduleUpdate(ScheduleDto s) {
		return sqlSessionTemplate.update("scheduleMapper.scheduleUpdate", s);
	}
	
	public List<ScheduleDto> scheduleSelectFiltered(Map<String, Object> params) {
	    return sqlSessionTemplate.selectList("scheduleMapper.scheduleSelectFiltered", params);
	}





}
