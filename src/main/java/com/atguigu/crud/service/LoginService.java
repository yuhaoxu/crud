package com.atguigu.crud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.LoginUser;
import com.atguigu.crud.dao.LoginMapper;

@Service
public class LoginService {
   
	@Autowired
	LoginMapper loginMapper;
	
	public LoginUser checkLogin(LoginUser loginUser) {
	     
		return loginMapper.checkLogin(loginUser);
	}

	public void register(LoginUser loginUser) {
		 loginMapper.register(loginUser);
		}

	public boolean checkUser(String username) {
		LoginUser loginUser = loginMapper.checkUsername(username);
		if(loginUser==null) {
			return true;
		}
		else {
			return false;
		}
	}

}
