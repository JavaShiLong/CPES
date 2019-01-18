package ${packageName}.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ${packageName}.bean.Datas;
import ${packageName}.bean.Page;
import ${packageName}.bean.${className};
import ${packageName}.common.BaseController;
import ${packageName}.service.${className}Service;

@Controller
@RequestMapping("/${className?lower_case}")
public class ${className}Controller extends BaseController {

	@Autowired
	private ${className}Service ${className?lower_case}Service;
	
	@RequestMapping("/index")
	public String index() {
		return "${className?lower_case}/index";
	}
	
	@RequestMapping("/add")
	public String add() {
		return "${className?lower_case}/add";
	}
	
	@RequestMapping("/edit/{id}")
	public String edit( @PathVariable("id")Integer id, Model model ) {
		${className} ${className?lower_case} = ${className?lower_case}Service.queryById(id);
		model.addAttribute("${className?lower_case}", ${className?lower_case});
		return "${className?lower_case}/edit";
	}
	
	@ResponseBody
	@RequestMapping("/delete${className}s")
	public Object delete${className}s( Datas ds ) {
		start();
		
		try {
			int cnt = ${className?lower_case}Service.delete${className}s(ds);
			success(cnt == ds.getIds().size());
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/delete${className}")
	public Object delete${className}( ${className} ${className?lower_case} ) {
		start();
		
		try {
			int cnt = ${className?lower_case}Service.delete${className}(${className?lower_case});
			success(cnt == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/update${className}")
	public Object update${className}( ${className} ${className?lower_case} ) {
		start();
		
		try {
			int cnt = ${className?lower_case}Service.update${className}(${className?lower_case});
			success(cnt == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/insert${className}")
	public Object insert${className}( ${className} ${className?lower_case} ) {
		start();
		
		try {
			int cnt = ${className?lower_case}Service.insert${className}(${className?lower_case});
			success(cnt == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
	
	@ResponseBody
	@RequestMapping("/pageQuery")
	public Object pageQuery( Integer pageno, Integer pagesize, String querytext ) {
		start();
		
		try {
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("start", (pageno-1)*pagesize);
			paramMap.put("size", pagesize);
			paramMap.put("querytext", querytext);
			
			Page<${className}> ${className?lower_case}Page = ${className?lower_case}Service.query${className}Page(paramMap);
			param("page", ${className?lower_case}Page);
			success(true);
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		
		return end();
	}
}
