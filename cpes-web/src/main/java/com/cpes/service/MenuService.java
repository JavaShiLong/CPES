package com.cpes.service;

import java.util.List;

import com.cpes.beans.Menu;

public interface MenuService {

	public List<Menu> queryParentMenu();

	public List<Menu> queryChildMenu(Integer id);

	public List<Menu> queryAll();

}
