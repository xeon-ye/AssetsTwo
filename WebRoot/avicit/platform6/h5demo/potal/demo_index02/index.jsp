<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%
String skinsValue =  (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN_TYPE);
if(StringUtils.isEmpty(skinsValue)){
	 skinsValue = "blue";
}
%>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>demo1</title>
<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css"/>
<link rel="stylesheet" href="avicit/platform6/h5demo/potal/demo_index02/css/index.css" />
<link id = "portlet-skin" rel="stylesheet" href="avicit/platform6/portal/portlet/skin/<%=skinsValue %>-portlet.css">
<style type="text/css">
.content-empty:after,
.content-empty:before{
  content:"" !important;
}
</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body style="position: relative; background: #eceff4;margin: -7px;overflow-x: hidden;">
		<div class="warpper">
			<div class="pos_re">
				<div class="pos_left">
					<div class="box">
						<iframe src="../../../../../bpm/todo/portal/waittodo?pageSize=8" frameborder="0" style="width: 100%;border: 0;height: 325px;"></iframe>
					</div>
					<div class="box">
						<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/bulletin.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
					</div>
				</div>
				<div class="pos_right">
					<div class="box">
						<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart01.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
					</div>
					<div class="box">
						<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart02.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
					</div>
				</div>
			</div>
			<div class="layout_box clearfix">
				<div class="box" style="width: 32.5%;float: left;">
					<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart03.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
				</div>
				<div class="box" style="width: 32.5%;float: left;">
					<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart04.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
				</div>
				<div class="box" style="width: 32.5%;float: left;">
					<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart05.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
				</div>
			</div>
			<div class="layout_box clearfix">
				<div class="pos_left">
					<div class="box">
						<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart06.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
					</div>
				</div>
				<div class="pos_right">
					<div class="box">
						<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/chart07.html" frameborder="0" style="width: 100%;border: 0; height: 325px;"></iframe>
					</div>
				</div>
			</div>
			<div class="layout_box">
				<div class="box">
					<iframe src="avicit/platform6/h5demo/potal/demo_index02/page/task.html" frameborder="0" style="width: 100%;border: 0;height:310px;"></iframe>
				</div>
			</div>
		</div>
	</body>

</html>