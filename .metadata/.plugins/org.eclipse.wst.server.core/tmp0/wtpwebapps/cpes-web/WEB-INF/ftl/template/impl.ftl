package ${packageName}.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${packageName}.bean.Datas;
import ${packageName}.bean.Page;
import ${packageName}.bean.${className};
import ${packageName}.dao.${className}Dao;
import ${packageName}.service.${className}Service;

/**
 *  @author ${author}
 */
@Service
public class ${className}ServiceImpl implements ${className}Service {

	@Autowired
	private ${className}Dao ${className?lower_case}Dao;

	public Page<${className}> query${className}Page(Map<String, Object> paramMap) {
		Page<${className}> ${className?lower_case}Page = new Page<${className}>();
		
		List<${className}> ${className?lower_case}s = ${className?lower_case}Dao.query${className}Data(paramMap);
		int count = ${className?lower_case}Dao.query${className}Count(paramMap);
		
		${className?lower_case}Page.setDatas(${className?lower_case}s);
		${className?lower_case}Page.setTotalsize(count);
		
		return ${className?lower_case}Page;
	}

	public int insert${className}(${className} ${className?lower_case}) {
		return ${className?lower_case}Dao.insert${className}(${className?lower_case});
	}

	public ${className} queryById(Integer id) {
		return ${className?lower_case}Dao.queryById(id);
	}

	public int update${className}(${className} ${className?lower_case}) {
		return ${className?lower_case}Dao.update${className}(${className?lower_case});
	}

	public int delete${className}(${className} ${className?lower_case}) {
		return ${className?lower_case}Dao.delete${className}(${className?lower_case});
	}

	public int delete${className}s(Datas ds) {
		return ${className?lower_case}Dao.delete${className}s(ds);
	}

	public List<${className}> queryAll() {
		return ${className?lower_case}Dao.queryAll();
	}
}