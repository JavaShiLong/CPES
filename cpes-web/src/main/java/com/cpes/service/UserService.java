package com.cpes.service;

import com.cpes.beans.User;

public interface UserService {

	public User queryUserById(Integer id);
	
	public User queryUser(User user);
}
