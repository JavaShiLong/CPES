package com.cpes.beans;

public class User {

	private Integer id;
	private String loginacct;
	private String password;
	private String username;
	private String email;
	private String creatTime;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}



	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
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
	}


}
