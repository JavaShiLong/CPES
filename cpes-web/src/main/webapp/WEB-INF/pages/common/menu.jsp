<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul style="padding-left:0px;" class="list-group">
					<c:forEach items="${menus }" var="menu">
						<c:if test="${empty menu.childMenu }">
							<li class="list-group-item tree-closed" >
								<a href="${APP_PATH}${menu.url }"><i class="glyphicon glyphicon-home"></i> ${menu.name }</a> 
							</li>
					    </c:if>
					    <c:if test="${not empty menu.childMenu }">
					    	<li class="list-group-item tree-closed">
							<span><i class="glyphicon glyphicon glyphicon-tasks"></i> ${menu.name } <span class="badge" style="float:right">${fn:length(menu.childMenu)}</span></span> 
							<ul style="margin-top:10px;display:none;">
								<c:forEach items="${menu.childMenu }" var="childMenu">
									<li style="height:30px;">
									<a href="${APP_PATH}${childMenu.url }"><i class="glyphicon glyphicon-minus-sign"></i>${childMenu.name }</a> 
									</li>
								</c:forEach>
							</ul>
						</li>
					    </c:if>
					</c:forEach>
				</ul>