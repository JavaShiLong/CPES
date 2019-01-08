<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	<link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><img src="${APP_PATH}/img/logo.png" width="100" style="float:left;margin-top:5px;"><a class="navbar-brand" style="font-size:32px;" href="#">认证流程审批系统</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <%@include file="/WEB-INF/pages/common/userinfo.jsp" %>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
			    <%@include file="/WEB-INF/pages/common/menu.jsp" %>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteUsers()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/user/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="usertable" class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"  id="bossBtn"></th>
                  <th>用户账号</th>
                  <th>用户名称</th>
                  <th>用户邮箱</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
	      
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
					
						<div id="Pagination" class="pagination">
				
						</div>
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
	<script src="${APP_PATH }/layer/layer.js"></script>
        <script type="text/javascript">
            $(function () {
            	
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
				    pageQuery(0);
            });
            
   
     
            
            $("#queryBtn").click(function(){
            	var querytext = $("#queryText");
            	if ( querytext.val() == "" ) {
            		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
            			querytext.focus();
            		});
            	} else {
            		pageQuery(0);
            	}
            });
            
    	    var loadingIndex = 0;
		    var pageSize = 10;
            
            function pageQuery( pageIndex ){
            	
            	var dataObj = {"pageNo" : pageIndex+1,"pageSize" : pageSize};
            	var querytext = $("#queryText");
            	if ( querytext.val() != "" ) {
            		dataObj["queryText"] = querytext.val();
            	}
            	
		    	$.ajax({
		    		url : "${APP_PATH}/user/pageQuery.do",
		    		type : "POST",
		    		data : dataObj,
		    		beforeSend : function() {
						loadingIndex = layer.msg("请求处理中", {icon : 16});
					},
		    		success : function( result ){
		    			layer.close(loadingIndex);
		    			if(result.success){
		    				// 页面渲染
            				var pageObj = result.page;
            				// 循环遍历
            				var content = "";
            				$.each(pageObj.datas, function(index, user){
		            				content += '<tr>';
		      		                content += '  <td>'+(index+1)+'</td>';
		      						content += '  <td><input type="checkbox" value=\''+user.id+'\'></td>';
		      		                content += '  <td>'+user.loginacct+'</td>';
		      		                content += '  <td>'+user.username+'</td>';
		      		                content += '  <td>'+user.email+'</td>';
		      		                content += '  <td>';
		      						content += '      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-search"></i></button>';
		      						content += '      <button type="button" onclick="window.location.href=\'${APP_PATH}/user/update/'+user.id+'.htm\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
		      						content += '	  <button type="button" onclick="deleteUser('+user.id+',\''+user.username+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
		      						content += '  </td>';
		      		                content += '</tr>';
            				});
		    				
		    				$("#usertable tbody").html(content);
		    				
		    				$("#Pagination").pagination(pageObj.totalSize, {
		    				    num_edge_entries: 1, //边缘页数
		    				    num_display_entries: 3, //主体页数
		    				    current_page: pageIndex,// 当前页码索引
		    				    callback: pageQuery,// 分页查询方法，传递参数为页码索引
		    				    prev_text:"上一页",
		    				    next_text:"下一页",
		    				    items_per_page:pageSize //每页显示数据条数
		    				});

            				
		    			}else{
		    				layer.msg("查询失败", {time : 1000,icon : 5,shift : 6});
		    			}
		    		}
		    		
		    	});
		    	
		    };
		    
	 		function deleteUser(id , username){
    			layer.confirm("确定删除"+username+"吗？",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "${APP_PATH}/user/deleteUser.do",
    					type : "POST",
    					data : {id : id},
    					beforeSend : function(){
    						loadingIndex = layer.msg("请求处理中", {icon : 16});
    					},
    					success : function(result){
    						layer.close(loadingIndex);
    						if(result.success){
    							pageQuery(0);
    							layer.msg("用户已删除", {time : 1000,icon : 6,shift : 6});
    						}else{
    							layer.msg("删除用户失败", {time : 1000,icon : 5,shift : 6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
    		};
    		
    		$("#bossBtn").click(function(){
    			var checkFlag = this.checked;
    			$("#usertable tbody :checkbox").each(function(index,checkbox){
    				checkbox.checked = checkFlag;
    			});
    		});
    		
    		function deleteUsers(){
    			var len = $("#usertable tbody :checked").length;
    			
    			if(len == 0){
    				layer.msg("请选择删除用户", {time : 1000,icon : 5,shift : 6});
    				return;
    			}
    			var dataObj = {};
    			
    			$("#usertable tbody :checked").each(function(index,checkbox){
    				dataObj["ids["+index+"]"] = checkbox.value;
    			});
    			
    			$.ajax({
    				url :"${APP_PATH}/user/deleteUsers.do",
    				type : "POST",
    				data : dataObj,
    				beforeSend : function(){
    					loadingIndex = layer.msg("请求处理中", {icon : 16});
    				},
    				success : function(result){
    					if(result.success){
    						pageQuery(0);
							layer.msg("删除成功", {time : 1000,icon : 6,shift : 6});
    					}else{
    						layer.msg("删除失败", {time : 1000,icon : 5,shift : 6});
    					}
    				}
    			});
    		};
    		
        </script>
  </body>
</html>
