<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
			  <div class="modal-body">
				<form id="updateForm" action="${APP_PATH}/permission/updatePermission.do" method="post" role="form">
				  <input type="hidden" name="id" value="${permission.id}">
				  <div class="form-group">
					<label for="exampleInputEmail1">许可名称</label>
					<input type="email" class="form-control" id="fname" name="name" value="${permission.name }" placeholder="请输入许可名称">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">链接地址</label>
					<input type="email" class="form-control" id="furl" name="url" value="${permission.url }" placeholder="请输入链接地址">
				  </div>
				</form>
			  </div>
		  <div class="modal-footer">
                  <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
				  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
		  </div>
<script>
	$(function(){
		
	    $("#resetBtn").click(function(){
	    	$("#updateForm")[0].reset();
	    });
	    
	    
	    $("#updateBtn").click(function(){
	    	var username = $("#fname").val();
			if (username == "") {
				layer.msg("许可名不能为空", {time : 1000,icon : 5,shift : 6}, function() {
					$("#fname").focus();
				});
				return;
			}
			
			var loadingIndex = 0;
		
			$("#updateForm").ajaxSubmit({
				beforeSubmit :function(){
					loadingIndex = layer.msg("请求处理中", {icon : 16});
				},
				success : function(result){
					layer.close(loadingIndex);
					if(result.success){
						$(".close").click();
						layer.msg("恭喜操作成功", {time : 1000,icon : 6,shift : 6});
						var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
		  				treeObj.reAsyncChildNodes(null, "refresh");
					}else{
						layer.msg("许可更新失败", {time : 1000,icon : 5,shift : 6});
					}
				}
			});
	    	
	    });
		
	});
</script>