package com.uys2j.pinance.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uys2j.pinance.dao.MenuDao;
import com.uys2j.pinance.dto.MenuDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MenuServiceImpl implements MenuService {

	private final MenuDao menuDao;

	@Override
	public List<MenuDto> selectMenu() {
		return menuDao.selectMenu();
	}

	@Override
	public int updateMenu(String[] menuNo) {
		return menuDao.updateMenu(menuNo);
	}

	@Override
	public int updateMenuAll() {
		return menuDao.updateMenuAll();
	}
}
