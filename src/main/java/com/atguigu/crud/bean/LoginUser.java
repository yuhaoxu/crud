package com.atguigu.crud.bean;

import javax.validation.constraints.Pattern;

public class LoginUser {
	private int id;

	@Pattern(regexp="^[a-zA-Z0-9_-]{3,10}$",message="用户名可以是3-10位英文字母和数字的组合")
	private String username;
	private String password;

	@Pattern(regexp="^[a-z0-9_-]{3,13}$",message="密码必须是3-13位小写英文和数字的组合")
	public LoginUser(int id, String username, String password) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
	}
	public LoginUser() {
		super();

	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "LoginUser [id=" + id + ", username=" + username + ", password=" + password + "]";
	}

}
