package com.cpes.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cpes.beans.Datas;
import com.cpes.beans.Page;
import com.cpes.beans.Role;
import com.cpes.beans.User;
import com.cpes.common.BaseController;
import com.cpes.service.UserService;
import com.cpes.utils.DesUtil;
import com.cpes.utils.MD5Util;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{
	
	@Autowired
	UserService userService;
	
	@ResponseBody
	@RequestMapping("/deleteAssign")
	public Object deleteAssign(Integer userid,Datas ids){
		
		start();
		
		try {
			Map<String , Object> paramMap = new HashMap<String , Object>();
			paramMap.put("userid", userid);
			paramMap.put("ids", ids.getIds());
			
			userService.deleteUserRoles(paramMap);
			
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/insertAssign")
	public Object insertAssign(Integer userid,Datas ids){
		
		start();
		
		try {
			
			userService.insertUserRoles(userid,ids);
			
			success(true);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
	
	
	@ResponseBody
	@RequestMapping("/deleteUsers")
	public Object deleteUsers(Datas ids){
		
	   start();
		try {
			int count = userService.deleteUsers(ids);
			success(count == ids.getIds().size());
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/deleteUser")
	public Object deleteUser(Integer id){
	   start();
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id);
			int count = userService.deleteUser(paramMap);
			success(count == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public Object updateUser(User user){
	    
		start();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("loginacct", user.getLoginacct());
			paramMap.put("username", user.getUsername());
			paramMap.put("email", user.getEmail());
			paramMap.put("id", user.getId());
			
			int count = userService.updateUser(paramMap);
			
			success(count == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
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
		
	    start();
		
		try {
			// 分页查询
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("pageNo", (pageNo-1)*pageSize);
			paramMap.put("pageSize", pageSize);
			paramMap.put("queryText", queryText);
			
			Page<User> page = userService.queryUserPage(paramMap);
			param("page", page);
			success(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/insertUser")
	public Object insertUser(User user){
		
		start();
		Map<String ,Object> paramMap = new HashMap<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			paramMap.put("loginacct", user.getLoginacct());
			paramMap.put("username", user.getUsername());
			paramMap.put("email", user.getEmail());
			paramMap.put("creatTime", sdf.format(new Date()));
			paramMap.put("password", MD5Util.digest(DesUtil.encrypt(user.getPassword())));
			
			int count = userService.insertUser(paramMap);
			
			success(count == 1);
		} catch (Exception e) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@RequestMapping("/add")
	public String gotoAdd(){
		return "user/add";
	}
	
	@RequestMapping("/assign/{id}")
	public String gotoAssign(@PathVariable("id")Integer id,Model model){
		
		List<Role> roleList = userService.queryAllRoles();
		
		List<Integer> userRoleIds = userService.queryUserRolesById(id);
		
		List<Role> unassignList = new ArrayList<Role>();
		
		List<Role> assignList = new ArrayList<Role>();
		
		for (Role role : roleList) {
			if(userRoleIds.contains(role.getId())){
				assignList.add(role);
				continue;
			}
			unassignList.add(role);
		}
		
		model.addAttribute("assignList", assignList);
		model.addAttribute("unassignList", unassignList);
		
		return "user/assign";
	}
	
	@RequestMapping("/index")
	public String index(){

		return "user/index";
	}


}
