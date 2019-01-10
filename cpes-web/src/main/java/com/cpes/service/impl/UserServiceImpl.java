package com.cpes.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cpes.beans.Datas;
import com.cpes.beans.Page;
import com.cpes.beans.User;
import com.cpes.dao.UserDao;
import com.cpes.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDao userDao;

	@Override
	public User queryUserById(Integer id) {
		return userDao.queryUserById(id);
	}

	@Override
	public User queryUser(User user) {
		return userDao.queryUser(user);
	}

	@Override
	public List<User> queryUserByLimit(Integer pageNo, Integer pageSize) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("pageNo", (pageNo - 1) * pageSize);
		map.put("pageSize", pageSize);
		return userDao.queryUserByLimit(map);
	}

	@Override
	public List<User> queryUser4Page(Map<String, Object> map) {
		return userDao.queryUser4Page(map);
	}

	@Override
	public int insertUser(Map<String, Object> map) {
		return userDao.insertUser(map);
	}

	@Override
	public Page<User> queryUserPage(Map<String, Object> paramMap) {
		
		Page page = new Page();
		
		List<User> datas = userDao.queryUser4Page(paramMap);
		int totalSize = userDao.queryUserCount();
		page.setDatas(datas);
		page.setTotalSize(totalSize);
		
		return page;
	}

	@Override
	public int updateUser(Map<String, Object> paramMap) {
		return userDao.updateUser(paramMap);
	}

	@Override
	public int deleteUser(Map<String, Object> paramMap) {
		return userDao.deleteUser(paramMap);
	}

	@Override
	public int deleteUsers(Datas ids) {
		return userDao.deleteUsers(ids);
	}

}
