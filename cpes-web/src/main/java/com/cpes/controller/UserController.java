package com.cpes.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cpes.beans.User;
import com.cpes.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping("/login")
	public String login(User user,HttpSession session){
		
		User queryUser = userService.queryUser(user);
		
		if(queryUser == null){
			session.setAttribute("errorMsg", "您的用户名或密码有误");
			return "redirect:/";
		}
		
		return "main";
	}
}
