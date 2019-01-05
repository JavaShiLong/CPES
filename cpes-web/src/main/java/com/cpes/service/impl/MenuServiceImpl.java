package com.cpes.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cpes.beans.Menu;
import com.cpes.dao.MenuDao;
import com.cpes.service.MenuService;

@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	MenuDao menuDao;

	@Override
	public List<Menu> queryParentMenu() {
		return menuDao.queryParentMenu();
	}

	@Override
	public List<Menu> queryChildMenu(Integer id) {
		return menuDao.queryChildMenu(id);
	}

	@Override
	public List<Menu> queryAll() {
		return menuDao.queryAll();
	}

}
