package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.MemberDto;
import com.uys2j.pinance.dto.PowerDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PowerDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int insertPower(PowerDto p) {
		return sqlSessionTemplate.insert("powerMapper.insertPower", p);
	}

	public List<PowerDto> selectPowerName() {
		return sqlSessionTemplate.selectList("powerMapper.selectPowerName");
	}
}
