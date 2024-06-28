package com.uys2j.pinance.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.ScheduleDao;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	private final ScheduleDao scheduleDao;

	@Override
	public List<ScheduleDto> scheduleSelect(MemberDto loginUser) {
		return scheduleDao.scheduleSelect(loginUser);
	}

	@Override
	public int scheduleInsert(ScheduleDto s) {
		return scheduleDao.scheduleInsert(s);
	}

	@Override
	public int scheduleDelete(ScheduleDto s) {
		return scheduleDao.scheduleDelete(s);
	}

	@Override
	public int scheduleUpdate(ScheduleDto s) {
		return scheduleDao.scheduleUpdate(s);
	}
	
	@Override
	public List<ScheduleDto> scheduleSelectFiltered(Map<String, Object> params) {
	    return scheduleDao.scheduleSelectFiltered(params);
	}




}
