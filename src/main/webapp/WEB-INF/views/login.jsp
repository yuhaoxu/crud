<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<title>Insert title here</title>
<script type="text/javascript"
	src="${APP_PATH }/static/scripts/jquery-1.9.1.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<div class="row">
<div class="col-md-offset-3">
<h2>登陆界面</h2>
</div>
</div>
<form id="login_checked" class="form-horizontal">
  <div class="form-group" >
    <label for="username" class="col-sm-2 control-label">username</label>
    <div class="col-sm-4">
      <input type="text" name="username" class="form-control" id="username" placeholder="username">
       <span id="" class="help-block"></span>
    </div>
  </div>
    <div class="form-group">
    <label for="password" class="col-sm-2 control-label">password</label>
    <div class="col-sm-4">
      <input type="password" name="password" class="form-control" id="password" placeholder="password">
       <span id="" class="help-block"></span>
    </div>
  </div>
  </form>
  <button class="btn btn-default col-md-offset-3" type="submit" id="login_in">登陆</button>
    <button class="btn btn-default" type="button" id="register_in">注册</button>
 </div>   
  <script type="text/javascript">
  
  $(function(){
	  $("#login_in").click(function(){
		  
		  $.ajax({
				url:"${APP_PATH}/checkLogin",
				type:"POST",
				data:$("#login_checked").serialize(),
				success:function(result){
				//console.log(result);
				if(result.code==100){
					location.href="${APP_PATH}/list";
				}else if(result.code==200){
					alert("您输入的用户名或者密码有误");
					location.href="${APP_PATH}/login";
				}
				}			  
		  });
	  });
  });
    
  $("#register_in").click(function(){
	  location.href="${APP_PATH}/register";
  });
  </script>
</body>
</html>