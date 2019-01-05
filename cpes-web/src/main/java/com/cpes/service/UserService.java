package com.cpes.service;

import java.util.List;

import com.cpes.beans.User;

public interface UserService {

	public User queryUserById(Integer id);
	
	public User queryUser(User user);

	public List<User> queryUserByLimit(Integer pageNo, Integer pageSize);
}
