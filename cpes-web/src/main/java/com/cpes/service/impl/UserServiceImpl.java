package com.cpes.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cpes.beans.User;
import com.cpes.dao.UserDao;
import com.cpes.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDao userDao;

	@Override
	public User queryUserById(Integer id) {
		return new User();
	}

	@Override
	public User queryUser(User user) {
		return userDao.queryUser(user);
	}

}
