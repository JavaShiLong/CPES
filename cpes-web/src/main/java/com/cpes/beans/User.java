package com.cpes.beans;

public class User {

	private int id;
	private String loginacct;
	private String password;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getLoginacct() {
		return loginacct;
	}

	public void setLoginacct(String loginacct) {
		this.loginacct = loginacct;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(int id, String loginacct, String password) {
		super();
		this.id = id;
		this.loginacct = loginacct;
		this.password = password;
	}

}
