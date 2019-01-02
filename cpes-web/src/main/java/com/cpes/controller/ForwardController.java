package com.cpes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cpes.beans.User;
import com.cpes.service.UserService;

@Controller
public class ForwardController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/index")
	public String index(){
		User user = userService.queryUserById(1);
		return "index";
	}

}
