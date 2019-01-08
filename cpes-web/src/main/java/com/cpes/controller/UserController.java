package com.cpes.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cpes.beans.Datas;
import com.cpes.beans.Page;
import com.cpes.beans.User;
import com.cpes.service.UserService;
import com.cpes.utils.DesUtil;
import com.cpes.utils.MD5Util;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	
	@ResponseBody
	@RequestMapping("/deleteUsers")
	public Object deleteUsers(Datas ids){
		
		
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = userService.deleteUsers(ids);
			resultMap.put("success", count == ids.getIds().size());
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;

	}
	
	@ResponseBody
	@RequestMapping("/deleteUser")
	public Object deleteUser(Integer id){
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id);
			int count = userService.deleteUser(paramMap);
			resultMap.put("success", count == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public Object updateUser(User user){
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("loginacct", user.getLoginacct());
			paramMap.put("username", user.getUsername());
			paramMap.put("email", user.getEmail());
			paramMap.put("id", user.getId());
			
			int count = userService.updateUser(paramMap);
			
			resultMap.put("success", count == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@RequestMapping("/update/{id}")
	public String update(@PathVariable("id")Integer id,Model model){
		
		User user = userService.queryUserById(id);
		model.addAttribute("Cuser", user);
		
		return "user/update";
	}
	
	@ResponseBody
	@RequestMapping("/pageQuery")
	public Object queryPage(String queryText,Integer pageNo,Integer pageSize){
		
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			// 分页查询
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("pageNo", (pageNo-1)*pageSize);
			paramMap.put("pageSize", pageSize);
			paramMap.put("queryText", queryText);
			
			Page<User> page = userService.queryUserPage(paramMap);
			resultMap.put("page", page);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/insertUser")
	public Object insertUser(User user){
		
		Map<String ,Object> map = new HashMap<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			map.put("loginacct", user.getLoginacct());
			map.put("username", user.getUsername());
			map.put("email", user.getEmail());
			map.put("creatTime", sdf.format(new Date()));
			map.put("password", MD5Util.digest(DesUtil.encrypt(user.getPassword())));
			userService.insertUser(map);
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
		}
		
		return map;
	}
	
	@RequestMapping("/add")
	public String gotoAdd(){
		return "user/add";
	}
	
	@RequestMapping("/index")
	public String index(){
	/*	
		List<User> users = userService.queryUserByLimit(pageNo,pageSize);
		model.addAttribute("users", users);*/
		
		return "user/index";
	}


}
