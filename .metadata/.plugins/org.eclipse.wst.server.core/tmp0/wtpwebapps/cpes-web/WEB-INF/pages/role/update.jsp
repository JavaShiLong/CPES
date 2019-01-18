<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
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
	<link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
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
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form id="updateForm" action="${APP_PATH}/role/update.do" method="post" role="form">
				  <input type="hidden" name="id" value="${role.id}">
				  
				  <div class="form-group">
					<label for="exampleInputEmail1">角色名称</label>
					<input type="email" class="form-control" id="fname" name="name" value="${role.name }" placeholder="请输入角色名称">
				  </div>
				
				
				  <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
				  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/jquery/jquery-form.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
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
			    
			    
			    $("#resetBtn").click(function(){
			    	$("#updateForm")[0].reset();
			    });
			    
			    
			    $("#updateBtn").click(function(){
			    	var name = $("#fname").val();
					if (name == "") {
						layer.msg("角色名不能为空", {time : 1000,icon : 5,shift : 6}, function() {
							$("#fname").focus();
						});
						return;
					}
					
					var loadingIndex = 0;
					
					//form 插件提交，终于不用一个一个封装数据了
					$("#updateForm").ajaxSubmit({
						beforeSubmit :function(){
							loadingIndex = layer.msg("请求处理中", {icon : 16});
						},
						success : function(result){
							layer.close(loadingIndex);
							if(result.success){
								window.location.href = "${APP_PATH}/role/index.htm";
							}else{
								layer.msg("角色修改失败", {time : 1000,icon : 5,shift : 6});
							}
						}
					});
			    	
			    });
            });
            
        </script>
  </body>
</html>
