package com.uys2j.pinance.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.AttachDto;
import com.uys2j.pinance.dto.FacDto;
import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.ScheduleDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class FacDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 시설 추가
	public int facInsert(FacDto f) {
		return sqlSessionTemplate.insert("facMapper.facInsert", f);
	}
	
	public int attachInsert(AttachDto attach) {
		return sqlSessionTemplate.insert("facMapper.attachInsert", attach);
	}
	
	// 시설 삭제
	public int facDelete(FacDto f) {
		return sqlSessionTemplate.update("facMapper.facDelete", f);
	}
	
	public FacDto facUpdatePage(int facNo) {
		return sqlSessionTemplate.selectOne("facMapper.facUpdatePage", facNo);
	}
	
	public List<FacDto> facSelect(){
		return sqlSessionTemplate.selectList("facMapper.facSelect");
	}
	
	public int faclistInsert(ScheduleDto s) {
		return sqlSessionTemplate.insert("facMapper.faclistInsert", s);
	}
	
	public List<ScheduleDto> scSelect(){
		return sqlSessionTemplate.selectList("facMapper.scSelect");
	}
	
	public List<ScheduleDto> getReservationsByDate(Map<String, Object> map) {
	   
	    return sqlSessionTemplate.selectList("facMapper.getReservationsByDate", map);
	}
	
	public int faclistDelete(ScheduleDto s) {
		return sqlSessionTemplate.update("facMapper.faclistDelete", s);
	}

	public int faclistUpdate(ScheduleDto s) {
		return sqlSessionTemplate.update("facMapper.faclistUpdate", s);
	}


}
