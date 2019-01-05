package com.cpes.dao;

import java.util.List;
import java.util.Map;

import com.cpes.beans.User;

public interface UserDao {

	public User queryUser(User user);

	public List<User> queryUserByLimit(Map<String, Integer> map);
}
