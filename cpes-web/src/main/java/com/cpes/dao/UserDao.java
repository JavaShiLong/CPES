package com.cpes.dao;

import org.springframework.stereotype.Repository;

import com.cpes.beans.User;

@Repository
public interface UserDao {

	public User queryUser(User user);
}
