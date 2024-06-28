package com.uys2j.pinance.service;

import java.util.List;

import com.uys2j.pinance.dto.MenuDto;

public interface MenuService {

	//모든 메뉴 리스트 호출(메뉴는 우리가 고정시킬거임)
	List<MenuDto> selectMenu();
	
	//즐겨찾기 업데이트하기
	int updateMenu(String[] menuNo);

	int updateMenuAll();
}
