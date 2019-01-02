<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<img alt="LOGO" src="${APP_PATH}/img/logo.png">
  <form action="login.htm" method="post">
   	 用户账号 : <input type="text" id="fuser" name="loginacct"><br>
   	 用户密码 : <input type="password" id="fpwd" name="password"><br>
   	 <input id="loginBtn" type="button" value="登录">
  </form>
</body>
<script type="text/javascript" src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
	$("#loginBtn").click(function(){
		
		var username = $("#fuser").val();
		if(username == ""){
			alert("账户名不能为空");
			$("#fuser").focus();
			return;
		}
		
		var password = $("#fpwd").val();
		if(password == ""){
			alert("密码不能为空");
			$("#fpwd").focus();
			return;
		}
		
		$.ajax({
			url : "${APP_PATH}/doLogin.do",
			type : "POST",
			data : {
				"loginacct" :  username   ,
				"password" : password
			},
			success : function(result){
				if(result.success){
					window.location.href = "${APP_PATH}/login.htm";
				}else{
					alert(result.error);
				}
			}
			
		});
	});
</script>
</html>