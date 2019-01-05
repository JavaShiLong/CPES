package com.cpes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cpes.beans.User;
import com.cpes.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping("/index")
	public String index(@RequestParam(required=false,defaultValue="1")Integer pageNo,
			                       @RequestParam(required=false,defaultValue="10")Integer pageSize,
			                       Model model){
		
		List<User> users = userService.queryUserByLimit(pageNo,pageSize);
		model.addAttribute("users", users);
		
		return "user/index";
	}


}
