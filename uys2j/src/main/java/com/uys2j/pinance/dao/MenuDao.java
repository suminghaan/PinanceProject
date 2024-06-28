package com.uys2j.pinance.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uys2j.pinance.dto.MenuDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class MenuDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public List<MenuDto> selectMenu() {
		return sqlSessionTemplate.selectList("menuMapper.selectMenu");
	}

	public int updateMenu(String[] menuNo) {
		return sqlSessionTemplate.update("menuMapper.updateMenu", menuNo);
	}

	public int updateMenuAll() {
		return sqlSessionTemplate.update("menuMapper.updateMenuAll");
	}
}
