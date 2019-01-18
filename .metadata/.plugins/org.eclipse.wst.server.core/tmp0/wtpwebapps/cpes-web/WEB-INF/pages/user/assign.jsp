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
	
	#operationBtns li {
	    list-style-type: none;
	    margin-right:40px;
	    /*
		padding: 10px;
    	background: #F00;
    	color:#FFF;
    	margin-bottom:20px;
    	
    	border-radius: 3px;
    	*/
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
				  <li><a href="${APP_PATH}/login.do">首页</a></li>
				  <li><a href="${APP_PATH}/login.do">数据列表</a></li>
				  <li class="active">赋予或删除角色信息</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
						<form class="form-inline">
				  <div class="form-group">
				      <select id="leftDataList" multiple="multiple" size="10" style="width:150px;overflow-y: auto;" class="form-control">
				          <c:forEach items="${unassignList}" var="role">
				          <option value="${role.id}">${role.name}</option>
				          </c:forEach>
				      </select>
				  </div>
				  <div class="form-group">
				      <ul id="operationBtns">
				          <li id="left2rightBtn" class="btn btn-default"><i class="glyphicon glyphicon-arrow-right"></i></li>
				          <br><br>
				          <li id="right2leftBtn" class="btn btn-default"><i class="glyphicon glyphicon-arrow-left"></i></li>
				      </ul>
				  </div>
				  <div class="form-group">
				      <select id="rightDataList" multiple="multiple" size="10" style="width:150px;overflow-y: auto;" class="form-control">
				          <c:forEach items="${assignList}" var="role">
				          <option value="${role.id}">${role.name}</option>
				          </c:forEach>
				      </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>没有默认类</h4>
				<p>未实现该功能</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
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
			    
			    
			    
			    $("#left2rightBtn").click(function(){
			    	
			    	var leftData = $("#leftDataList :selected");
					if(leftData.length == 0){
						layer.msg("请选择", {time : 1000,icon : 5,shift : 6});
						return;
					}
			    	
			    	var dataObj = {"userid": ${user.id} };
			    	
			    	$.each(leftData,function(i , n){
			    		dataObj["ids["+i+"]"] = n.value;
			    	});
			    	$.ajax({
			    		url : "${APP_PATH}/user/insertAssign.do",
			    		type :"POST",
			    		data : dataObj,
			    		success : function(result){
			    			if(result.success){
			    				$("#rightDataList").append(leftData);
			    				layer.msg("角色添加成功", {time : 1000,icon : 6,shift : 6});
			    			}else{
			    				layer.msg("角色添加失败", {time : 1000,icon : 5,shift : 6});
			    			}
			    		}
			    	});
			    });
			    
			    
			    
			    $("#right2leftBtn").click(function(){
			    	var rightData = $("#rightDataList :selected");
			    	
					if(rightData.length == 0){
						layer.msg("请选择", {time : 1000,icon : 5,shift : 6});
						return;
					}
			    	
                    var dataObj = {"userid": ${user.id}};
			    	
			    	$.each(rightData,function(i , n){
			    		dataObj["ids["+i+"]"] = n.value;
			    	});
			    	$.ajax({
			    		url : "${APP_PATH}/user/deleteAssign.do",
			    		type :"POST",
			    		data : dataObj,
			    		success : function(result){
			    			if(result.success){
			    				$("#leftDataList").append(rightData);
			    				layer.msg("角色删除成功", {time : 1000,icon : 6,shift : 6});
			    			}else{
			    				layer.msg("角色删除失败", {time : 1000,icon : 5,shift : 6});
			    			}
			    		}
			    	});
			    });
			   
            });
            
          
           
            
        </script>
  </body>
</html>
