<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">
        var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
    </script>
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<script src="static/js/platform/password/syspassword.js" type="text/javascript"></script>
<body>
<div id = "main" style="width:100%;">
	<form id="passwordEditForm" name="passwordEditForm" method="post" >
				<table  style="width: 100%;padding-top: 10px;">
					<tr>
						<th align="right" style="width: 100px;"><label >原密码：</label></th>
						<td>
							  <input class="easyui-validatebox" type="password" data-options="required:true,validType:length[0,50]"  name="oldPassword" id="oldPassword" style="width: 180px;" ></input>
						</td>
					</tr>												
					<tr>
						<th align="right"><label >新密码：</label></th>
						<td>
							  <input class="easyui-validatebox" type="password" data-options="required:true,validType:length[0,50]"  name="newPassword" id="newPassword" style="width: 180px;" ></input>
						</td>
					</tr>
					<tr>
						<th align="right"><label >确认密码：</label></th>
						<td>
							  <input class="easyui-validatebox" type="password" data-options="required:true,validType:length[0,50]"  name="confirmPassword" id="confirmPassword" style="width: 180px;" ></input>
						</td>
					</tr>
				</table>
	</form>
<div id="tipContent">
	
</div>
	<div style="text-align: center">
		<div style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; margin-top: 10px;">
			<button id="confirmBtn" onclick="changePassword();" >确认</button>
			<button id="confirmBtn" onclick="closeParentDialog('0');" >取消</button>
		</div>
	</div>
	</div>
</body>
</html>

