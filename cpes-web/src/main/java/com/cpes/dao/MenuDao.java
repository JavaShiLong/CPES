package com.cpes.dao;

import java.util.List;

import com.cpes.beans.Menu;

public interface MenuDao {
	
	public List<Menu> queryParentMenu();
	
	public List<Menu> queryChildMenu(Integer id);

}
