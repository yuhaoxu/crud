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
<h2>注册界面</h2>
</div>
</div>
<form id="register_checked" class="form-horizontal">
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
  <button class="btn btn-default col-md-offset-3" type="submit" id="register_to">注册</button>
    <button class="btn btn-default" type="button" id="return_login">返回</button>
 </div>   
  <script type="text/javascript">
$(function(){
	  $("#return_login").click(function(){
		  location.href="${APP_PATH}/login";
	  });
	  
	  $("#register_to").click(function(){
		  
	if(!validate_add_form()){
				return false;
			}; 
			//.判断之前的ajax用户名校验是否成功
		if($(this).attr("ajax_va")=="error"){
				return false;
			} 
		  $.ajax({
				url:"${APP_PATH}/checkregister",
				type:"POST",
				data:$("#register_checked").serialize(),
				success:function(result){
				//console.log(result);
					if(result.code==100){
						//1.注册成功
						alert("注册成功")
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示哪个字段
						if(undefined!=result.extend.errorFields.username){
							//显示邮箱的错误信息
							show_validate_msg("#username","error",result.extend.errorFields.username);
						}
						if(undefined!=result.extend.errorFields.password){
							//显示名字的错误信息
							show_validate_msg("#password","error",result.extend.errorFields.password);
						}
					}
				}			  
		  }); 
		  
		  //alert($("#register_checked").serialize());
	  });
	  
		//校验表单数据
		function validate_add_form() {
			//1.先拿到要校验的数据，使用正则表达式
			var username=$("#username").val();
			var regName=/^[a-zA-Z0-9_-]{3,10}$/;
			if(!regName.test(username)){
				show_validate_msg("#username","error","用户名可以是3-10位英文字母和数字的组合");
				return false;
			}else{
				show_validate_msg("#username","success","");
			};
			
			//2.校验邮箱信息
			var password=$("#password").val();
			var regpassword=/^[a-z0-9_-]{3,13}$/ ;
			if(!regpassword.test(password)){
				//alert("邮箱格式不正确");
				show_validate_msg("#password","error","密码必须是3-13位小写英文和数字的组合");			
				return false;
			}else{
				show_validate_msg("#password","success","");	
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg) {
			//清楚当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);			
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验用户名是否可用
		$("#username").change(function(){
			//发送ajax请求校验用户名是否可用
			var username=this.value;
			$.ajax({
				url:"${APP_PATH}/checkusername",
				data:"username="+username,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#username","success","用户名可用");
						$("#register_to").attr("ajax_va","success");
					}else{
						show_validate_msg("#username","error",result.extend.va_msg);
						$("#register_to").attr("ajax_va","error");
					}
				}
				
			});
		});
		
});
  </script>
</body>
</html>