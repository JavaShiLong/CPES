package com.cpes.service;

import java.util.List;
import java.util.Map;

import com.cpes.beans.Page;
import com.cpes.beans.User;

public interface UserService {

	public User queryUserById(Integer id);
	
	public User queryUser(User user);

	public List<User> queryUserByLimit(Integer pageNo, Integer pageSize);

	public List<User> queryUser4Page(Map<String, Object> map);

	public void insertUser(Map<String, Object> map);

	public Page<User> queryUserPage(Map<String, Object> paramMap);
}
