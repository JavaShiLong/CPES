package com.cpes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cpes.beans.Member;
import com.cpes.beans.Menu;
import com.cpes.beans.Permission;
import com.cpes.beans.User;
import com.cpes.common.BaseController;
import com.cpes.service.MemberService;
import com.cpes.service.MenuService;
import com.cpes.service.PermissionService;
import com.cpes.service.UserService;
import com.cpes.utils.DesUtil;
import com.cpes.utils.MD5Util;

@Controller
public class ForwardController extends BaseController{
	
	@Autowired
	UserService userService;
	
	@Autowired
	MenuService menuService;
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	MemberService  memberService ;

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
	
	@ResponseBody
	@RequestMapping("/memberLogin")
	public Object memberLogin(Member member, HttpSession session) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			String desPwd = DesUtil.encrypt(member.getPassword());
			String password = MD5Util.digest(desPwd);
			member.setPassword(password);
			Member queryMember = memberService.queryMember(member);
			
			if (queryMember == null) {
				map.put("success", false);
				map.put("error", "账户不存在");
			}else{
				map.put("success", true);
				session.setAttribute("member", queryMember);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
		}
		return map;
		
	}
	
	

	@RequestMapping("/loadMenu")
	public String loadMenu(HttpSession session) {
		
		
		Map<Integer,Permission> menuMap = new HashMap<>();
		List<Permission> rootMenu = new ArrayList<>();
		Permission root = new Permission();
		User user = (User) session.getAttribute("user");
		List<Permission> menus = permissionService.queryUserPermissions(user.getId());
		
		for (Permission menu : menus) {
			menuMap.put(menu.getId(), menu);
		}
			
		for (Permission menu : menus) {
			
			if(menu.getPid() == 0){
				continue;
			}
			
			if(menu.getPid() == 1){
				rootMenu.add(menu);
				continue;
			}
			menuMap.get(menu.getPid()).getChildren().add(menu);
		}

		session.setAttribute("menus", rootMenu);
		return "main";
	}
	
	@RequestMapping("/login")
	public String login(HttpSession session) {
		
		/*	 Menu V1  
	    List<Menu> parentMenus = menuService.queryParentMenu();
		for (Menu parentMenu : parentMenus) {
			List<Menu> childMenu = menuService.queryChildMenu(parentMenu.getId());
			parentMenu.setChildMenu(childMenu);
		}
		 */
		
		/* Menu V2  
	    Menu menu = new Menu();
		menu.setId(0);
		queryMenu(menu);
		model.addAttribute("menus", menu.getChildMenu());
		 */
		
		Map<Integer,Menu> menuMap = new HashMap<>();
		List<Menu> rootMenu = new ArrayList<>();
		List<Menu> menus = menuService.queryAll();
		
		for (Menu menu : menus) {
			menuMap.put(menu.getId(), menu);
		}
		
		for (Menu menu : menus) {
			if(menu.getPid() == 0){
				rootMenu.add(menu);
				continue;
			}
			menuMap.get(menu.getPid()).getChildren().add(menu);
		}
		
		session.setAttribute("menus", rootMenu);
		return "main";
	}
	
	@ResponseBody
	@RequestMapping("/ztree")
	public Object tree(){
		
	
			Map<Integer,Permission> menuMap = new HashMap<>();
			List<Permission> rootMenu = new ArrayList<>();
			List<Permission> menus = permissionService.queryAll();
			
			for (Permission menu : menus) {
				menuMap.put(menu.getId(), menu);
			}
				
			for (Permission menu : menus) {
				if(menu.getPid() == 0){
					rootMenu.add(menu);
					continue;
				}
				menuMap.get(menu.getPid()).getChildren().add(menu);
			}
			
		
		return rootMenu;
	}
	@ResponseBody
	@RequestMapping("/load/{roleid}")
	public Object load(@PathVariable("roleid") Integer roleid){
		
		
		Map<Integer,Permission> menuMap = new HashMap<>();
		List<Permission> rootMenu = new ArrayList<>();
		List<Permission> menus = permissionService.queryAll();
		List<Integer> permissions = permissionService.queryRolePermissionId(roleid);
		
		for (Permission menu : menus) {
			menuMap.put(menu.getId(), menu);
			if(permissions.contains(menu.getId())){
				menu.setChecked(true);
			}
		}
		
		for (Permission menu : menus) {
			if(menu.getPid() == 0){
				rootMenu.add(menu);
				continue;
			}
			menuMap.get(menu.getPid()).getChildren().add(menu);
		}
		
		
		return rootMenu;
	}
	
	/**
	 * 递归菜单 用来处理 多级菜单的逻辑
	 * @param parentMenu
	 */
	@SuppressWarnings("unused")
	private void queryMenu(Menu parentMenu){
		
		List<Menu> childMenu = menuService.queryChildMenu(parentMenu.getId());
		for (Menu menu : childMenu) {
			queryMenu(menu);
		}
		parentMenu.setChildren(childMenu);
	}
	
	@RequestMapping("/index")
	public String index(){
		return "index";
	}
	
	

}
