package com.cpes.common;

import java.util.HashMap;
import java.util.Map;

public class BaseController {
	
	private ThreadLocal<Map<String, Object>> threadMap = new ThreadLocal();
	Map<String, Object> resultMap = new HashMap<String, Object>();
	
	protected void start(){
		threadMap.set(resultMap);
	}
	
	protected void success(boolean flag){
		threadMap.get().put("success", flag);
	}
	
	protected void param(String key,Object value){
		threadMap.get().put(key, value);
	}
	
	protected Map<String, Object> end(){
		
		return threadMap.get();
	}

}
