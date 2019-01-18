				<ul style="padding-left:0px;" class="list-group">
				    <#list menus as menu>
				        <#if menu.children?size == 0>
							<li class="list-group-item tree-closed" >
								<a style="color:#000000;" href="${APP_PATH}${menu.url}"><i class="fa fa-fw ${menu.icon}"></i> ${menu.name}</a> 
							</li>
						<#else>
							<li class="list-group-item tree-closed">
								<span><i class="fa fa-fw ${menu.icon}"></i> ${menu.name} <span class="badge" style="float:right">${menu.children?size}</span></span> 
								<ul style="margin-top:10px;display:none;">
									<#list menu.children as childMenu>
										<li style="height:30px;">
											<a style="color:#000000;" href="${APP_PATH}${childMenu.url}"><i class="fa fa-fw ${childMenu.icon}"></i> ${childMenu.name} </a>
										</li>
									</#list>
								</ul>
							</li>
				        </#if>
				    </#list>
				</ul>