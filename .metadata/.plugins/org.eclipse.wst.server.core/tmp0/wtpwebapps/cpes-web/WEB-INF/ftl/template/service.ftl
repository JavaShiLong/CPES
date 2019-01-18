package ${packageName}.service;

import java.util.List;
import java.util.Map;

import ${packageName}.bean.Datas;
import ${packageName}.bean.Page;
import ${packageName}.bean.${className};

/**
 *  @author ${author}
 */
public interface ${className}Service {
	Page<${className}> query${className}Page(Map<String, Object> paramMap);

	int insert${className}(${className} ${className?lower_case});

	${className} queryById(Integer id);

	int update${className}(${className} ${className?lower_case});

	int delete${className}(${className} ${className?lower_case});

	int delete${className}s(Datas ds);

	List<${className}> queryAll();
}