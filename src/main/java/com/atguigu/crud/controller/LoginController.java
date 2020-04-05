package com.atguigu.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import com.atguigu.crud.bean.LoginUser;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;


	@RequestMapping("/login")
	public String toLogin() {
		return "login";
	}

	@ResponseBody
	@RequestMapping("/checkLogin")
	public Msg CheckLogin(LoginUser loginUser, HttpSession session) {
		System.out.println("获取到的数据"+ loginUser);
		session.setAttribute("username",loginUser.getUsername());
		LoginUser user=loginService.checkLogin(loginUser);
		System.out.println(user);

		if(user.getPassword().equals(loginUser.getPassword())) {
			return Msg.success();
		}
		else {
			return Msg.fail();
		}

	}
	@RequestMapping("/list")
	public String toList() {
		return "list1";
	}

	@RequestMapping("/register")
	public String toRegister() {
		return "register";
	}

	@ResponseBody
	@RequestMapping("/checkregister")
	public Msg register(@Valid LoginUser loginUser,BindingResult result) {

		System.out.println(loginUser);
		if(result.hasErrors()) {
			//校验失败，应该返回失败,在模态框中显示校验失败的错误信息
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名:"+fieldError.getField());
				System.out.println("错误的信息: "+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields",map);
		}else {
			loginService.register(loginUser);
			return Msg.success();
		}

	}


	/**
	 * 检查用户名是否可用
	 * @param username
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkusername")
	public Msg checkusename(@RequestParam("username")String username) {
		//先判断用户名是否是合法的表达式;
		String regx="^[a-zA-Z0-9_-]{3,10}$";
		if(!username.matches(regx)){
			return Msg.fail().add("va_msg","用户名可以是3-10位英文字母和数字的组合");
		}
		//数据库用户名重复校验
		boolean b=loginService.checkUser(username);
		if(b) {
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg","用户名已存在");
		}
	}

}
