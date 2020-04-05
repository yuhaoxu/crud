package com.atguigu.crud.dao;

import com.atguigu.crud.bean.LoginUser;

public interface LoginMapper {

	LoginUser checkLogin(LoginUser loginUser);


	void register(LoginUser loginUser);


	LoginUser checkUsername(String username);

     


}
