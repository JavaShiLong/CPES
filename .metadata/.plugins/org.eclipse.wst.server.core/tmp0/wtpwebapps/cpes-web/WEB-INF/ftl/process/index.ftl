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

    <nav class="navbar navbar-inverse navbar-fixed-top" process="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><img src="${APP_PATH}/img/logo.png" width="100" style="float:left;margin-top:5px;"><a class="navbar-brand" style="font-size:32px;" href="#">认证流程审批系统</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<#include 'common/userinfo.ftl'>
			</li>
            <li style="margin-left:10px;padding-top:8px;">
				<button type="button" class="btn btn-default btn-danger">
				  <span class="glyphicon glyphicon-question-sign"></span> 帮助
				</button>
			</li>
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
			    <#include 'common/menu.ftl'>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deleteProcesses()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button id="uploadBtn" type="button" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 上传</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="processTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input id="allBox" type="checkbox"></th>
                  <th>流程名称</th>
                  <th>流程标识</th>
                  <th>流程版本</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
				        <div id="Pagination" class="pagination">
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
    <form id="uploadForm" action="${APP_PATH}/process/deployProdDef.do" method="post" enctype="multipart/form-data">
        <input type="file" id="fprocDefFile" name="procDefFile" style="display:none;" >
    </form>
    
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
	<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
	<script src="${APP_PATH}/jquery/jquery-form.min.js"></script>
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
            
            $("#allBox").click(function(){
            	// 获取全选框的选中状态
            	//var flg = this.checked;
            	var that = this;
            	// 将每一个用户复选框的状态和全选框保持一致
            	//$.each(集合，回调方法);
            	$("#processTable tbody :checkbox").each(function(i, checkbox){
            		checkbox.checked = that.checked;
            	});
            });
            
          $("#uploadBtn").click(function(){
          		 $("#fprocDefFile").click();
          });
            
            $("#fprocDefFile").change(function(event){
            
                // 判断上传文件的大小
                var files = event.target.files, file;
                if (files && files.length > 0) {
                    file = files[0]; 
                }
                
                if ( file.size >= 2 * 1024 * 1024 ) {
                    layer.msg("流程定义文件超出了指定的大小：2M，请重新选择文件", {time:2000, icon:5, shift:6});
                    return;
                }
            
                // 提交文件上传表单
                var loadingIndex = -1;
		    	$("#uploadForm").ajaxSubmit({
		    		beforeSubmit : function() {
		    			loadingIndex = layer.load(2, {time: 10*1000});
		    		},
		    		success : function( r ) {
		    			layer.close(loadingIndex);
		    			if ( r.success ) {
		    				layer.msg("流程定义部署成功", {time:1000, icon:6}, function(){
		    				    pageQuery(0);
		    				    // 重置文件域对象
		    				    $("#uploadForm")[0].reset();
		    				});
		    			} else {
		    	    		layer.msg("流程定义部署失败", {time:1000, icon:5, shift:6});
		    			}
		    		}
		    	});
            });
            var loadingIndex = -1;
            var pageSize = 10;
            function pageQuery( pageIndex ) {
            	
            
            	
            	var dataObj = {"pageNo" : pageIndex+1,"pageSize" : pageSize};
         
            	
            	$.ajax({
            		url : "${APP_PATH}/process/pageQuery.do",
            		type : "POST",
            		data : dataObj,
            		beforeSend : function() {
            			loadingIndex = layer.load(2, {time: 10*1000});
            		},
            		success : function( r ) {
            			layer.close(loadingIndex);
            			if ( r.success ) {
            				// 页面渲染
            				var pageObj = r.page;
            				// 循环遍历
            				var content = "";
            				$.each(pageObj.datas, function(index, process){
            					// 相同类型的引号不能嵌套使用
	            	            content += '<tr>';
	          	                content += '  <td>'+(index+1)+'</td>';
	          					content += '  <td><input type="checkbox" value="'+process.id+'"></td>';
	          	                content += '  <td>'+process.name+'</td>';
	          	                content += '  <td>'+process.id+'</td>';
	          	                content += '  <td>'+process.version+'</td>';
	          	                content += '  <td>';
	          					content += '      <button type="button" onclick="window.location.href=\'${APP_PATH}/process/show/'+process.id+'.htm\'"class="btn btn-success btn-xs"><i class="glyphicon glyphicon-apple"></i></button>';
	          					content += '	  <button type="button" onclick="deleteProcess(\''+process.id+'\', \''+process.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
	          					content += '  </td>';
	          	                content += '</tr>';
            				});
            			
            				$("#processTable tbody").html(content);
            				
            				// 分页查询会在初始化后默认查询第一页的数据
            				// 由于实现方式不一样，所以需要注释掉插件中的查询第一页的方法（L158）
            				$("#Pagination").pagination(pageObj.totalSize, {
            					num_edge_entries: 2, //边缘页数
            					num_display_entries: 3, //主体页数
            					current_page: pageIndex,// 当前页码索引
            					callback: pageQuery,
            					prev_text:"上一页",
            					next_text:"下一页",
            					items_per_page:pageSize //每页显示数据条数
            				});
            			} else {
            	    		layer.msg("分页查询失败", {time:1000, icon:5, shift:6});
            			}
            		}
            	});
            }
            
            function deleteProcess(id, name) {
    			layer.confirm("删除流程信息"+name+"，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "${APP_PATH}/process/deleteProcess.do",
    					type : "POST",
    					data : {
    						id : id
    					},
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("数据删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("数据删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
            
            function deleteProcesses() {
            	var selBox = $("#processTable tbody :checked");
            	var len = selBox.length;
            	if ( len == 0 ) {
            		layer.msg("请选择需要删除的流程信息", {time:1000, icon:5, shift:6});
            		return;
            	}
    			layer.confirm("删除选择的流程信息，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				var dataObj = {};
    				$.each(selBox, function(i, n){
    					dataObj["keys["+i+"]"] = n.value;
    				});
    				
    				$.ajax({
    					url : "${APP_PATH}/process/deleteProcesses.do",
    					type : "POST",
    					data : dataObj,
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("数据删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("数据删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
        </script>
  </body>
</html>