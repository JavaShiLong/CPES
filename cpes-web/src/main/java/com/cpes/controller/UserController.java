package com.cpes.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cpes.beans.Menu;
import com.cpes.beans.User;
import com.cpes.service.MenuService;
import com.cpes.service.UserService;
import com.cpes.utils.DesUtil;
import com.cpes.utils.MD5Util;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@Autowired
	MenuService menuService;

	@ResponseBody
	@RequestMapping("/doLogin")
	public Object doLogin(User user, HttpSession session) {

		Map<String, Object> map = new HashMap<>();

		try {
			String desPwd = DesUtil.encrypt(user.getPassword());
			String password = MD5Util.digest(desPwd);
			user.setPassword(password);
			User queryUser = userService.queryUser(user);

			if (queryUser == null) {
				map.put("success", false);
				map.put("error", "账户不存在");
			}else{
				map.put("success", true);
				session.setAttribute("user", queryUser);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
		}
		return map;

	}

	@RequestMapping("/login")
	public String login(Model model) {
		
		List<Menu> parentMenus = menuService.queryParentMenu();
		for (Menu parentMenu : parentMenus) {
			List<Menu> childMenu = menuService.queryChildMenu(parentMenu.getId());
			parentMenu.setChildMenu(childMenu);
		}
		
		model.addAttribute("menus", parentMenus);

		return "main";
	}
}
