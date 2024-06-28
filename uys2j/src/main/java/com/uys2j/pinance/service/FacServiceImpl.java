package com.uys2j.pinance.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.FacDao;
import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.FacDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class FacServiceImpl implements FacService {
	
	private final FacDao facDao;

	@Override
	public int facInsert(FacDto f) {
		int result1 = facDao.facInsert(f);
		
		int result2 = 0;
		
		List<AttachDto> attachList = f.getAttachList();
		if(!attachList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : attachList) {
				result2 += facDao.attachInsert(at);
			}
		}
		return result1*result2;
	}

	@Override
	public int facDelete(FacDto f) {
		return facDao.facDelete(f);
	}
	
	@Override
	public FacDto facUpdatepage(int facNo) {
		return facDao.facUpdatePage(facNo);
	}

	@Override
	public List<FacDto> facSelect() {
		return facDao.facSelect();
	}

	@Override
	public int faclistInsert(ScheduleDto s) {
		return facDao.faclistInsert(s);
	}
	
	@Override
	public List<ScheduleDto> scSelect() {
		return facDao.scSelect();
	}
	
	@Override
	public List<ScheduleDto> getReservationsByDate(Map<String, Object> map) {
	    return facDao.getReservationsByDate(map);
	}
	
	@Override
	public int faclistDelete(ScheduleDto s) {
		return facDao.faclistDelete(s);
	}

	@Override
	public int faclistUpdate(ScheduleDto s) {
		return facDao.faclistUpdate(s);
	}
		


}
