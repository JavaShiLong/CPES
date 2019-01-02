package com.cpes.web.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

public class ServerStartUpListener extends ContextLoaderListener {

	@Override
	public void contextInitialized(ServletContextEvent event) {
		
		ServletContext application = event.getServletContext();
		
		String path = application.getContextPath();
		
		application.setAttribute("APP_PATH", path);
		
		super.contextInitialized(event);
	}

	
}
